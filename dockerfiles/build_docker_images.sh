#!/bin/bash

printf "\033[1mInstalling fig (http://www.fig.sh/) to manage docker development environment\033[m\n"
pip install fig

printf "\n\033[1mCreating data container for MySQL persistence:\033[m\n"
docker build -t ateam/alert_manager_data dockerfiles/alert_manager_data
docker run --name data ateam/alert_manager_data
if [ $? -eq 1 ]
then
    printf "\033[31mError creating MySQL application container. Run the following and then try this script again:\033[m\n"
    printf "\033[1mdocker ps -a -f status=exited |grep \"ateam/alert_manager_data\"| awk '{print \$1}' |xargs docker rm\033[m\n"
    printf "\033[31mExiting\033[m\n"
    exit 1
fi

printf "\033[1mCreating MySQL application container\033[m\n"
docker build -t ateam/alert_manager_db dockerfiles/alert_manager_db
docker run --volumes-from data ateam/alert_manager_db /usr/local/bin/provision_mysql.sh

BOOT2DOCKER=$(which boot2docker)
if [ $? -eq 0 ]
then
    BOOT2DOCKERIP=$(boot2docker ip 2>&1|awk '{print $NF}'|grep -v "^$")
    SITE="$BOOT2DOCKERIP"
    printf "\033[1mFor reference, it looks like you're running boot2docker\033[m\n"
else
    SITE="127.0.0.1"
fi
    printf "\033[1mAll done! Run 'fig up' and then browse to http://$SITE:8080/alerts.html\033[m\n"
