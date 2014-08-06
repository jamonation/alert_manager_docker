FROM ubuntu
MAINTAINER Jamon Camisso <jamon@jamon.ca>

#  Don't prompt for input
ENV DEBIAN_FRONTEND noninteractive

# Update the base image
RUN apt-get update
RUN apt-get -y upgrade

# Install packages
RUN apt-get -y install mysql-server libmysqlclient-dev apache2-mpm-worker libapache2-mod-wsgi python-dev python-pip git curl bzip2 supervisor
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

# Configure apache2
ADD alert_manager.conf /etc/apache2/sites-available/alerts.conf
RUN ["/usr/sbin/a2dissite", "000-default"]
RUN ["/usr/sbin/a2ensite", "alerts"]

EXPOSE 80

# Unset DEBIAN_FRONTEND per http://docs.docker.com/reference/builder/#env
ENV DEBIAN_FRONTEND ''

# Finally, make supervisord start services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]