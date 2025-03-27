#!/bin/ash

# Ensure the database directory exists and is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background to allow initialization
echo "Starting MariaDB temporarily for initialization..."
mysqld_safe --datadir=/var/lib/mysql &
sleep 5  # Wait for MariaDB to start

# Run initialization SQL commands
echo "Running database initialization..."
mysql -u root <<-EOF
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
    FLUSH PRIVILEGES;
EOF

# Shut down MariaDB gracefully after initialization
 echo "Shutting down MariaDB after initialization..."
 mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown

# Start MariaDB in the foreground as the main process
echo "Starting MariaDB in the foreground..."
exec mysqld_safe --datadir=/var/lib/mysql
