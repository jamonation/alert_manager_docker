alert_manager development using Docker
######################################

Linux based Alert Manager development with Docker:
==================================================

1. Visit https://docs.docker.com/installation/ and get docker up and running on your system
2. ``git clone https://github.com/jamonation/alert_manager_docker.git`` to a directory of your choosing
3. Run ``virtualenv alert_manager_docker`` or whatever directory you decided to clone into to setup the Python virtual environment
4. ``cd alert_manager_docker`` or into the name of the directory into which you cloned the git repository
5. ``source bin/activate`` to activate the virtual environment
6. ``git submodule update --init --recursive`` to pull forked alert_manager into your working directory
7. Run ``cd dockerfiles; ./build_docker_images.sh`` to create your local docker containers
8. Run ``fig up`` to start the collection of containers.
9. Visit http://localhost:8080/alerts.html in your browser


OSX based Alert Manager development with Docker:
==================================================

1. Visit https://docs.docker.com/installation/ and get docker up and running on your system
2. ``git clone https://github.com/jamonation/alert_manager_docker.git`` to a directory of your choosing
3. Run ``virtualenv alert_manager_docker`` or whatever directory you decided to clone into to setup the Python virtual environment
4. ``cd alert_manager_docker`` or into the name of the directory into which you cloned the git repository
5. ``source bin/activate`` to activate the virtual environment,
6. ``git submodule update --init --recursive`` to pull forked alert_manager into your working directory
7. Run ``cd dockerfiles; ./build_docker_images.sh`` to create your local docker containers
8. Run ``fig up`` to start the collection of containers.
9. Browse the address that the shell script noted.


Windows based Alert Manager development with Docker:
================================================

Not ready yet. The build script is Linux/OSX based. However, the docker commands in it
can be run manually. If you can get fig working in a python virtualenv it should be
straightforward to run the development environment until a proper script is available.
