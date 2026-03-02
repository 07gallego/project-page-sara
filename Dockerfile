FROM  php:8.2-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-install mysqli

RUN apt-get update \
    && apt-get install -y sendmail libpng-dev \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libonig-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gd

RUN a2enmod rewrite

# Copiar tu proyecto PHP al contenedor
COPY php/ /var/www/html/


# Puerto dinámico para Render
CMD ["sh", "-c", "sed -i \"s/80/${PORT:-80}/g\" /etc/apache2/ports.conf /etc/apache2/sites-enabled/000-default.conf && apache2-foreground"]