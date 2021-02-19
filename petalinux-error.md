---
title: Petalinux error on ArchLinux
tags: [Linux, ArchLinux, PetaLinux, Xilinx]
banner: https://source.unsplash.com/qvBYnMuNJ9A
date: 2020-12-21
lastmod: 2020-12-21 15:41:13 +0900
aliases:
    - /gollum/petalinux-error
    - /gollum/petalinux-error.md
---
## Errors

```
petalinux-config -c rootfs
```

```
[INFO] generating Kconfig for project
ERROR: Failed to generate /home/euikook/working/oran/xilinx/102/build/misc/config/Kconfig.syshw
ERROR: Failed to Kconfig project
ERROR: Failed to config rootfs.
```

`petalinux-config` with the `-v` option

```
petalinux-config -c rootfs -v
```

```
[INFO] generating Kconfig for project
package require hsi FAILED:
invalid command name "hsi::create_dt_node"
    while executing
"hsi::create_dt_node -help"
    (in namespace eval "::hsi::help" script line 6)
    invoked from within
"namespace eval ::hsi::help {
    variable version 0.1

    ::xsdb::setcmdmeta {hsi create_dt_node} categories {hsi}
    ::xsdb::setcmdmeta {hsi create..."
    (file "/home/euikook/Tools/Xilinx/PetaLinux/2019.2/tools/xsct/scripts/xsct/hsi/hsihelp.tcl" line 25)
    invoked from within
"source /home/euikook/Tools/Xilinx/PetaLinux/2019.2/tools/xsct/scripts/xsct/hsi/hsihelp.tcl"
    ("package ifneeded hsi::help 0.1" script)
ERROR: Failed to generate /home/euikook/working/oran/xilinx/102/build/misc/config/Kconfig.syshw
ERROR: Failed to Kconfig project
ERROR: Failed to config rootfs.
```


## Arch linux

```
yay -Syu ncurses5-compat-libs
```


## Others 

### Create synblic link

```
sudo ln -s libtinfo.so.6 /usr/lib/libtinfo.so.5
sudo ln -s  libncursesw.so.6.2 /usr/lib/libncursesw.so.5
```

### Remove Linx
sudo rm -rf /usr/lib/libtinfo.so.5 /usr/lib/libncursesw.so.5