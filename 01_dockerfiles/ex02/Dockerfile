FROM ruby:2.3
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create ROR layer"

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "sqlite3"]
RUN ["gem", "install", "rails"]

ONBUILD COPY [".", "/opt/app"]
ONBUILD WORKDIR /opt/app

ONBUILD RUN gem install bundler rails && bundle install --jobs 20 --retry 5
#ONBUILD RUN ["bundle", "exec", "rails", "db:migrate"]
#ONBUILD RUN ["bundle", "exec", "rails", "db:seed"]
ONBUILD EXPOSE 3000
