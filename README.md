DOCKER-3SCALE-PROXY
==============

## Description

This Dockerfile creates [3scale](http://www.3scale.net) proxy and makes it as easy as possible to deploy. It can be used to deploy Openresty as well.

## Docker Installation

Refer to Docker [Documentation](http://docs.docker.io/en/latest/installation/ubuntulinux/)

## Docker 3scale proxy installation

### Gathering 3scale proxy config files
You can follow the instructions on the support page at 3scale's support [website](https://support.3scale.net/howtos/api-configuration/nginx-proxy).

#### Building the docker image

```
$ docker build -t 3scale-proxy git://github.com/rhoml/docker-3scale-proxy.git

OR

$ git clone https://github.com/rhoml/docker-3scale-proxy.git
$ cd docker-3scale-proxy
$ docker build -t rhoml/docker-3scale-proxy .
```

### Running the docker image created (-d: detached mode, -P: expose the port 80 on the host machine)

```
$ docker run -d -p 1300:80 -P rhoml/docker-3scale-proxy
```

This command will load a Docker container with 3Scale's proxy on port 1300.
