FROM php:7.1-apache

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        zlib1g-dev \
    && pecl install memcached \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo mysqli \
    && docker-php-ext-enable memcached opcache

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires
