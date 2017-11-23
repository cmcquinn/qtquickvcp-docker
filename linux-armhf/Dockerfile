FROM multiarch/debian-debootstrap:armhf-stretch
MAINTAINER Cameron McQuinn
RUN sed -i "s/httpredir.debian.org/ftp.us.debian.org/" /etc/apt/sources.list
COPY init-install-packages.sh /tmp/init-install-packages.sh
RUN /tmp/init-install-packages.sh
COPY init-build-toolchain.sh /tmp/init-build-toolchain.sh
RUN /tmp/init-build-toolchain.sh
