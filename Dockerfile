FROM php:8.4-cli-alpine
ENV WEBSVN_VERSION=2.8.4
LABEL org.opencontainers.image.authors="6783174+kkumlien@users.noreply.github.com"
RUN apk --update --no-cache add subversion
RUN mkdir -p /var/www/html/websvn
WORKDIR /var/www/html/websvn
RUN php -r 'copy("https://github.com/websvnphp/websvn/archive/refs/tags/".getenv("WEBSVN_VERSION").".tar.gz", getenv("WEBSVN_VERSION").".tar.gz");'
RUN tar -xzf $WEBSVN_VERSION.tar.gz --strip-components 1 && rm $WEBSVN_VERSION.tar.gz
COPY config.php ./include
RUN php -r "readfile('http://getcomposer.org/installer');" | php
RUN php composer.phar update
RUN rm composer.phar
RUN echo 'error_reporting = E_ERROR' > /usr/local/etc/php/php.ini
EXPOSE 80
CMD ["php", "-c", "/usr/local/etc/php/php.ini", "-S", "0.0.0.0:80"]
