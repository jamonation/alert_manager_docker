Getting started with docker
###########################

To get started:

1. Visit https://docs.docker.com/installation/ and get docker up and running on your system
2. ``git clone https://github.com/jamonation/alert_manager_docker.git`` to a directory of your choosing
3. ``cd alert_manager_docker``
4. ``git submodule update --init --recursive`` to pull forked alert_manager into your working directory
5. ``docker build -t mozilla/alert_manager .`` to create your local docker container
6. ``docker run -p 8080:5000 -v $PWD/alert_manager:/srv/www/alert_manager mozilla/alert_manager``
7. Visit http://localhost:8080/alerts.html in your browser

Notes
=====

If you use Windows, the docker run command may not expose the alert_manager directory to the container.
In that case, use and explicit path to the current directory in place of $PWD. For example:
``C:\Program Files\alert_manager_docker`` or wherever you've placed the codebase.
