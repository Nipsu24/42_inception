FROM alpine:3.20

#Installs nginx and openssl packages:
RUN apk update && apk upgrade && apk add nginx openssl

#Creates directory for storing SSL certificates and keys
#Creates directory for runtime data (PIDs and other files needed during nginx execution)
RUN mkdir -p /etc/nginx/ssl /run/nginx /var/www/html

#Copy nginx conf files for later modification into container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /etc/nginx /var/www/html

#Generate self-signed certificate, -x509 for SSL/TLS
#-nodes prevents encryption of private key (no passphrase)
RUN openssl req -x509 \
    -nodes \
    -out /etc/nginx/ssl/mmeier.42.fr.crt \
    -keyout /etc/nginx/ssl/mmeier.42.fr.key \
    -subj "/C=FI/ST=/L=Helsinki/O=Hive/OU=42/CN=mmeier42.fr/UID=mmeier"

# Create www-data user and group
RUN addgroup -S www-data || true && adduser -S -G www-data www-data || true

#Sets permissions to ensure web root dir is accessible
#Changes ownership if /var/www/html to Nginx process user (www-data)
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

# opens port 443
EXPOSE 443

CMD [ "nginx", "-g", "daemon off;"]

# Replace <your_domain> with your domain (e.g., $(USERNAME).42.fr), AND testing if it is already there
#openssl req -x509 -newkey rsa:4096 -keyout <your_domain>.key -out <your_domain>.crt -days 365 -nodes
