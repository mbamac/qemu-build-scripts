. ./deps-versions.sh

BUILD_DIR=$(pwd)/src
INSTALL_DIR=/Applications/qemu-$QEMU_VERSION
TMP_BUILD_DIR=build
export PKG_CONFIG_DIR=/Users/m/Desktop/pkg-config

PATH=$PATH:$BUILD_DIR:$INSTALL_DIR/bin:$PKG_CONFIG_DIR/bin

export PKG_CONFIG_PATH=$INSTALL_DIR/lib/pkgconfig

export CFLAGS=-I$INSTALL_DIR/include
export CPPFLAGS=-I$INSTALL_DIR/include
export LDFLAGS=-L$INSTALL_DIR/lib
export LIBS=-L$INSTALL_DIR/lib
export LIBRARY_PATH=$INSTALL_DIR/lib
export DYLD_LIBRARY_PATH=$INSTALL_DIR/lib

export GLIB_LIBS=-L$INSTALL_DIR/lib
export GLIB_CFLAG=-I$INSTALL_DIR/include


cd $BUILD_DIR

function go_build {
	if [ ! -d $TMP_BUILD_DIR ]
	then
		mkdir $TMP_BUILD_DIR
	fi
	cd $TMP_BUILD_DIR
}

cd $BUILD_DIR/qemu-$QEMU_VERSION
go_build

../configure --prefix=$INSTALL_DIR --enable-slirp
make
make install

################
