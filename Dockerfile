FROM php:7.2-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd redis intl swoole pcntl opcache

RUN apk add  --update alpine-sdk cmake bsd-compat-headers make m4 perl perl-error perl-git git-perl autoconf dpkg dpkg-dev re2c 

RUN curl -fSL https://github.com/Qihoo360/QConf/archive/refs/tags/v1.2.3.tar.gz -o /tmp/qconf-1.2.3.tar.gz && \
cd /tmp && \
tar -xf qconf-1.2.3.tar.gz && \
cd QConf-1.2.3/ && mkdir build && cd build/ && cmake .. && make && make install && \
cd ../driver/php/  && phpize && \
./configure --with-php-config=/usr/local/bin/php-config --with-libqconf-dir=/usr/local/include/qconf --enable-static LDFLAGS=/usr/local/lib/libqconf.a && \
make && make install && rm -rf /tmp/* && docker-php-ext-enable qconf

RUN install-php-extensions memcached

RUN install-php-extensions zookeeper-0.5.0

RUN install-php-extensions xdebug-2.9.8
