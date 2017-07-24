#!/usr/bin/env bash

set -e # Halt on errors
set -x # Be verbose

# download Qt
mkdir -p qt5 && wget -q -O qt5.tar.bz2 http://ci.roessler.systems/files/qt-bin/Qt-5.9.1-Android-armv7.tar.bz2
tar xjf qt5.tar.bz2 -C qt5
rm qt5.tar.bz2

# download Android NDK
mkdir -p android-ndk && wget -q -O android-ndk.zip https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
unzip -qq android-ndk.zip -d android-ndk
rm android-ndk.zip
cd android-ndk
mv */* .
cd ..

# download Android SDK
#mkdir -p android-sdk && wget -q -O android-sdk.tgz https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
#tar xfz android-sdk.tgz -C android-sdk
#rm android-sdk.tgz
mkdir -p android-sdk && wget -q -O android-sdk.tar.bz2 http://ci.roessler.systems/files/qt-bin/android-sdk.tar.bz2
tar xjf android-sdk.tar.bz2 -C android-sdk
cd android-sdk
mv */* .
cd ..
