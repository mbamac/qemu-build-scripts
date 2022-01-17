# qemu-build-scripts

Scripts for building **qemu 6.2.0** on **macOS 12.1**. Qemu will be installed in `/Applications/qemu` directory.

## Building

Order of running scripts:

- `qemu-download.sh`: downloads required packages in `./download/` directory and them unpack to `./src/`
- `qemu-build-libs.sh`: builds and installs software required to build qemu. Libraries are installed in `/Applications/qemu-<version>`. Pkgconfig is installed in "Desktop" folder.
- `qemu-build.sh`: builds and installs `qemu` in `/Applications/qemu`

Scripts do not modify shell startup files, so you have to add `/Application/qemu-<version>/bin` to `$PATH`

Installed versions:
- qemu 6.2.0
- glib 2.71.0
- pkg-config 0.29.2
- pixman 0.40.0
- ninja 1.10.2
- meson 0.61.0

After successfull intalation you can remove files from `./download/`,`./src/` and `pkg-config/` from "Desktop"
