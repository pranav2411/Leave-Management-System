#!/bin/sh

# Ensure MariaDB runtime and data directories exist with correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialize MariaDB data directory if not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null
fi

# Start MariaDB in the background
echo "Starting MariaDB..."
mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking=0 &

# Wait for MariaDB to accept connections
echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
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
