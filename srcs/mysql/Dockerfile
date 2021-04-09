FROM alpine:3.12
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE mysecurepassword
WORKDIR /src
COPY . .

RUN  apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
         rm -f /var/cache/apk/*
RUN addgroup mysql mysql
RUN apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;
EXPOSE 3306

CMD sh /src/srcs/build.sh