#!/bin/sh
mkdir conf
cp /src/srcs/defaults.ini /usr/share/grafana/conf/defaults.ini
cp /src/srcs/telegraf.conf /etc/my.conf
mkdir -p /var/grafana/dash
cp /src/srcs/dash/* /var/grafana/dash/
cp /src/srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboard.yaml
cp /src/srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/datasource.yaml
telegraf -config /etc/my.conf &
cd /usr/share/grafana || exit
grafana-server
sleep infinity
