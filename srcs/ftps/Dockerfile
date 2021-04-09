FROM alpine:3.12
WORKDIR /src
COPY . .
EXPOSE 21
EXPOSE 20021:20021
RUN  apk add --no-cache vsftpd openssl;\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout vsftpd.key -out vsftpd.crt -subj "/C=NA/ST=NA/L=NA/O=NA/OU=NA/CN=NA";\
    mv vsftpd.crt /etc/ssl/private/;\
    mv vsftpd.key /etc/ssl/private/;\
    chmod +x /src/srcs/build.sh;
RUN  apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
#COPY srcs/index.html /www/index.html
 #echo "daemon off;" >> /etc/nginx/nginx.conf
 CMD ["/src/srcs/build.sh"]