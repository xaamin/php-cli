FROM xaamin/ubuntu:20.04
LABEL maintainer="Benjamín Martínez Mateos <xaamin@outlook.com>"

# Install PHP7 AND popular required extensions
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php8.0-cli \
        php8.0-bz2 \
        php8.0-common \
        php8.0-curl \
        php8.0-gd \
        php8.0-gmp \
        php8.0-imap \
        php8.0-intl \
        php8.0-ldap \
        php8.0-mbstring \
        php8.0-mysql \
        php8.0-opcache \
        php8.0-pgsql \
        php8.0-readline \
        php8.0-sybase \
        php8.0-soap \
        php8.0-sqlite3 \
        php8.0-tidy \
        php8.0-xml \
        php8.0-xmlrpc \
        php8.0-xsl \
        php8.0-zip \
        php8.0-imagick \
        php8.0-memcached \
        php8.0-mongodb \
        php8.0-redis \
        php8.0-xdebug \
    # Remove temp files
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/8.0/cli/php.ini

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

ENV COMPOSER_ALLOW_SUPERUSER 1

# Set composer home
ENV COMPOSER_HOME /tmp

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install phpunit and put binary into $PATH
RUN curl -sSLo phpunit.phar https://phar.phpunit.de/phpunit.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

# Enable modules
RUN phpenmod gmp iconv mongodb pdo pgsql sqlite3 readline redis xml xsl
RUN phpdismod xdebug

# Default command
CMD ["/usr/bin/php", "-a"]