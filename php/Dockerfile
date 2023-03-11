FROM ubuntu:20.04

USER root

RUN apt-get update -y; \
    printf "8\n34" | apt-get install -y tzdata; \
    apt-get install -y \
    pkg-config \
    build-essential \
    autoconf \
    bison \
    re2c \
    libxml2-dev \
    libsqlite3-dev \
    curl \
    libssl-dev \
    zlib1g-dev \
    libcurl4-gnutls-dev \
    libffi-dev \
    libpng-dev \
    libpq-dev

RUN mkdir /php && \
    curl https://www.php.net/distributions/php-8.1.13.tar.gz --output /php/php.tar.gz && \
    tar -xf /php/php.tar.gz

RUN cd php-8.1.13 && \
    ./buildconf && \
    ./configure --enable-sockets \
    --with-pdo-pgsql \
    --enable-gd \
    --enable-ftp \
    --with-ffi \
    --enable-exif \
    --with-curl \
    --with-zlib \
    --with-openssl \
    --enable-fpm \
    --with-fpm-user=root \
     && \
    make -j4 && \
    make install

COPY ./php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY ./app /www

#RUN mkdir -p /var/run/
#WORKDIR /www

#CMD while true; do echo "hello" --verbose; sleep 1; done

CMD php-fpm -R