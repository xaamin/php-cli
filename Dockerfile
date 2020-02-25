FROM xaamin/ubuntu:16.04
MAINTAINER Benjamín Martínez Mateos <xaamin@outlook.com>

# Install PHP7 AND popular required extensions
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php7.2-cli \
        php7.2-bz2 \
        php7.2-common \
        php7.2-curl \
        php7.2-gd \
        php7.2-gmp \
        php7.2-imap \
        php7.2-intl \
        php7.2-ldap \
        php7.2-json \
        php7.2-mbstring \
        php7.2-mysql \
        php7.2-opcache \
        php7.2-pgsql \
        php7.2-readline \
        php7.2-sybase \
        php7.2-soap \
        php7.2-sqlite3 \
        php7.2-tidy \
        php7.2-xml \
        php7.2-xmlrpc \
        php7.2-xsl \
        php7.2-zip \
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
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/7.2/cli/php.ini

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
RUN phpenmod gmp iconv mcrypt mongodb pdo pgsql sqlite3 readline redis xml xsl
RUN phpdismod xdebug

# Default command
CMD ["/usr/bin/php", "-a"]