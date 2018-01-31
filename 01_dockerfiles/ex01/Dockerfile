FROM debian:buster
MAINTAINER Clement T. <me@trosa.io>
LABEL Description="Deploy teamspeak3 server"

ENV TSV=3.0.13.8

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get -y update && \
	apt-get -y install bzip2 && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	apt-get autoremove -y && \
	apt-get clean

# Add tarball to local volume
ADD http://dl.4players.de/ts/releases/${TSV}/teamspeak3-server_linux_amd64-${TSV}.tar.bz2 ./

# Extract and cleanup tarball
RUN tar jxf teamspeak3-server_linux_amd64-$TSV.tar.bz2 && \
	mv teamspeak3-server_linux_amd64 /opt/teamspeak && \
	rm teamspeak3-server_linux_amd64-$TSV.tar.bz2

# Declare exposed ports
EXPOSE 9987/udp
EXPOSE 30033
EXPOSE 10011

# Specify user for service
RUN useradd teamspeak -p nil --shell /bin/false \
	&& mkdir /data \
	&& chown teamspeak:teamspeak /data

ADD fix-symlinks /fix-and-run

ENTRYPOINT ["/fix-and-run"]
