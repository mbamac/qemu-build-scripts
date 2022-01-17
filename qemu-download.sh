BUILD_DIR=$(pwd)/src
DOWNLOAD_DIR=$(pwd)/download
QEMU_VERSION=6.2.0

function create_dir {
	if [ ! -d $1 ]
	then
		mkdir -p $1
	fi
}

function get_archive {
	curl -LO $1 #2> /dev/null
	if [ $? == 0 ]
	then
		echo
		echo "$1 saved!"
		echo
	else
		echo
		echo "Error downloading $1"
		exit 1
	fi
}

create_dir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

get_archive https://download.qemu.org/qemu-$QEMU_VERSION.tar.xz

get_archive https://gitlab.gnome.org/GNOME/glib/-/archive/2.71.0/glib-2.71.0.tar.gz
get_archive https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
get_archive https://www.cairographics.org/releases/pixman-0.40.0.tar.gz
get_archive https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-mac.zip
get_archive https://github.com/mesonbuild/meson/releases/download/0.61.0/meson-0.61.0.tar.gz

create_dir $BUILD_DIR
cd $BUILD_DIR

echo unpacking qemu-$QEMU_VERSION.tar.xz
tar xJf $DOWNLOAD_DIR/qemu-$QEMU_VERSION.tar.xz

echo unpacking glib
tar xzf $DOWNLOAD_DIR/glib-*.tar.gz

echo unpacking pkg-config
tar xzf $DOWNLOAD_DIR/pkg-config-*.tar.gz

echo unpacking pixman
tar xzf $DOWNLOAD_DIR/pixman-*.tar.gz

echo unpacking meson
tar xzf $DOWNLOAD_DIR/meson-*.tar.gz

echo unpacking ninja-mac.zip
unzip $DOWNLOAD_DIR/ninja-mac.zip

echo Done.


