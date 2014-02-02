FROM ubuntu:precise
MAINTAINER Rhommel Lamas

## Variables
ENV OPENRESTY_VERSION 1.5.8.1
ENV DEBIAN_FRONTEND noninteractive
ENV PROVIDER_ID 48

## Repositories
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list && \
    apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

## Install supervisord
RUN apt-get install -y supervisor && mkdir -p /var/log/supervisor

## SSHD
RUN apt-get install -y openssh-server && mkdir /var/run/sshd && \
    echo 'root:root' |chpasswd

## UTILITIES
RUN apt-get install -y vim wget build-essentials

## INSTALL OPENRESTY
RUN wget http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    rm ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    cd ngx_openresty-$OPENRESTY_VERSION && \
    ./configure --prefix=/opt/openresty --with-luajit --with-http_iconv_module -j2 && \
    make && \
    make install

RUN ln -sf /var/www/docker-3scale-proxy/conf/nginx_$PROVIDER_ID.conf /opt/openresty/nginx/conf/nginx.conf
RUN ln -sf /var/www/docker-3scale-proxy/conf/nginx_$PROVIDER_ID.lua /opt/openresty/nginx/conf/nginx_$PROVIDER_ID.lua

EXPOSE 80

CMD [ "supervisord", "-n"]