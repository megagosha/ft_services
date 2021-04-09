#!/bin/sh
#if [ "$AUTOINDEX" = "on" ]
#then
#  sed -i.bak 's/\<autoindex off\>/autoindex on/g' /etc/nginx/sites-available/localhost
#fi
cp /src/srcs/telegraf.conf /etc/my.conf
telegraf -config /etc/my.conf &
nginx -g "daemon off;"
