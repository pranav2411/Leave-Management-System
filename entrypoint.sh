#!/bin/bash

# Ensure MySQL data directory permissions are correct
usermod -d /var/lib/mysql/ mysql
chown -R mysql:mysql /var/lib/mysql

echo "Starting MySQL..."
service mysql start

# Wait for MySQL to start
echo "Waiting for MySQL to accept connections..."
until mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

# Initialize database schema and set root password
echo "Initializing Database..."
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"
mysql -u root -proot < /opt/database.sql

echo "Database initialized successfully."

# Start Tomcat in the foreground
echo "Starting Apache Tomcat..."
exec /opt/tomcat/bin/catalina.sh run
