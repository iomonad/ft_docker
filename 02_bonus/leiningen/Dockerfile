FROM openjdk:8-alpine
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Run leiningen shell inside container"

RUN pkg add wget

RUN wget -q -O /usr/bin/lein \
    https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
	    && chmod +x /usr/bin/lein

RUN lein

RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["lein"]
