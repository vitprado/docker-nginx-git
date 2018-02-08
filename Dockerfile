FROM phusion/baseimage:0.10.0

MAINTAINER Marco Pompili "docker@mg.odd.red"

RUN apt-get -q -q update && \
    apt-get -y install nginx fcgiwrap git

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

RUN mkdir /srv/git

VOLUME ["/srv/git", "/var/log/nginx"]

COPY default.conf /etc/nginx/conf.d/

COPY gitconfig /etc/

COPY nginx.conf /etc/nginx/

RUN sed -i '35iserver_tokens off;' /etc/nginx/nginx.conf

COPY index.html /usr/share/nginx/html/

COPY 99_start.sh /etc/my_init.d/
