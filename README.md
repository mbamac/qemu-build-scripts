# qemu-build-scripts

Scripts for building **qemu** on **macos 14.4** or **macos 15.0**. Qemu will be installed in `/Applications/qemu-<version>` directory.


## Prerequsites

Before running scripts you should install python module with command:

```python3 -m pip install packaging```

or on macos Sequoia:

```python3 -m pip install tomli```

## Building

Order of running scripts:

- `qemu-download.sh`: downloads required packages in `./download/` directory and them unpack to `./src/`. Both directories are created in current directory.
- `qemu-build-libs.sh`: builds and installs software required to build qemu. Libraries are installed in `./lib/`. All libs are build static only. Please note that the script does not build `qemu`.
- `qemu-build.sh`: builds and installs `qemu` in `/Applications/qemu-<version>`

Scripts do not modify shell startup files, so you have to add `/Application/qemu-<version>/bin` to `$PATH`

Installed versions:
- qemu 9.0.0
- glib 2.80.0
- pkg-config 0.29.2
- libslirp 4.7.0
- ninja 1.11.1
- meson 1.2.0

After successfull intalation you can remove files from `./download/`, `./src/` and `./lib/`
