FROM alpine:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create devel Gogs instance"

# Install dependencies
RUN apk update && apk add curl git go musl-dev \
	&& rm -rf /var/cache/apk/*

# Set Go-Paths
ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

WORKDIR $GOPATH/src/github.com/gogits

# Prepare buildpath
RUN git clone --depth=1 -b develop https://github.com/gogits/gogs
RUN go get -u -tags "sqlite" github.com/gogits/gogs
WORKDIR $GOPATH/src/github.com/gogits/gogs

# Build from source
RUN go build -tags "sqlite"

# Add Service User
RUN useradd gogs
RUN mkdir /gogs/gogs-repositories
RUN mkdir /gogs/data

ENV USER=gogs

EXPOSE 3000
ENTRYPOINT ["./gogs" "web"]
