---
title: Auto mount removable drives to specific mounting point
link: /auto-mount-removable-drives-to-specific-mounting-point
description: 
status: draft
tags: [Linux, Arch, Arch Linux, Gnome, auto mounting, mount, usb, removable]
date: 2020-11-17 17:14:32 +0900
---

# Auto mount removable drives to specific mounting point


Check Block identifier for disk using `blkid` command.
```
blkid
```

```
blkid /dev/sda2
/dev/sda2: UUID="ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="39b52ccd-5972-4bb7-ba9b-279441d990df"
```

`<blkid>` is `ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3`


Unmount disk if it alrady mounted
```
sudo umount /dev/sda2
```


Edit `/etc/fstab`
```
# Disk from USB
UUID=ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3	/home/data     	ext4      	noauto,rw,relatime	0 2
```

`/usr/local/bin/usb-mount`

```
#!/bin/bash

UUID=$2
DEVF=$(blkid --uuid ${UUID})

[[ -n ${DEVF} ]] || {
    echo " No such disk partition from ${UUID}"
    exit -1
}

# Check partition already mounted
MOUNTED=$(/bin/mount | /bin/grep ${DEVF} | /usr/bin/awk '{ print $3 }')

start() {
    [[ -n ${MOUNTED} ]] || {
        /bin/mount -U ${UUID}
    }
	
}

stop()
{
    [[ -n ${MOUNTED} ]] && {
        /bin/umount -l ${DEVF}
    } || exit 0
}

status() {
    /bin/mount | /bin/grep ${DEVF} || exit 0
}

case "${1:-status}" in
    start)
       	start
        ;;
    stop)
        stop
	;;
    restart)
	stop
	start
        ;;
    status)
	status
	;;
    *)
        echo "Usage: $0 {start|stop|restart|status}" >&2
        exit 1
        ;;
esac
```

```
sudo chmod +x /usr/local/bin/usb-mount`
```


`cat /etc/systemd/system/usb.mount@.service`
```

[Unit]
Description=Mount USB Disk %i

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/usr/local/bin/usb.mount start %i
ExecStop=/usr/local/bin/usb.mount stop %i
```

```
sudo systemctl daemon-reload
```

Create `/etc/udev/rules.d/99-usb-ssd.rules`

```
ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3", ENV{UDISKS_IGNORE}="1", RUN+="/usr/bin/systemctl start usb.mount@$env{ID_FS_UUID}.service"
ACTION=="remove", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="ef6e4eba-7ad9-4a4c-be75-3b85ba2d14a3", ENV{UDISKS_IGNORE}="1", RUN+="/usr/bin/systemctl stop usb.mount@$env{ID_FS_UUID}.service"

```

```
sudo udevadm control --reload-rules && sudo udevadm trigger
```