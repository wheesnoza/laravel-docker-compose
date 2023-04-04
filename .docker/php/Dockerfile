FROM php:8.2.3-fpm-alpine3.17

# Install system dependencies
RUN apk --update-cache --no-cache add \
    libzip-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    npm \
    autoconf \
    gcc \
    g++ \
    make

# Clear cache
RUN rm -rf /var/cache/apk/*

# Install PHP extensions
RUN docker-php-ext-install \
    bcmath \
    pdo_mysql

# Install redis
RUN pecl install redis && docker-php-ext-enable redis

# Set working directory
WORKDIR /app

# Permission configurations
ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel

RUN sed -i "s/user = www-data/user = laravel/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = laravel/g" /usr/local/etc/php-fpm.d/www.conf

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install pnpm
RUN npm install -g pnpm

USER laravel