#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

apt-get update
apt-get install -y libcurl3-gnutls

# NOTE: AppImageKit is disabled for now because I can't find a way to get vte.so in Debian Stretch
# It used to be part of ruby-vte, but that package doesn't exist in Stretch
# extra libraries needed by AppImageKit
# apt-get install -y python fuse libglade2-0 libvte9 ruby-vte unionfs-fuse

# Build AppImageKit
#[ -d "AppImageKit" ] || git clone --branch 6 https://github.com/probonopd/AppImageKit.git
#cp /usr/lib/arm-linux-gnueabihf/libglade-2.0.so.0 /AppImageKit/binary-dependencies/armv7l/
#cp /usr/lib/libvte.so.9 AppImageKit/binary-dependencies/armv7l/
#cp /usr/lib/arm-linux-gnueabihf/ruby/vendor_ruby/2.1.0/vte.so AppImageKit/binary-dependencies/armv7l/
#cp /usr/bin/unionfs-fuse AppImageKit/binary-dependencies/armv7l/
#cd AppImageKit/
#bash -ex install-build-deps.sh
#bash -ex build.sh
#
#cd ..

[ -d "Qt-Deployment-Scripts" ] || git clone --depth 1 https://github.com/machinekoder/Qt-Deployment-Scripts.git
cd Qt-Deployment-Scripts
make install
cd ..

# python is needed to run the deployment scripts
apt-get install -y python

# make directories accessible by all users
# chmod -R a+rw /qt5

# mark image as prepared
touch /etc/system-prepared
