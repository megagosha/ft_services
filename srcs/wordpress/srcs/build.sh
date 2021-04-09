#!/bin/sh
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www
cd /www || exit
mkdir wordpress
chown -R www:www wordpress
cd wordpress || exit
wp core download
sleep 30
wp core config --dbhost=mysql:3306 --dbname=wordpress_db --dbuser=$WP_USERNAME --dbpass=$WP_PASSWORD --url=http://192.168.99.112:5050/
wp core install --path=/www/wordpress --url=http://192.168.99.112:5050/ --title="Ft_services wordpress" --admin_name=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=megagosha@gmail.com
wp user create user1 user1@example.com --role=author --user_pass=user1_password
wp user create user2 user2@example.com --role=author --user_pass=user2_password
cp /src/srcs/telegraf.conf /etc/my.conf
telegraf -config /etc/my.conf &
php-fpm7
nginx -g "daemon off;"