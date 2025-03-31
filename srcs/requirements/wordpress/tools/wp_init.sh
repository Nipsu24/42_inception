#!/bin/ash

# wait for mdb_init.sh to finish
until mysqladmin ping -h"$DB_HOST" --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
done

# autofill wp startup fields
wp core download --path="/var/www/html" --allow-root
wp config create --path="/var/www/html" --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --skip-check
wp core install --path="/var/www/html" --allow-root --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$ADM_WP_NAME --admin_password=$ADM_WP_PASS --admin_email=$ADM_WP_EMAIL --skip-email
wp user create --path="/var/www/html" --allow-root $WP_USERNAME $WP_USEREMAIL --user_pass=$WP_USERPASS --role='contributor'

#launch php-fpm
exec /usr/sbin/php-fpm7.4 -F