FROM ubuntu
MAINTAINER Jamon Camisso <jamon@jamon.ca>

#  Don't prompt for input
ENV DEBIAN_FRONTEND noninteractive

# Update the base image
RUN apt-get update
RUN apt-get -y upgrade

# Install packages
RUN apt-get -q -y install mysql-server libmysqlclient-dev python-dev python-pip git curl bzip2 supervisor uwsgi uwsgi-plugin-python
RUN mkdir /srv/www
RUN mkdir -p /var/log/supervisor

# Setup python packages
ADD requirements.txt /tmp/requirements.txt
RUN ["/usr/bin/pip", "install", "-r", "/tmp/requirements.txt"]
RUN ["/bin/rm", "/tmp/requirements.txt"]

# populate mysql
ADD populate_mysql.sh /tmp/populate_mysql.sh
ADD alert_manager/sample/july_alerts.sql.bz2 /tmp/alerts.sql.bz2
RUN ["/bin/bash", "/tmp/populate_mysql.sh"]
RUN ["/bin/rm", "/tmp/populate_mysql.sh", "/tmp/alerts.sql.bz2"]

EXPOSE 80

# Put uwsgi config in place
ADD uwsgi.ini /etc/uwsgi/apps-enabled/uwsgi.ini

# Unset DEBIAN_FRONTEND per http://docs.docker.com/reference/builder/#env
ENV DEBIAN_FRONTEND ''

# Finally, make supervisord start services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
