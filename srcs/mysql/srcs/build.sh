#!/bin/sh
mkdir /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
rm /etc/my.cnf
rm /etc/my.cnf.d/mariadb-server.cnf
cp /src/srcs/my.cnf /etc/my.cnf.d/mariadb-server.cnf
mysql_install_db --user=root --datadir="/var/lib/mysql"
cat << EOF >> /src/srcs/temp
GRANT ALL PRIVILEGES ON *.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$PMA_USERNAME'@'%' IDENTIFIED BY '$PMA_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$WP_USERNAME'@'%' IDENTIFIED BY '$WP_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE wordpress_db;
DROP DATABASE test;
EOF
cp /src/srcs/telegraf.conf /etc/my.conf
telegraf -config /etc/my.conf &
mysqld_safe --user=root --datadir=/var/lib/mysql &
sleep 10
mysql --user=root < /src/srcs/temp
mysql --user=root < /src/srcs/create_pma.sql

sleep infinity
