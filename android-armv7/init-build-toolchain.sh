#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

# install android-publish
pip install -q google-api-python-client
curl -fsSL -o android-publish https://gist.githubusercontent.com/machinekoder/2137bc2ebabfb3fb8daadc1f431e21a5/raw/de171f7c228dd6b14b981cddb3662a0d86cc53ec/android-publish.py
chmod +x android-publish
mv android-publish /usr/bin/


# install Qt-Deployment-Scripts
 [ -d "Qt-Deployment-Scripts" ] || git clone --depth 1 https://github.com/machinekoder/Qt-Deployment-Scripts.git
 cd Qt-Deployment-Scripts
 make install
 cd ..

# QtQuickVcp dependencies

# Prepare Android toolchain
./android-ndk/build/tools/make-standalone-toolchain.sh --install-dir=/opt/android-toolchain --arch=arm
export PATH=/opt/android-toolchain/bin:$PATH

# Build ZeroMQ for Android
mkdir -p tmp
cd tmp/

export OUTPUT_DIR=/opt/zeromq-android
export RANLIB=/opt/android-toolchain/bin/arm-linux-androideabi-ranlib

[ -d "zeromq4-1" ] || git clone https://github.com/zeromq/zeromq4-1.git
cd zeromq4-1/
git checkout v4.1.6

./autogen.sh
./configure --enable-static --disable-shared --host=arm-linux-androideabi --prefix=$OUTPUT_DIR \
LDFLAGS="-L$OUTPUT_DIR/lib" CPPFLAGS="-fPIC -I$OUTPUT_DIR/include" LIBS="-lgcc"
make
make install

cd ..

# build openssl for Android
export ANDROID_NDK_ROOT=/android-ndk/
export OPENSSL_VERSION="openssl-1.0.2k"

[ -d "android-openssl-qt" ] || git clone https://github.com/ekke/android-openssl-qt.git
cd android-openssl-qt
./build-all-arch.sh
mkdir -p /opt/openssl-android
cp -r prebuilt/* /opt/openssl-android/

# back to tmp
cd ..

# build Protobuf for Android
[ -d "protobuf" ] || git clone https://github.com/google/protobuf.git protobuf-repo
cp -r protobuf-repo protobuf
cd protobuf

# for host
git checkout v3.3.1
./autogen.sh
./configure --prefix=/usr
make -j 5
make install

cd ..
rm -rf protobuf
mv protobuf-repo protobuf
cd protobuf

# for the target
export PATH=/opt/android-toolchain/bin:$PATH
export CFLAGS="-fPIC -DANDROID -nostdlib"
export LDFLAGS="-llog"
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++
export NDK=/android-ndk
export SYSROOT=$NDK/platform/android-9/arch-arm
export OUTPUT_DIR=/opt/protobuf-android
./autogen.sh
./configure --enable-static --disable-shared --host=arm-eabi --with-sysroot=$SYSROOT CC=$CC CXX=$CXX --enable-cross-compile --with-protoc=protoc LIBS="-lc" --prefix=$OUTPUT_DIR
make -j 5
make install

cd ..

# back to root dir
cd ..
rm -rf tmp

# make directories accessible by all users
chmod -R a+rw /qt5 /android-ndk /android-sdk

# mark image as prepared
touch /etc/system-prepared
