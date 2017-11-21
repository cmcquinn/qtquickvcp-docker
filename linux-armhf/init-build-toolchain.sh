#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

apt-get update
apt-get install -y libcurl3-gnutls

# Build AppImageKit
[ -d "AppImageKit" ] || git clone --branch 6 https://github.com/probonopd/AppImageKit.git
cd AppImageKit/
bash -ex build.sh

 cd ..

[ -d "Qt-Deployment-Scripts" ] || git clone --depth 1 https://github.com/machinekoder/Qt-Deployment-Scripts.git
cd Qt-Deployment-Scripts
make install
cd ..

# make directories accessible by all users
chmod -R a+rw /qt5

# mark image as prepared
touch /etc/system-prepared
