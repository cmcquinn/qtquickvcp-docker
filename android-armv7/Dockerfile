FROM library/debian:jessie
MAINTAINER Alexander Rössler <mail@roessler.systems>
COPY init.sh /tmp/init.sh
RUN sed -i "s/httpredir.debian.org/ftp.us.debian.org/" /etc/apt/sources.list
RUN /tmp/init.sh
RUN chmod -R a+rw /qt5 /android-ndk /android-sdk
