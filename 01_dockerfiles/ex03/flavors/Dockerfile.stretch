FROM ruby:2.3-stretch
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create devel Gogs instance"

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y gcc git git-core curl \
	   openssh-server ca-certificates sudo \
       gnupg2 dirmngr net-tools iputils-ping

# Install postgresql sql
RUN apt-get install -y postgresql postgresql-client postgresql-contrib
VOLUME /var/run/postgresql /var/run/postgresql
VOLUME /run/postgresql /run/postgresql
RUN chown -R postgres:postgres /var/lib/postgresql
RUN /etc/init.d/postgresql start

RUN adduser --disabled-login --gecos 'GitLab' git

# Install Redis database
RUN apt-get install -y redis-server
RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.orig
RUN sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf
RUN echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf
RUN echo 'unixsocketperm 770' | sudo tee -a /etc/redis/redis.conf
RUN mkdir /var/run/redis
RUN chown redis:redis /var/run/redis
RUN chmod 755 /var/run/redis
RUN service redis-server stop
RUN sudo usermod -aG redis git # Add git to redis group

# Setup Mainline gitlab binary
RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install -y gitlab-ce
RUN curl https://gist.githubusercontent.com/iomonad/3e4d4b5c7a8e7d01609136c08a0af7a9/raw/7bbec521ce949a1beea7bcb747efc8829695cb08/gitlab.rb > /etc/gitlab/gitlab.rb
RUN sudo initctl restart gitlab-runsvdir
RUN gitlab-ctl reconfigure
RUN ls -l /usr/bin/gitlab-ctl /opt/gitlab/bin/gitlab-ctl

# Database configuration
#USER postgres
#RUN ln -s /tmp/.s.PGSQL.5432 /var/run/postgresql/.s.PGSQL.5432
#RUN mkdir /var/lib/postgresql/9.6/data/
#RUN /usr/lib/postgresql/9.6/bin/pg_ctl start -w -D /var/lib/postgresql/9.6/data/
#RUN psql -d template1 -c "CREATE USER git CREATEDB;"
#RUN psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
#RUN psql -d template1 -c "CREATE DATABASE gitlabhq_production OWNER git;"

EXPOSE 8080/tcp 22/tcp

RUN /opt/gitlab/bin/gitlab-ctl start
#ENTRYPOINT wait
