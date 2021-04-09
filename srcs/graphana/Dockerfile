FROM alpine:3.12
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE mysecurepassword
WORKDIR /src
COPY . .

RUN  apk add grafana --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;
RUN  apk add telegraf --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community;
#COPY /srcs/grafana.db   /usr/share/grafana/data/grafana.db
RUN   cd ~/ && mkdir mkcert && cd mkcert;\
      wget "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64";\
      mv mkcert-* mkcert && chmod +x mkcert && ./mkcert -install && ./mkcert localhost;
EXPOSE 3306

CMD sh /src/srcs/build.sh