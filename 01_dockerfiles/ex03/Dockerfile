FROM debian:jessie
LABEL Description="Create devel Gogs instance"
LABEL RealTaste="https://hooktube.com/watch?v=t2CN7ZqrXtw"

# ALT1 #

# FROM ruby:2.3-stretch
# MAINTAINER Clement T. <me@trosa.io>
# LABEL Description="Create devel Gogs instance"

# RUN apt-get update -y \
# 	&& apt-get upgrade -y \
# 	   && apt-get install -y gcc git git-core curl \
# 	   	     openssh-server ca-certificates sudo \
# 			        gnupg2 dirmngr net-tools iputils-ping

# # Install postgresql sql
# RUN apt-get install -y postgresql postgresql-client postgresql-contrib
# VOLUME /var/run/postgresql /var/run/postgresql
# VOLUME /run/postgresql /run/postgresql
# RUN chown -R postgres:postgres /var/lib/postgresql
# RUN /etc/init.d/postgresql start

# RUN adduser --disabled-login --gecos 'GitLab' git

# # Install Redis database
# RUN apt-get install -y redis-server
# RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.orig
# RUN sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf
# RUN echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf
# RUN echo 'unixsocketperm 770' | sudo tee -a /etc/redis/redis.conf
# RUN mkdir /var/run/redis
# RUN chown redis:redis /var/run/redis
# RUN chmod 755 /var/run/redis
# RUN service redis-server stop
# RUN sudo usermod -aG redis git # Add git to redis group

# # Setup Mainline gitlab binary
# RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
# RUN apt-get install -y gitlab-ce
# RUN curl https://gist.githubusercontent.com/iomonad/3e4d4b5c7a8e7d01609136c08a0af7a9/raw/7bbec521ce949a1beea7bcb747efc8829695cb08/gitlab.rb > /etc/gitlab/gitlab.rb
# RUN sudo initctl restart gitlab-runsvdir
# RUN gitlab-ctl reconfigure
# RUN ls -l /usr/bin/gitlab-ctl /opt/gitlab/bin/gitlab-ctl

# # Database configuration
# #USER postgres
# #RUN ln -s /tmp/.s.PGSQL.5432 /var/run/postgresql/.s.PGSQL.5432
# #RUN mkdir /var/lib/postgresql/9.6/data/
# #RUN /usr/lib/postgresql/9.6/bin/pg_ctl start -w -D /var/lib/postgresql/9.6/data/
# #RUN psql -d template1 -c "CREATE USER git CREATEDB;"
# #RUN psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
# #RUN psql -d template1 -c "CREATE DATABASE gitlabhq_production OWNER git;"

# EXPOSE 8080/tcp 22/tcp

# RUN /opt/gitlab/bin/gitlab-ctl start

#ENTRYPOINT wait

# END ALT1 #

# Alt 2 #
# FROM alpine:latest
# MAINTAINER Clement T. <me@trosa.io>
# LABEL Description="Create devel Gogs instance"
# LABEL RealTaste="https://hooktube.com/watch?v=t2CN7ZqrXtw"

# ENV RAILS_ENV production

# # Update cache and install packages/essentials
# RUN apk upgrade --update-cache --available
# RUN apk --no-cache add icu-dev cmake krb5-dev libre2-dev git \
#                        openssh git nginx postgresql redis nodejs-current \
# 					                          icu-libs libre2 postgresql-contrib ruby ruby-irb \
# 											                         ruby-io-console sudo procps
# 																	 RUN apk add --no-cache --virtual .build-deps gcc g++ make cmake linux-headers \
# 																	                        icu-dev ruby-dev musl-dev postgresql-dev zlib-dev \
# 																							                       libffi-dev libre2-dev python2 go yarn

# # Pre Hooks
# RUN adduser -D -g 'GitLab' git

# # Configure postgresql
# EXPOSE 80/tcp 22/tcp
# ENTRYPOINT ls

# Alt 2 #
SHELL ["/bin/sh", "-c"],

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      ca-certificates \
      openssh-server \
      wget \
      apt-transport-https \
      vim \
      tzdata \
      nano \
      curl \
    && rm -rf /var/lib/apt/lists/* \
    && sed 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' -i /etc/pam.d/sshd
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic
RUN ln -fs /dev/null /run/motd.dynamic
COPY .assets/ /assets/
RUN set -xe
ENV DISTRIB_CODENAME jessie
RUN curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install -yq --no-install-recommends gitlab-ce
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/gitlab/sv/sshd/supervise /opt/gitlab/sv/sshd/log/supervise
RUN mkfifo /opt/gitlab/sv/sshd/supervise/ok /opt/gitlab/sv/sshd/log/supervise/ok
RUN printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D -f /assets/sshd_config -e" > /opt/gitlab/sv/sshd/run
RUN printf "#!/bin/sh\nexec svlogd -tt /var/log/gitlab/sshd" > /opt/gitlab/sv/sshd/log/run
RUN chmod a+x /opt/gitlab/sv/sshd/run /opt/gitlab/sv/sshd/log/run
RUN mkdir -p /var/run/sshd
RUN rm -f /etc/gitlab/gitlab.rb
RUN sed -i "s/external_url 'GENERATED_EXTERNAL_URL'/# external_url 'GENERATED_EXTERNAL_URL'/" /opt/gitlab/etc/gitlab.rb.template
RUN sed -i "s/\/etc\/gitlab\/gitlab.rb/\/assets\/gitlab.rb/" /opt/gitlab/embedded/cookbooks/gitlab/recipes/show_config.rb
RUN sed -i "s/\/etc\/gitlab\/gitlab.rb/\/assets\/gitlab.rb/" /opt/gitlab/embedded/cookbooks/gitlab/recipes/config.rb
RUN groupadd -g 998 git
RUN groupadd -g 999 gitlab-www
RUN groupadd -g 997 gitlab-redis
RUN groupadd -g 996 gitlab-psql
RUN groupadd -g 994 mattermost
RUN groupadd -g 993 registry
RUN groupadd -g 992 gitlab-prometheus
RUN groupadd -g 991 gitlab-consul
RUN useradd -m -u 998 -g git -m -s /bin/sh -d /var/opt/gitlab git
RUN useradd -m -u 999 -g gitlab-www -m -s /bin/false -d /var/opt/gitlab/nginx gitlab-www
RUN useradd -m -u 997 -g gitlab-redis -m -s /bin/false -d /var/opt/gitlab/redis gitlab-redis
RUN useradd -m -u 996 -g gitlab-psql -m -s /bin/sh -d /var/opt/gitlab/postgresql gitlab-psql
RUN useradd -m -u 994 -g mattermost -m -s /bin/sh -d /var/opt/gitlab/mattermost mattermost
RUN useradd -m -u 993 -g registry -m -s /bin/sh -d /var/opt/gitlab/registry registry
RUN useradd -m -u 992 -g gitlab-prometheus -m -s /bin/sh -d /var/opt/gitlab/prometheus gitlab-prometheus
RUN useradd -m -u 991 -g gitlab-consul -m -s /bin/sh -d /var/opt/gitlab/consul gitlab-consul

ENV PATH /opt/gitlab/embedded/bin:/opt/gitlab/bin:/assets:$PATH

ENV TERM xterm
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
CMD ["/assets/wrapper"]

EXPOSE 443 80 22
HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
CMD /opt/gitlab/bin/gitlab-healthcheck --fail
