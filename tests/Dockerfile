FROM ubuntu:22.04

VOLUME ["/var/moodledata"]
EXPOSE 80 443
ADD ./custom-dist.php /var/www/html/config.php

ENV DEBIAN_FRONTEND noninteractive

ENV MOODLE_URL http://127.0.0.1

# Enable when using external SSL reverse proxy
# Default: false
ENV SSL_PROXY false

ADD ./foreground.sh /etc/apache2/foreground.sh

RUN apt-get update && \
    apt-get -y install mysql-client pwgen python-setuptools curl git unzip apache2 php \
    php-gd libapache2-mod-php postfix wget supervisor php-pgsql curl libcurl4 \
    libcurl3-dev php-curl php-xmlrpc php-intl php-mysql git-core php-xml php-mbstring php-zip php-soap cron php-ldap && \
    cd /tmp && \
    git clone https://github.com/iomad/iomad.git && \
    mv /tmp/iomad/* /var/www/html/ && \
    rm /var/www/html/index.html && \
    chown -R www-data:www-data /var/www/html && \
    chmod +x /etc/apache2/foreground.sh

#cron
ADD ./moodlecron /etc/cron.d/moodlecron
RUN chmod 0644 /etc/cron.d/moodlecron

# Enable SSL, moodle requires it
RUN a2enmod ssl && a2ensite default-ssl  #if using proxy dont need actually secure connection

# Cleanup
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/dpkg/* /var/lib/cache/* /var/lib/log/*

ENTRYPOINT ["/etc/apache2/foreground.sh"]