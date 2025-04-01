#!/bin/ash

# wait for mdb_init.sh to finish
until mysqladmin ping -h"$DB_HOST" --silent -u"${DB_USER}" -p"${DB_PASS}"; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
done

chown -R www:www /var/www/html
chmod -R 755 /var/www/html

if [ ! -f wp-config.php ]; then
rm -rf /var/www/html/*

# autofill wp startup fields
wp core download --path=/var/www/html --allow-root
wp config create \
	--allow-root \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASS \
	--dbhost=$DB_HOST \
	--path=/var/www/html

wp core install \
	--allow-root \
	--path=/var/www/html \
	--skip-email \
	--url="https://$DOMAIN_NAME" \
	--title=$WP_TITLE \
	--admin_user=$ADM_WP_NAME \
	--admin_password=$ADM_WP_PASS \
	--admin_email=$ADM_WP_EMAIL

fi

wp user create \
	--allow-root \
	--path="/var/www/html" \
	"${WP_USERNAME}" "${WP_USEREMAIL}" \
	--role=author \
	--user_pass=$WP_USERPASS 

#launch php-fpm
exec /usr/sbin/php-fpm82 -F
