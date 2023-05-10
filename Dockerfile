FROM xaamin/ubuntu:22.04
LABEL maintainer="Benjamín Martínez Mateos <xaamin@outlook.com>"

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php8.2-cli \
        php8.2-bz2 \
        php8.2-common \
        php8.2-curl \
        php8.2-gd \
        php8.2-gmp \
        php8.2-imap \
        php8.2-intl \
        php8.2-ldap \
        php8.2-mbstring \
        php8.2-mysql \
        php8.2-opcache \
        php8.2-pgsql \
        php8.2-readline \
        php8.2-sybase \
        php8.2-soap \
        php8.2-sqlite3 \
        php8.2-tidy \
        php8.2-xml \
        php8.2-xmlrpc \
        php8.2-xsl \
        php8.2-zip \
        php8.2-imagick \
        php8.2-memcached \
        php8.2-mongodb \
        php8.2-redis \
        php8.2-xdebug \
    # Remove temp files
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/8.2/cli/php.ini

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