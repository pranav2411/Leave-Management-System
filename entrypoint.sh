#!/bin/bash

# Ensure MariaDB run and data directories exist with correct permissions
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB/MySQL..."
service mariadb start || service mysql start

# Wait for database to start
echo "Waiting for database to accept connections..."
until mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

# Initialize database schema and set root password
echo "Initializing Database..."
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"
mysql -u root -proot < /opt/database.sql

echo "Database initialized successfully."

# Start Tomcat in the foreground
echo "Starting Apache Tomcat..."
exec /usr/local/tomcat/bin/catalina.sh run
