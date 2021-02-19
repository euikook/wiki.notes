---
title: Shrink dynamically extended VirtualBox image for export appliance
link: /shrink-dynamically-allocated-virtualbox-disk-image-en
description: 
status: publish
tags: [Linux, VirtualBox, VDI, Shrink, Export]
created: 2020-10-21 08:35:41 +0900
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/aIlAhLdwk2g
aliases:
    - /gollum/shrink-dynamically-allocated-virtualbox-disk-image-en
    - /gollum/shrink-dynamically-allocated-virtualbox-disk-image-en.md
---


# Shrink dynamically extended VirtualBox image for export appliance

## Cleanup your system System

### Cleanup APT cache
```
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
```

### Cleanup docker cache (Optional, if you need)
```
docker system prune -a -f
```

### Uninstall snap (Optional, if you need)

```
sudo apt-get autoremove --purge snapd 
```


### Cleanup Logs (Optional, if you need)

```
for f in $(find /var/log -type f); do 
    sudo cat /dev/null > $f;
    echo "  Log $f has been cleared";
done
```

## Shutdown system and boot using ubuntu installation image.

After finish boot. Just press ALT+F2 switch to virtual terminal #2 end press Enter.

Set to zero free block using *zerofree* command.
```
sudo zerofree /dev/sda2
```
and shutdown your system
```
sudo shutdown -h now
```

## Export Virtual Machine

### Using export wizard.



### command line interface

Check virtual machine name using *vboxmanage list vms*
```
vboxmanage list vms
```

```
vboxmanage export $VM_NAME -o $IMG_NAME
```

Replace $VM_NAME with virtual machine name did you want to export.

Replcae $IMG_NAME to output file name did you want. e.g. ubuntu-bionic-server.ova


<!--stackedit_data:
eyJoaXN0b3J5IjpbNjA5ODU5MzMyXX0=
-->