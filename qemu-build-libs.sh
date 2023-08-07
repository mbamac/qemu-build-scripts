. ./deps-versions.sh

BUILD_DIR=$(pwd)/src
INSTALL_DIR=/Applications/qemu-$QEMU_VERSION
TMP_BUILD_DIR=build
PKG_CONFIG_DIR=/Users/m/Desktop/pkg-config

export PATH=$PATH:$BUILD_DIR:$INSTALL_DIR/bin:$PKG_CONFIG_DIR/bin

export PKG_CONFIG_PATH=$INSTALL_DIR/lib/pkgconfig


cd $BUILD_DIR

function go_build_dir {
	if [ ! -d $TMP_BUILD_DIR ]
	then
		mkdir $TMP_BUILD_DIR
	fi
	cd $TMP_BUILD_DIR
}

################

echo "building pkg-config"

mkdir -p $PKG_CONFIG_DIR
cd pkg-config-$PKG_CONFIG_VERSION
go_build_dir

../configure --prefix=$PKG_CONFIG_DIR --with-internal-glib
make
make install

################

echo "building glib"

cd $BUILD_DIR/glib-$GLIB_VERSION

if ! ../meson-$MESON_VERSION/meson.py _build --prefix=$INSTALL_DIR
then
	echo ERROR
	exit
fi
ninja -C _build
ninja -C _build install

################

echo "building pixman"

cd $BUILD_DIR/pixman-$PIXMAN_VERSION
go_build_dir

../configure --prefix=$INSTALL_DIR
make
make install

################

echo "building slirp"

cd $BUILD_DIR/libslirp-$LIBSLIRP_VERSION

export CFLAGS=-I$INSTALL_DIR/include
export CPPFLAGS=-I$INSTALL_DIR/include
export LDFLAGS=-L$INSTALL_DIR/lib
export LIBS=-L$INSTALL_DIR/lib
export LIBRARY_PATH=$INSTALL_DIR/lib
export DYLD_LIBRARY_PATH=$INSTALL_DIR/lib

export GLIB_LIBS=-L$INSTALL_DIR/lib
export GLIB_CFLAG=-I$INSTALL_DIR/include

if ! ../meson-$MESON_VERSION/meson.py build --prefix=$INSTALL_DIR
then
	echo ERROR
	exit
fi

ninja -C build install
