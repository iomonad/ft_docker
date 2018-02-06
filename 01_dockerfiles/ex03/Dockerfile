FROM alpine:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create devel Gogs instance"
LABEL RealTaste="https://hooktube.com/watch?v=t2CN7ZqrXtw"

ENV RAILS_ENV production

# Update cache and install packages/essentials
RUN apk upgrade --update-cache --available
RUN apk --no-cache add icu-dev cmake krb5-dev libre2-dev git \
                       openssh git nginx postgresql redis nodejs-current \
                       icu-libs libre2 postgresql-contrib ruby ruby-irb \
                       ruby-io-console sudo procps
RUN apk add --no-cache --virtual .build-deps gcc g++ make cmake linux-headers \
                       icu-dev ruby-dev musl-dev postgresql-dev zlib-dev \
                       libffi-dev libre2-dev python2 go yarn

# Pre Hooks
RUN adduser -D -g 'GitLab' git

# Configure postgresql
EXPOSE 80/tcp 22/tcp
ENTRYPOINT ls
