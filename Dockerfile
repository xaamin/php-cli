FROM xaamin/ubuntu:18.04
MAINTAINER Benjamín Martínez Mateos <xaamin@outlook.com>

# Install PHP7 AND popular required extensions
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php7.4-cli \
        php7.4-bz2 \
        php7.4-common \
        php7.4-curl \
        php7.4-gd \
        php7.4-gmp \
        php7.4-imap \
        php7.4-intl \
        php7.4-ldap \
        php7.4-json \
        php7.4-mbstring \
        php7.4-mysql \
        php7.4-opcache \
        php7.4-pgsql \
        php7.4-readline \
        php7.4-sybase \
        php7.4-soap \
        php7.4-sqlite3 \
        php7.4-tidy \
        php7.4-xml \
        php7.4-xmlrpc \
        php7.4-xsl \
        php7.4-zip \
        php-geoip \
        php-imagick \
        php-memcached \
        php-mongodb \
        php-redis \
        php-xdebug \
    # Remove temp files
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/7.4/cli/php.ini

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