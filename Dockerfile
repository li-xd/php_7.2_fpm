FROM php:7.2-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd xdebug redis intl swoole zookeeper pcntl opcache

RUN apk add  --update alpine-sdk cmake bsd-compat-headers make && \
curl -fSL https://github.com/Qihoo360/QConf/archive/refs/tags/v1.2.3.tar.gz -o /tmp/qconf-1.2.3.tar.gz && \
cd /tmp && \
tar -xf qconf-1.2.3.tar.gz && \
cd QConf-1.2.3/ && mkdir build && cd build/ && cmake .. && make && make install && \
cd ../drive/php/ && phpize && \
./configure --with-php-config=/usr/local/bin/php-config --with-libqconf-dir=/usr/local/include --enable-static LDFLAGS=/usr/local/lib/libqconf.a && \
make && make install && rm -rf /tmp/* && docker-php-ext-enable qconf
