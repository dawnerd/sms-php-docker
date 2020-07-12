FROM php:7.4-apache

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        zlib1g-dev \
    && pecl install memcached \
    && pecl install mcrypt-1.0.3 \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo mysqli \
    && docker-php-ext-enable memcached opcache mcrypt

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires
