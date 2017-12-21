#
# Dockerfile for OpenCart to setup
#

FROM php:7.1-apache
MAINTAINER wesley <tiankai_13@aliyun.com>

RUN a2enmod rewrite

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev libmcrypt-dev zip unzip vim \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && cd /var/www/html/ \
    && su -c "composer create-project opencart/opencart" -s /bin/sh www-data 

COPY bin/setup /usr/local/bin/

RUN set -xe \
    && chmod u+x /usr/local/bin/setup