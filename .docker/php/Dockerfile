FROM php:7.3-fpm-alpine

RUN apk --update-cache --no-cache add zip unzip git \
    && rm -rf /var/cache/apk/*

RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install pdo pdo_mysql redis
