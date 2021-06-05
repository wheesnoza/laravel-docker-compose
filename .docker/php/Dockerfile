FROM php:8.0-fpm-alpine

RUN apk --update-cache --no-cache add libzip-dev unzip git && rm -rf /var/cache/apk/* \
    && docker-php-ext-install pdo pdo_mysql zip

RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install redis
