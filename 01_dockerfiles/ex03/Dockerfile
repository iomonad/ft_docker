FROM debian:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create devel Gogs instance"

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y gcc git curl \
	   openssh-server ca-certificates sudo \
       gnupg2 dirmngr

# Install postgresql sql
RUN apt-get install -y postgresql postgresql-client

# Install mainline ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -c "source ~/.rvm/scripts/rvm"
RUN rvm install 2.3 && rvm use 2.3 --default
RUN gem install bundler

# Configure database
USER postgres

# Configure
RUN adduser --disabled-login --gecos 'GitLab' gitlab

EXPOSE 8080/tcp 22/tcp
ENTRYPOINT ["echo hello world"]
