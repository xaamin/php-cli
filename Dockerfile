FROM xaamin/ubuntu
MAINTAINER Benjamín Martínez Mateos <bmxamin@gmail.com>

# Install PHP5 AND popular required extensions
RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C \
    && apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install php5-cli \
    	php5-json \
    	php5-gd \
    	php5-readline \
    	php5-curl \
        php5-geoip \
        php5-imagick \
        php5-imap \
        php5-ldap \
    	php5-mcrypt \
        php5-json \    
        php5-memcache \
        php5-memcached \
        php5-mcrypt \
        php5-mongo \
        php5-mssql \
        php5-mysql \
        php5-pgsql \
        php5-redis \
        php5-sqlite \
        php5-xdebug \
        php5-xmlrpc \
        php5-xcache \
        php5-gmp \
        php5-xsl \

	# Remove temp files
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php5/cli/php.ini

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

# Set composer home
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable modules
RUN php5enmod readline mcrypt mongo mssql pgsql sqlite3 redis gmp xsl

# Default command
CMD ["/usr/bin/php", "-a"]