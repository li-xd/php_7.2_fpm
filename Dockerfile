FROM php:7.2-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd xdebug redis intl swoole zookeeper pcntl opcache

RUN apk add  --update alpine-sdk cmake bsd-compat-headers make 

