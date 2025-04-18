FROM alpine:3.20.6

# Installs nginx and openssl packages
RUN apk update && apk upgrade && apk add nginx openssl

# Creates directory for storing SSL certificates and keys
# Creates directory for runtime data (PIDs and other files needed during nginx execution)
RUN mkdir -p /run/nginx /var/www/html

# Copy nginx conf files for later modification into container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /etc/nginx /var/www/html

# Create www-data user and group
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

# Sets permissions to ensure web root dir is accessible
# Changes ownership of /var/www/html to Nginx process user (www-data) (system users that run web server)
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

# Opens port 443
EXPOSE 443

#starts nginx process in the foreground (global directive -g, daemon off) - 
#needed as docker expects main process of container to run in foreground
CMD [ "nginx", "-g", "daemon off;" ]

