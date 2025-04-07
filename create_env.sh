#!/bin/ash

ENV_FILE="./srcs/.env"

LOGIN=""
WP_USERNAME=""
WP_ADM_NAME=""

DB_PASS=""
DB_ROOT_PASS=""
WP_USERPASS=""
WP_ADM_PASS=""

# Check if any required variables are empty
if [[ -z "$LOGIN" || -z "$WP_USERNAME" || -z "$WP_ADM_NAME" || -z "$DB_PASS" || -z "$DB_ROOT_PASS" || -z "$WP_USERPASS" || -z "$WP_ADM_PASS" ]]; then
    echo "Error: One or more required variables are empty."
    echo "Please set the following variables in the script:"
    echo " LOGIN, WP_USERNAME, WP_ADM_NAME, DB_PASS, DB_ROOT_PASS, WP_USERPASS, WP_ADM_PASS"
    exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
	echo "LOGIN=$LOGIN" >> "$ENV_FILE"
	echo "DOMAIN_NAME=$LOGIN.42.fr" >> "$ENV_FILE"
	echo "CERT_=./requirements/tools/$LOGIN.42.fr.crt" >> "$ENV_FILE"
	echo "KEY_=./requirements/tools/$LOGIN.42.fr.key" >> "$ENV_FILE"
	echo "DB_NAME=wordpress" >> "$ENV_FILE"
	echo "DB_USER=wpuser" >> "$ENV_FILE"
	echo "DB_HOST=mariadb" >> "$ENV_FILE"
	echo "WP_TITLE=INCEPTION_$LOGIN" >> "$ENV_FILE"
	echo "WP_USERNAME=$WP_USERNAME" >> "$ENV_FILE"
	echo "WP_USEREMAIL=$WP_USERNAME@42.fr" >> "$ENV_FILE"
	echo "WP_USERPASS=$WP_USERPASS" >> "$ENV_FILE"
	echo "WP_HOST=$LOGIN.42.fr" >> "$ENV_FILE"
	echo "ADM_WP_NAME=$WP_ADM_NAME" >> "$ENV_FILE"
	echo "ADM_WP_EMAIL=$WP_ADM_NAME@42.fr" >> "$ENV_FILE"
	echo "DB_ROOT_PASS=$DB_ROOT_PASS" >> "$ENV_FILE"
	echo "DB_PASS=$DB_PASS" >> "$ENV_FILE"
	echo "ADM_WP_PASS=$WP_ADM_PASS" >> "$ENV_FILE"
	echo ".env file created."
else
    echo ".env file already exists."
fi
