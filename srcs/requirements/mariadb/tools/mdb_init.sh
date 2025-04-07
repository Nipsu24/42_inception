#!/bin/ash

# Initialize database directory if it doesn't already exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
else
    echo "Database directory already initialized."
fi

# Run initialization SQL commands
echo "Running database initialization..."
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Drop the test database if it exists
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';

-- Remove root users that are not localhost
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Create user if it doesn't exist
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';

-- Grant privileges
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;
GRANT SELECT ON mysql.* TO '$DB_USER'@'%';

-- Update root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';

-- Apply changes
FLUSH PRIVILEGES;
EOF

# Start MariaDB in the foreground as the main process
echo "Starting MariaDB in the foreground..."
exec mysqld --defaults-file=/etc/my.cnf.d/mariadb-server.cnf

