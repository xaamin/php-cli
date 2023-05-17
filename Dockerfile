ARG tz='UTC'
ARG php_version='8.2'

FROM xaamin/ubuntu:22.04
LABEL maintainer="Benjamín Martínez Mateos <xaamin@outlook.com>"

ARG tz
ARG php_version

ENV TZ=$tz
ENV COMPOSER_HOME=/tmp

RUN set -xe \
    && echo $TZ > /etc/timezone \
    && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt -y update \
    && apt -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php$php_version-cli \
        php$php_version-bz2 \
        php$php_version-common \
        php$php_version-curl \
        php$php_version-gd \
        php$php_version-gmp \
        php$php_version-imap \
        php$php_version-intl \
        php$php_version-ldap \
        php$php_version-mbstring \
        php$php_version-mysql \
        php$php_version-opcache \
        php$php_version-pgsql \
        php$php_version-readline \
        php$php_version-sybase \
        php$php_version-soap \
        php$php_version-sqlite3 \
        php$php_version-tidy \
        php$php_version-xml \
        php$php_version-xmlrpc \
        php$php_version-xsl \
        php$php_version-zip \
        php$php_version-imagick \
        php$php_version-memcached \
        php$php_version-mongodb \
        php$php_version-redis \
        php$php_version-xdebug \
    # Remove temp files
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${TZ}|' /etc/php/$php_version/cli/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable modules
RUN phpenmod gmp iconv mongodb pdo pgsql sqlite3 readline redis xml xsl
RUN phpdismod xdebug

# Default command
CMD ["/usr/bin/php", "-a"]