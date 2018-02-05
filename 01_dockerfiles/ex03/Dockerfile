FROM debian:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create GitLab instance"

# Salut les githubers, le sujet
# a change c'est desormais gitlab
# a deployer.

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y gcc git curl

# Prepare all teh things
RUN useradd -ms /bin/bash gitsucks
USER gitsucks
WORKDIR /home/gitsucks

# Build devel branch
RUN git clone --depth=1 https://gitlab.com/gitlab-org/gitlab-ce.git
RUN cp config/gitlab.yml.example config/gitlab.yml
RUN sed -i -e 's/# user: git/user: gitsucks/g'
RUN cp config/secrets.yml.example config/secrets.yml
# Create dir

EXPOSE 3000
EXPOSE 22
ENTRYPOINT ["./gogs" "web"]
