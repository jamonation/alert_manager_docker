#!/bin/bash

DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure mysql-server-5.5
/usr/sbin/service mysql start
mysql -u root -e "CREATE DATABASE IF NOT EXISTS alerts;"
mysql -u root -e "GRANT ALL on alerts.* to alerts_user@'%';"
bzcat /var/lib/mysql/alerts.sql.bz2 |mysql -u alerts_user alerts
exit
