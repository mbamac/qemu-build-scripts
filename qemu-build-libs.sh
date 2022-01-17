QEMU_VERSION=6.2.0
GLIB_VERSION=2.71.0
PKG_CONFIG_VERSION=0.29.2
PIXMAN_VERSION=0.40.0
NINJA_VERSION=1.10.2
MESON_VERSION=0.61.0
#LIBFFI_VERSION=3.4.2

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

mkdir -p $PKG_CONFIG_DIR
cd pkg-config-$PKG_CONFIG_VERSION
go_build_dir

../configure --prefix=$PKG_CONFIG_DIR --with-internal-glib
make
make install

################

cd $BUILD_DIR/glib-2.71.0

../meson-$MESON_VERSION/meson.py _build --prefix=$INSTALL_DIR
ninja -C _build
ninja -C _build install

################

cd $BUILD_DIR/pixman-$PIXMAN_VERSION
go_build_dir

../configure --prefix=$INSTALL_DIR
make
make install

