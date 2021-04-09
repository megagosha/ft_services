#!/bin/sh
adduser $FTPS_USER;
mkdir /etc/vsftpd/;
echo "$FTPS_USER:$FTPS_PASSWORD"|chpasswd;\
echo $FTPS_USER > /etc/vsftpd/user_list;\
chown $FTPS_USER /ftpdata
cp /src/srcs/telegraf.conf /etc/my.conf
telegraf -config /etc/my.conf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
