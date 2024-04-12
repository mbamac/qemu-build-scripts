#!/bin/zsh

. ./deps-versions.sh

INSTALL_DIR=/Applications/qemu-$QEMU_VERSION
BUILD_DIR=$(pwd)/src
LIBS_DIR=$(pwd)/libs
export PATH=$PATH:$BUILD_DIR:$INSTALL_DIR/bin:$LIBS_DIR/bin

export PKG_CONFIG_DIR=$LIBS_DIR
export PKG_CONFIG_PATH=$LIBS_DIR/lib/pkgconfig
export PATH=$PATH:$PKG_CONFIG_DIR/bin

export CFLAGS=-I$LIBS_DIR/include
export CPPFLAGS=-I$LIBS_DIR/include
export LDFLAGS=-L$LIBS_DIR/lib
export LIBS=-L$LIBS_DIR/lib
export LIBRARY_PATH=$LIBS_DIR/lib
export DYLD_LIBRARY_PATH=$LIBS_DIR/lib

cd $BUILD_DIR

cd $BUILD_DIR/qemu-$QEMU_VERSION

TMP_BUILD_DIR=_build

if [ ! -d $TMP_BUILD_DIR ]
then
	mkdir $TMP_BUILD_DIR
fi
cd $TMP_BUILD_DIR

../configure --prefix=$INSTALL_DIR --enable-slirp
make
make install

################
