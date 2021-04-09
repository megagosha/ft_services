FROM alpine:3.12
WORKDIR /src
COPY . .
EXPOSE 80
EXPOSE 443
EXPOSE 22
RUN  apk add --no-cache nginx openssl;\
    cd ~/ && mkdir mkcert && cd mkcert;\
    wget "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64";\
    mv mkcert-* mkcert && chmod +x mkcert && ./mkcert -install && ./mkcert localhost;\
    mkdir /www;\
    mkdir -p /run/nginx;\
    adduser -D -g 'www' www;\
    chown -R www:www /var/lib/nginx;\
    chown -R www:www /www;\
    cd /src;
RUN apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;

COPY srcs/nginxconf.com /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
CMD sh /src/srcs/build.sh