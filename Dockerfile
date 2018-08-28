FROM eboraas/apache

RUN apt-get update && \
    apt-get install -y wget && \
    echo deb http://packages.dotdeb.org jessie all >> /etc/apt/sources.list && \
    echo deb-src http://packages.dotdeb.org jessie all >> /etc/apt/sources.list && \
    wget https://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg

RUN apt-get update && \
    apt-get -y install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-curl php7.0-json php7.0-gd php7.0-mcrypt php7.0-mbstring && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2dismod 'mpm_*' && \
    /usr/sbin/a2enmod mpm_prefork && \
    /usr/sbin/a2enmod rewrite

RUN service apache2 restart

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
