FROM alpine:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create weechat relay instance"

RUN apk update && apk add weechat ruby python python-dev py-pip build-base py-dbus && \
    mkdir /data && \
	pip install --upgrade pip && \
	pip install notify2 && \
	apk del python-dev py-pip build-base && \
	rm -rf /var/cache/apk/*

ENV LANG C.UTF-8
ENV HOME /weechat

RUN mkdir -p $HOME/.weechat\
    && addgroup weechat\
	&& adduser -h $HOME -D -s /bin/bash -G weechat weechat\
	&& chown -R weechat:weechat $HOME

WORKDIR $HOME

USER weechat
EXPOSE 9001

ENTRYPOINT ["weechat"]
