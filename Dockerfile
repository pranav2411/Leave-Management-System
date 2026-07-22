FROM tomcat:9.0-jdk11-alpine

# Install MariaDB (extremely lightweight) and curl
RUN apk add --no-cache \
    mariadb \
    mariadb-client \
    curl

# Download MySQL JDBC driver directly into Tomcat's global library folder
RUN curl -L -o /usr/local/tomcat/lib/mysql-connector-java-8.0.28.jar \
    https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar

# Copy low-memory configuration for MariaDB/MySQL
COPY mysql_low_mem.cnf /etc/mysql/conf.d/low_mem.cnf

# Set Tomcat JVM options to limit memory usage for Render's free tier
ENV CATALINA_OPTS="-Xms128m -Xmx256m -XX:MaxMetaspaceSize=128m"

# Prepare webapp directory
WORKDIR /app
COPY . .

# Structure the webapp files inside Tomcat's ROOT directory
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/com/lms/servlet \
    && mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/lib \
    && cp -r /app/WEB-INF/* /usr/local/tomcat/webapps/ROOT/WEB-INF/ 2>/dev/null || true \
    && cp /app/*.jsp /usr/local/tomcat/webapps/ROOT/ 2>/dev/null || true \
    && cp /app/web.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/ 2>/dev/null || true \
    && cp /app/*.class /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/com/lms/servlet/ 2>/dev/null || true \
    && rm -rf /usr/local/tomcat/webapps/ROOT/*.class /usr/local/tomcat/webapps/ROOT/web.xml

# Copy DB schema and entrypoint script
COPY database.sql /opt/database.sql
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Expose Tomcat port
EXPOSE 8080

ENTRYPOINT ["/opt/entrypoint.sh"]
