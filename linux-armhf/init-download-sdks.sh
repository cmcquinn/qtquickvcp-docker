#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

# install Qt
mkdir -p qt5 && wget -q -O qt5.tar.bz2 http://ci.roessler.systems/files/qt-bin/Qt-5.9.1-Linux-armhf.tar.bz2
tar xjf qt5.tar.bz2 -C qt5
rm qt5.tar.bz2
