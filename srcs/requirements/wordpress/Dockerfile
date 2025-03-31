# Use Alpine Linux base image
FROM alpine:3.20.6

# Update and install necessary packages
RUN apk update && apk upgrade && \
	apk add --no-cache \
		php81 \
		php81-fpm \
		php81-mysqli \
		curl

# Download and configure WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM pool configuration
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# Create necessary directories
RUN mkdir -p /run/php
WORKDIR /var/www/wordpress/

# Copy setup script and make it executable
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh

# Expose required port
EXPOSE 9000

# Launch setup script at startup
ENTRYPOINT ["/usr/local/bin/wp_init.sh"]
