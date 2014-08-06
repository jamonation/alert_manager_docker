#!/bin/bash

/usr/sbin/service mysql start
echo "CREATE DATABASE alerts" |/usr/bin/mysql
/bin/bzcat /tmp/alerts.sql.bz2 |/usr/bin/mysql alerts
