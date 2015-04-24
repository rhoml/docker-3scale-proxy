FROM ubuntu:precise
MAINTAINER Rhommel Lamas <roml@rhommell.com>

## Variables
ENV OPENRESTY_VERSION 1.5.8.1
ENV DEBIAN_FRONTEND noninteractive
ENV PROVIDER_ID 48

## Repositories
RUN apt-get update --fix-missing

## Install supervisord
RUN apt-get install -y supervisor && mkdir -p /var/log/supervisor

## UTILITIES
RUN apt-get install -y vim wget build-essential

## OPENRESTY DEPENDENCIES
RUN apt-get install -y libreadline-dev libncurses5-dev libpcre3 libpcre3-dev libssl-dev

## INSTALL OPENRESTY
RUN wget --quiet http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    rm ngx_openresty-$OPENRESTY_VERSION.tar.gz && \
    cd ngx_openresty-$OPENRESTY_VERSION && \
    ./configure --prefix=/opt/openresty --with-http_iconv_module -j2 && \
    make && make install

RUN mkdir -p /opt/3scale/log

ADD conf/nginx_$PROVIDER_ID.conf /opt/3scale/nginx.conf
ADD conf/nginx_$PROVIDER_ID.lua /opt/3scale/nginx_$PROVIDER_ID.lua
ADD conf/supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD [ "supervisord", "-n"]
