FROM xaamin/ubuntu:16.04
MAINTAINER Benjamín Martínez Mateos <xaamin@outlook.com>

# Install PHP7 AND popular required extensions
RUN apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php7.1-cli \ 
        php7.1-bz2 \
        php7.1-common \
        php7.1-curl \
        php7.1-gd \
        php7.1-gmp \
        php7.1-imap \
        php7.1-intl \
        php7.1-ldap \
    	php7.1-json \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-opcache \
        php7.1-pgsql \
    	php7.1-readline \
        php7.1-sybase \
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-tidy \  
        php7.1-xml \   
        php7.1-xmlrpc \
        php7.1-xsl \
        php7.1-zip \

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
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/7.1/cli/php.ini

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

# Set composer home
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install phpunit and put binary into $PATH
RUN curl -sSLo phpunit.phar https://phar.phpunit.de/phpunit.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

# Enable modules
RUN phpenmod gmp iconv mcrypt mongodb pdo pgsql sqlite3 readline redis xml xsl

# Default command
CMD ["/usr/bin/php", "-a"]