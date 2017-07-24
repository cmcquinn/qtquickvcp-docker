#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

##########################################################################
# GET DEPENDENCIES
##########################################################################

# select fastet mirror
apt-get update
apt-get install -y netselect-apt
netselect-apt
mv sources.list /etc/apt/sources.list

# add Machinekit repository
#apt-key adv --keyserver keyserver.ubuntu.com --recv 43DDF224
#sh -c \
#   "echo 'deb http://deb.machinekit.io/debian jessie main' > \
#    /etc/apt/sources.list.d/machinekit.list"

apt-get update
# basic dependencies (needed by Docker image)
apt-get install -y sudo git wget automake unzip gcc g++ binutils bzip2
# remove sudo pw
echo "ALL            ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/unlock_all
# QtQuickVcp's dependencies:
apt-get install -y  build-essential gdb dh-autoreconf libgl1-mesa-dev libxslt1.1 git
# dependencies of qmlplugindump
apt-get install -y libfontconfig1 libxrender1 libdbus-1-3 libegl1-mesa
# Android dependencies
apt-get install -y libtool-bin make curl file libgtest-dev python default-jdk ant lib32z1 lib32ncurses5 lib32stdc++6 python-pip
# Android SSL and Protobuf dependencies
apt-get install -y xutils-dev pkg-config
# cleanup afterwards
apt-get clean
