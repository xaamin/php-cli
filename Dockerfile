FROM xaamin/ubuntu:14.04
MAINTAINER Benjamín Martínez Mateos <xaamin@outlook.com>

# Install PHP5.6 AND popular required extensions
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php5.6-cli \ 
        php5.6-bz2 \
        php5.6-common \
        php5.6-curl \
        php5.6-gd \
        php5.6-gmp \
        php5.6-imap \
        php5.6-intl \
        php5.6-ldap \
        php5.6-json \
        php5.6-mbstring \
        php5.6-mcrypt \
        php5.6-mysql \
        php5.6-opcache \
        php5.6-pgsql \
        php5.6-readline \
        php5.6-sybase \
        php5.6-soap \
        php5.6-sqlite3 \
        php5.6-tidy \  
        php5.6-xml \   
        php5.6-xmlrpc \
        php5.6-xsl \
        php5.6-zip \

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
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/5.6/cli/php.ini

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

# Set composer home
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable modules
RUN phpenmod gmp iconv mcrypt mongodb pdo pgsql sqlite3 readline redis xml xsl

# Default command
CMD ["/usr/bin/php", "-a"]