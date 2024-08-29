FROM alpine:latest

RUN apk --no-cache add nginx php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-opcache \
    php82-zlib \
    php82-curl \
    php82-mbstring \
    php82-gd \
    php82-xml \
    php82-phar \
    php82-intl \
    php82-dom \
    php82-ctype \
    php82-session \
    php82-simplexml \
    php82-tokenizer \
    php82-xmlwriter \
    php82-fileinfo

RUN mkdir -p /run/nginx /var/www/html /etc/nginx/sites-available /etc/nginx/sites-enabled

COPY ./configs/nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./configs/nginx/sites/ /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

EXPOSE 8083

CMD ["sh", "-c", "php-fpm82 && nginx -g 'daemon off;'"]
