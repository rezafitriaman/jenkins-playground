FROM remote-host

# Switch to root to install system packages
USER root

RUN yum -y update && yum -y install nginx php-fpm php-pgsql

EXPOSE 80 443 22

VOLUME /var/www/html /var/log/nginx /var/log/php-fpm /var/lib/php-fpm

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./bin/start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]