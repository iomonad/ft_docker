FROM ruby
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create ROR layer"

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "sqlite3"]
RUN ["gem", "install", "rails"]

ONBUILD COPY [".", "/opt/app"]
ONBUILD WORKDIR /opt/app

ONBUILD RUN ["bundle", "install"]
ONBUILD RUN ["rails", "db:migrate"]
ONBUILD RUN ["rails", "db:seed"]

ONBUILD EXPOSE 3000
