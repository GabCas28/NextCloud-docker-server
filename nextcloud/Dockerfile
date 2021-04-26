FROM nextcloud:fpm

WORKDIR /app

COPY ./docker-settings.sh .

RUN chmod +rwx ./docker-settings.sh

WORKDIR /var/www/html

CMD ["php-fpm"]
