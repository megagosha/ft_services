FROM alpine:3.12
WORKDIR /src
COPY . .

RUN  apk add --no-cache influxdb &&\
         rm -f /var/cache/apk/*;\
     mv /src/srcs/influxdb.conf /etc/influxdb.conf;\
     apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;\
     chmod +x /src/srcs/build.sh
EXPOSE 8086
CMD sh /src/srcs/build.sh