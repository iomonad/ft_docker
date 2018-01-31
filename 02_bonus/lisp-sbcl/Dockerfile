FROM ubuntu:latest

COPY sbclrc /sbclrc
COPY quicklisp.lisp /quicklisp.lisp

RUN apt-get update && \
    apt-get install -y wget sbcl

ENTRYPOINT ["sbcl" "--load" "/quicklisp.lisp" "--eval" "(quicklisp-quickstart:install)"]
