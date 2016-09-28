FROM library/debian:jessie
MAINTAINER Alexander Rössler <mail@roessler.systems>
COPY init.sh /tmp/init.sh
RUN sed -i "s/httpredir.debian.org/debian.inode.at/" /etc/apt/sources.list
RUN /tmp/init.sh
