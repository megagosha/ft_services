#!/bin/sh
influxd -config /etc/influxdb.conf &
sleep 15
influx  -socket "/var/run/influxdb.sock" -execute "CREATE USER $INFLUX_USER WITH PASSWORD '$INFLUX_PASS' WITH ALL PRIVILEGES;"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE grafanadb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE ftpsdb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE influxdb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE mysqldb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE nginxdb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE pmadb"
influx -socket "/var/run/influxdb.sock" -username $INFLUX_USER -password $INFLUX_PASS -execute "CREATE DATABASE wpdb"

cp /src/srcs/telegraf.conf /etc/my.conf
telegraf --config /etc/my.conf
