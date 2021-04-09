FROM alpine:3.12
EXPOSE 5050
ENV PHP_FPM_USER="www"
ENV PHP_FPM_GROUP="www"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_MAX_UPLOAD="50M"
ENV PHP_MAX_FILE_UPLOAD="200"
ENV PHP_MAX_POST="100M"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO=0
WORKDIR /src
COPY . .
RUN     apk add --no-cache php php-zip php-gd php-mbstring nginx php-fpm unzip openssl php7-iconv php7-phar mysql-client\
        php-json php7-mysqli php-xml php7-openssl php7-mbstring php7-session php7-common php7-bcmath php7-opcache php7-gd php7-ctype php7-cli;\
        wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar";\
        mv /src/wp-cli.phar /usr/local/bin/wp;\
        chmod +x /usr/local/bin/wp;
RUN apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;
RUN cd ~/ && mkdir mkcert && cd mkcert;\
    wget "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64";\
    mv mkcert-* mkcert && chmod +x mkcert && ./mkcert -install && ./mkcert localhost;
COPY srcs/nginxconf.com /etc/nginx/nginx.conf
CMD sh /src/srcs/build.sh