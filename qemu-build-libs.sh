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

export GLIB_CFLAGS="-DG_INTL_STATIC_COMPILATION -DPCRE2_STATIC -I$LIBS_DIR/include/glib-2.0 -I$LIBS_DIR/lib/glib-2.0/include -I$LIBS_DIR/include"
export GLIB_LIBS="-L$LIBS_DIR/lib -lglib-2.0 -lintl -liconv -lm -framework Foundation -framework CoreFoundation -framework AppKit -framework Carbon -lpcre2-8"

# echo "INSTALL_DIR=$INSTALL_DIR"; echo "  BUILD=DIR=$BUILD_DIR"; echo "   LIBS_DIR=$LIBS_DIR"
# echo "PKG_CONFIG_DIR =$PKG_CONFIG_DIR"; echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
# echo "  CFLAGS=$CFLAGS"; echo "CPPFLAGS=$CPPFLAGS"; echo " LDFLAGS=$LDFLAGS"; echo "    LIBS=$LIBS"; echo "LIB_PATH=$LIBRARY_PATH"; echo "    DYLD=$DYLD_LIBRARY_PATH"
# echo "GLIB_CFLAGS =$GLIB_CFLAGS"; echo "GLIB_LIBS   =$GLIB_LIBS"

cd $BUILD_DIR

################

echo "building glib"

cd $BUILD_DIR/glib-$GLIB_VERSION

if ! ../meson-$MESON_VERSION/meson.py setup _build --prefix=$LIBS_DIR --default-library static
then
	echo ERROR
	exit
fi
../meson-$MESON_VERSION/meson.py compile -C _build
../meson-$MESON_VERSION/meson.py install -C _build

################

echo "building pkg-config"

#mkdir -p $PKG_CONFIG_DIR
cd $BUILD_DIR/pkg-config-$PKG_CONFIG_VERSION

TMP_BUILD_DIR=_build

if [ ! -d $TMP_BUILD_DIR ]
then
	mkdir $TMP_BUILD_DIR
fi
cd $TMP_BUILD_DIR

../configure --prefix=$LIBS_DIR
make
make install

################

echo "building slirp"

cd $BUILD_DIR/libslirp-$LIBSLIRP_VERSION

if ! ../meson-$MESON_VERSION/meson.py setup _build --prefix=$LIBS_DIR --default-library static
then
	echo ERROR
	exit
fi

../meson-$MESON_VERSION/meson.py compile -C _build
../meson-$MESON_VERSION/meson.py install -C _build
