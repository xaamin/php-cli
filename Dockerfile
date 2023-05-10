FROM xaamin/ubuntu:22.04
LABEL maintainer="Benjamín Martínez Mateos <xaamin@outlook.com>"

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php8.1-cli \
        php8.1-bz2 \
        php8.1-common \
        php8.1-curl \
        php8.1-gd \
        php8.1-gmp \
        php8.1-imap \
        php8.1-intl \
        php8.1-ldap \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-opcache \
        php8.1-pgsql \
        php8.1-readline \
        php8.1-sybase \
        php8.1-soap \
        php8.1-sqlite3 \
        php8.1-tidy \
        php8.1-xml \
        php8.1-xmlrpc \
        php8.1-xsl \
        php8.1-zip \
        php8.1-imagick \
        php8.1-memcached \
        php8.1-mongodb \
        php8.1-redis \
        php8.1-xdebug \
    # Remove temp files
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/8.1/cli/php.ini

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