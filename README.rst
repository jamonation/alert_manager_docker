Getting started with docker
###########################

To get started:

1. Visit https://docs.docker.com/installation/ and get docker up and running on your system
2. git clone this repository to your system (git clone https://github.com/jamonation/alert_manager_docker.git)
3. cd into alert_manager_docker
4. git submodule update --init --recursive to pull alert_manager into your working directory
5. docker build -t mozilla/alert_manager . to create your local docker container
6. docker run -p 8080:80 mozilla/alert_manager
7. visit http://localhost:8080/alerts.html in your browser
