#!/bin/bash

# Create Tomcat-compliant directory structure
echo "Creating directory structure..."
mkdir -p WEB-INF/classes/com/lms/servlet
mkdir -p WEB-INF/lib

# Move Servlet class files to the correct package directory
echo "Moving compiled classes to WEB-INF/classes/com/lms/servlet/..."
mv ApplyLeaveServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/ApplyLeaveServlet.class . 2>/dev/null
mv LoginServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/LoginServlet.class . 2>/dev/null
mv ManageLeaveServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/ManageLeaveServlet.class . 2>/dev/null
mv RegisterServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/RegisterServlet.class . 2>/dev/null
mv UpdateLeaveServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/UpdateLeaveServlet.class . 2>/dev/null
mv ViewStatusServlet.class WEB-INF/classes/com/lms/servlet/ 2>/dev/null || cp WEB-INF/classes/com/lms/servlet/ViewStatusServlet.class . 2>/dev/null

# Move web.xml to WEB-INF
echo "Moving web.xml to WEB-INF..."
mv web.xml WEB-INF/ 2>/dev/null || cp WEB-INF/web.xml . 2>/dev/null

echo "Done! The project is now structured for deployment."
echo "Please remember to:"
echo "1. Download the MySQL JDBC driver (mysql-connector-java.jar) and place it in WEB-INF/lib/"
echo "2. Deploy the root directory to your Apache Tomcat (Version 9) webapps folder."
