# qemu-build-scripts

Scripts for building **qemu** on **macOS 13.4**. Qemu will be installed in `/Applications/qemu-<version>` directory.

## Building

Order of running scripts:

- `qemu-download.sh`: downloads required packages in `./download/` directory and them unpack to `./src/`. Both directories are created in current directory.
- `qemu-build-libs.sh`: builds and installs software required to build qemu. Libraries are installed in `/Applications/qemu-<version>` except Pkgconfig, which is installed in `~/Desktop/pkg-config/` folder. Please note that the script does not build `qemu`.
- `qemu-build.sh`: builds and installs `qemu` in `/Applications/qemu-<version>`

Scripts do not modify shell startup files, so you have to add `/Application/qemu-<version>/bin` to `$PATH`

Installed versions:
- qemu 8.0.3
- glib 2.77.1
- pkg-config 0.29.2
- pixman 0.40.0
- ninja 1.11.1
- meson 1.2.0

After successfull intalation you can remove files from `./download/`, `./src/` and `~/Desktop/pkg-config/`
