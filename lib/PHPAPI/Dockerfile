# Usa l'immagine ufficiale PHP 8.3 con Apache (leggera)
FROM php:8.3-apache

# Installa solo le estensioni PHP essenziali per ridurre la dimensione dell'immagine
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Installa Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Imposta la directory di lavoro
WORKDIR /var/www/html

# Copia solo i file essenziali per l'applicazione PHP (usando .dockerignore)
COPY . .

# Installa le dipendenze PHP
RUN composer install --no-dev --optimize-autoloader

# Crea la directory per il database e imposta i permessi
RUN mkdir -p /var/www/html/data && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod 777 /var/www/html/data

# Script di avvio per gestire la configurazione
COPY private/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Abilita mod_rewrite per Apache
RUN a2enmod rewrite

# Configura Apache per supportare .htaccess e sicurezza massima
RUN echo '<Directory /var/www/html>\n\
    Options -Indexes +FollowSymLinks -ExecCGI\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/app.conf && \
    a2enconf app

# Configura Apache per massima sicurezza e privacy
RUN echo 'ServerTokens Prod' >> /etc/apache2/apache2.conf && \
    echo 'ServerSignature Off' >> /etc/apache2/apache2.conf && \
    echo 'Header always unset X-Powered-By' >> /etc/apache2/apache2.conf && \
    echo 'Header always unset Server' >> /etc/apache2/apache2.conf && \
    a2enmod headers

# Espone la porta 80
EXPOSE 80

# Comando di avvio
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
