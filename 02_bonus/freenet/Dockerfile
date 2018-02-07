FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y curl openjdk-8-jre-headless
ENV FREENET_DIR /usr/share/freenet
WORKDIR ${FREENET_DIR}
RUN curl "https://downloads.freenetproject.org/alpha/freenet-build01470.jar" > freenet.jar && \
    curl "https://downloads.freenetproject.org/alpha/freenet-ext.jar" > freenet-ext.jar && \
    curl "http://downloads.bouncycastle.org/java/bcprov-jdk15on-152.jar" > bcprov.jar
WORKDIR /var/lib/freenet
RUN curl "https://downloads.freenetproject.org/alpha/opennet/seednodes.fref" > seednodes.fref
COPY freenet.ini .
EXPOSE 8888 9481
CMD java -cp ${FREENET_DIR}/bcprov.jar:${FREENET_DIR}/freenet-ext.jar:${FREENET_DIR}/freenet.jar freenet.node.NodeStarter
