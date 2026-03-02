FROM php:8.2-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y sendmail libpng-dev libzip-dev zlib1g-dev libonig-dev \
    && docker-php-ext-install mysqli zip mbstring gd \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# Copiar tu proyecto PHP al contenedor
COPY php/ /var/www/html/

# Puerto dinámico para Render
CMD ["sh", "-c", "sed -i \"s/80/${PORT:-80}/g\" /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf && apache2-foreground"]