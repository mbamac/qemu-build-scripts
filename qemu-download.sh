BUILD_DIR=$(pwd)/src
DOWNLOAD_DIR=$(pwd)/download
. ./deps-versions.sh

function create_dir {
	if [ ! -d $1 ]
	then
		mkdir -p $1
	fi
}

function get_archive {
	if [ -f $2 ]
	then
		echo "aleardy downloaded $1$2"
 		return
	fi
	echo "downloading $1$2"
	curl -LO $1$2 #2> /dev/null
	if [ $? == 0 ]
	then
		echo
		echo "$1$2 saved!"
		echo
	else
		echo
		echo "Error downloading $1$2"
		exit 1
	fi
}

create_dir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

get_archive https://download.qemu.org/ qemu-$QEMU_VERSION.tar.xz
get_archive https://download.gnome.org/sources/glib/$GLIB_MAIN_VERSION/ glib-$GLIB_VERSION.tar.xz
get_archive https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$PCRE2_VERSION/ pcre2-$PCRE2_VERSION.tar.gz
get_archive https://pkgconfig.freedesktop.org/releases/ pkg-config-$PKG_CONFIG_VERSION.tar.gz
get_archive https://www.cairographics.org/releases/ pixman-$PIXMAN_VERSION.tar.gz
get_archive https://github.com/ninja-build/ninja/releases/download/v$NINJA_VERSION/ ninja-mac.zip
get_archive https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/ meson-$MESON_VERSION.tar.gz

create_dir $BUILD_DIR
cd $BUILD_DIR
rm -rf *

echo unpacking qemu-$QEMU_VERSION.tar.xz
tar xJf $DOWNLOAD_DIR/qemu-$QEMU_VERSION.tar.xz

echo unpacking glib
tar xJf $DOWNLOAD_DIR/glib-$GLIB_VERSION.tar.xz

echo unpacking pkg-config
tar xzf $DOWNLOAD_DIR/pkg-config-$PKG_CONFIG_VERSION.tar.gz

echo unpacking pixman
tar xzf $DOWNLOAD_DIR/pixman-$PIXMAN_VERSION.tar.gz

echo unpacking meson
tar xzf $DOWNLOAD_DIR/meson-$MESON_VERSION.tar.gz

echo unpacking ninja-mac.zip
unzip $DOWNLOAD_DIR/ninja-mac.zip

echo Done.


