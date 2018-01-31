FROM alpine:latest
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Your editor sucks ; emacs > vim"

RUN apk add --no-cache emacs

# Building: docker build -t iomonad/ex00 .
# Running: docker run --rm -ti iomonad/ex00

ENTRYPOINT ["emacs"]
