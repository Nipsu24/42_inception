FROM alpine:3.20

#Installs nginx and openssl packages:
RUN apk update && apk upgrade && apk add nginx openssl

#Creates directory for storing SSL certificates and keys
#Creates directory for runtime data (PIDs and other files needed during nginx execution)
RUN mkdir -p /etc/nginx/ssl /run/nginx

#Copy nginx conf files for later modification into container
COPY ./conf/nginx.conf /etc/nginx.conf.d
RUN chmod -R 755 /etc/nginx /var/www/html

CMD [ "nginx", "-g", "daemon off;"]