ARG PHP_VERSION=8.3

FROM php:$PHP_VERSION-fpm

ARG NODE_VERSION=20.x
ARG NPM_VERSION=latest

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx nano vim bash-completion zlib1g-dev librabbitmq-dev libpq-dev \
    libmemcached-dev libmemcached11 postgresql-client git unzip zip supervisor && \
    # node
    curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | bash - && \
    apt-get install -y nodejs && npm install npm@$NPM_VERSION -g && \
    # cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # make install-php-extensions executable
    chmod +x /usr/local/bin/install-php-extensions && \
    # Install the PHP extensions
    install-php-extensions gd pcntl opcache pdo pdo_pgsql pgsql redis bcmath intl zip sockets \
    # PECL extensions
    && pecl install igbinary \
    memcached \
    xdebug && \
    docker-php-ext-enable igbinary memcached >/dev/null

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root/.composer
ENV PATH $PATH:/root/.composer/vendor/bin
ENV SHELL /bin/bash

RUN composer config --global process-timeout 3600

WORKDIR /root
RUN git clone https://github.com/seebi/dircolors-solarized