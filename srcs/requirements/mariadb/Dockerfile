FROM alpine:3.20.6

# Install MariaDB and client tools
RUN apk update && apk add --no-cache mariadb mariadb-client

# Copy custom configuration file
COPY conf/mariadb.conf /etc/my.cnf.d/mariadb.conf

# Copy initialization script
COPY tools/mdb_init.sh /docker-entrypoint-initdb.d/mdb_init.sh
RUN chmod +x /docker-entrypoint-initdb.d/mdb_init.sh

# Create necessary directories for MariaDB
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Expose port 3306
EXPOSE 3306

# Start MariaDB server
CMD ["mysqld", "--user=mysql", "--console"]
