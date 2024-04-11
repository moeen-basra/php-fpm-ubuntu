This repository contains docker image based ubuntu including the php-fpm 8.3, nodejs 20lts, npm latest, nginx and following Linux and PHP along with composer extensions

If you want to change the php or node version you can pass the build arguments
PHP_VERSION
NODE_VERSION
NPM_VERSION

**Linux**

1. nginx
2. bash-completion
3. zlib1g-dev
4. librabbitmq-dev
5. libpq-dev
6. libmemcached-dev
7. libmemcached11
8. postgresql-client
9. git
10. unzip
11. zip
12. supervisor

**PHP**

1. gd
2. pcntl
3. opcache
4. pdo
5. pdo_pgsql
6. pgsql
7. redis
8. bcmath
9. intl
10. zip
11. sockets
12. igbinary
13. memcached
14. xdebug

The xdebug is disabled by default you can enable it by simply adding the following line in your docker file

```Dockerfile
RUN docker-php-ext-enable xdebug >/dev/null
```
