FROM php:7.2-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd xdebug redis intl swoole zookeeper pcntl opcache

RUN apk add  --update alpine-sdk cmake bsd-compat-headers make m4 perl perl-error perl-git git-perl autoconf dpkg dpkg-dev re2c && phpize && \
./configure --with-php-config=/usr/local/bin/php-config --with-libqconf-dir=/usr/local/include/qconf --enable-static LDFLAGS=/usr/local/lib/libqconf.a && \
make && make install && rm -rf /tmp/* && docker-php-ext-enable qconf
