FROM php:8.3-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia solo i file essenziali per l'applicazione PHP (usando .dockerignore)
COPY . .

RUN composer install --optimize-autoloader

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN /root/.symfony5/bin/symfony console doctrine:database:create
RUN /root/.symfony5/bin/symfony console doctrine:schema:create

RUN PATH=$PATH:/var/www/html/bin:/var/www/html/vendor/bin

EXPOSE 9000

CMD ["php-fpm"]