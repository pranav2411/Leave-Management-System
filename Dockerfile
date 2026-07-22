FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies (Java 11, MySQL Server, curl)
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk-headless \
    mysql-server \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Tomcat 9
ENV TOMCAT_VERSION=9.0.91
RUN curl -O https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && tar -xf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && mv apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
    && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Download the MySQL JDBC Driver to Tomcat's global lib folder
RUN curl -L -o /opt/tomcat/lib/mysql-connector-java-8.0.28.jar \
    https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar

# Copy low-memory MySQL configuration
COPY mysql_low_mem.cnf /etc/mysql/conf.d/low_mem.cnf

# Set Tomcat JVM options to limit memory usage (so it stays within Render's free tier limits)
ENV CATALINA_OPTS="-Xms128m -Xmx256m -XX:MaxMetaspaceSize=128m"

# Prepare webapp directory
WORKDIR /app
COPY . .

# Copy and structure application files into Tomcat's ROOT webapp folder
RUN mkdir -p /opt/tomcat/webapps/ROOT/WEB-INF/classes/com/lms/servlet \
    && mkdir -p /opt/tomcat/webapps/ROOT/WEB-INF/lib \
    && cp -r /app/WEB-INF/* /opt/tomcat/webapps/ROOT/WEB-INF/ 2>/dev/null || true \
    && cp /app/*.jsp /opt/tomcat/webapps/ROOT/ 2>/dev/null || true \
    && cp /app/web.xml /opt/tomcat/webapps/ROOT/WEB-INF/ 2>/dev/null || true \
    && cp /app/*.class /opt/tomcat/webapps/ROOT/WEB-INF/classes/com/lms/servlet/ 2>/dev/null || true \
    && rm -f /opt/tomcat/webapps/ROOT/*.class /opt/tomcat/webapps/ROOT/web.xml

# Copy DB schema and entrypoint script
COPY database.sql /opt/database.sql
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Expose Tomcat port
EXPOSE 8080

ENTRYPOINT ["/opt/entrypoint.sh"]
