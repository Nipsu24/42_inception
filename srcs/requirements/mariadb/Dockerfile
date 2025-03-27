FROM alpine:3.20.6

RUN apk update && apk add --no-cache mariadb mariadb-client

#Copy config file
COPY conf/mariadb.conf /etc/mysql/conf.d/

#Copy script for initialising database
COPY tools/mdb_init /usr/local/bin/mdb_init.sh

#change privileges for script
RUN chmod 755 /usr/local/bin/mdb_init.sh

# Opens port 3306
EXPOSE 3306

#starts MariaDB server and initialises it with SQL commands from init.sql
CMD ["/usr/local/bin/mdb_init.sh"]