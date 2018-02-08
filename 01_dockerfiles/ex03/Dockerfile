FROM debian:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Create devel Gogs instance"

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y gcc git curl

# Set go build path
ENV GOROOT=$HOME/local/go
ENV GOPATH=$HOME/gogs
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/
WORKDIR $HOME/local
RUN curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
RUN tar -xzvf go1.8.linux-amd64.tar.gz
WORKDIR $GOPATH/src/github.com/gogits

# Build devel branch
RUN git clone --depth=1 -b develop https://github.com/gogits/gogs
RUN go get -u -tags "sqlite" github.com/gogits/gogs
WORKDIR $GOPATH/src/github.com/gogits/gogs
RUN go build -tags "sqlite"
RUN mkdir $GOPATH/src/github.com/gogits/logs
RUN mkdir /root/gogs-repositories
RUN mkdir /root/data

# Run it
ENV USER=root
EXPOSE 3000
EXPOSE 22
ENTRYPOINT ["./gogs" "web"]
