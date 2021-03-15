---
title: Auto mount removable drives to specific mounting point
link: /auto-mount-removable-drives-to-specific-mounting-point
description: 
status: draft
tags: [Linux, Arch, Arch Linux, Gnome, auto mounting, mount, usb, removable]
date: 2020-11-17
lastmod: 2020-11-17 17:14:32 +0900
banner: https://source.unsplash.com/vRSMuso1pXw
aliases:
    - /auto-mount-removable-drives-to-specific-mounting-point
    - /auto-mount-removable-drives-to-specific-mounting-point.md
    - /gollum/auto-mount-removable-drives-to-specific-mounting-point
    - /gollum/auto-mount-removable-drives-to-specific-mounting-point.md
---

# Auto mount removable drives to specific mounting point


Check Block identifier for disk using `blkid` command.

{{< gist euikook 5bed603d4963dad2949df8136f41447e "blkid.sh" >}}


{{< gist euikook 5bed603d4963dad2949df8136f41447e "blkid.example.sh" >}}

`<blkid>` is `ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3`

Unmount disk if it alrady mounted

{{< gist euikook 5bed603d4963dad2949df8136f41447e "umount.sh" >}}

<!--more-->

Edit `/etc/fstab`
{{< gist euikook 5bed603d4963dad2949df8136f41447e "fstab" >}}

`/usr/local/bin/usb-mount`

{{< gist euikook 5bed603d4963dad2949df8136f41447e "usb-mount.sh" >}}

{{< gist euikook 5bed603d4963dad2949df8136f41447e "chmod.sh" >}}


`cat /etc/systemd/system/usb.mount@.service`

{{< gist euikook 5bed603d4963dad2949df8136f41447e "usb.mount@.service" >}}


{{< gist euikook 5bed603d4963dad2949df8136f41447e "daemon-reload.sh" >}}


Create `/etc/udev/rules.d/99-usb-ssd.rules`

{{< gist euikook 5bed603d4963dad2949df8136f41447e "99-usb-ssd.rules" >}}

{{< gist euikook 5bed603d4963dad2949df8136f41447e "udevadm.sh" >}}
