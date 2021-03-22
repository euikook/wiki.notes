---
titie: USB 설치 미디어 만들기
draft: false
date: 2021-03-22 07:37:55 +0900
tags: [iso, usb, bootable, USB Stick, Ubuntu, Arch, Arch Linux, ArchLinux]
banner: /images/ubuntu-desktop-install.png
---

## Prerequisite

자동 마운트기능이 활성화 되어 있다면 USB을 마운트해제한다. 

`lsblk` 명령으로 블럭 디바이스를 확인한다. 

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 953.9G  0 disk 
├─sda1        8:1    0   512M  0 part 
└─sda2        8:2    0 953.4G  0 part /home/data
sdc           8:32   1  14.3G  0 disk 
└─sdc1        8:33   1  14.3G  0 part /run/media/user/7AFC-CAE9
nvme0n1     259:0    0   1.9T  0 disk 
├─nvme0n1p1 259:1    0   512M  0 part /boot
├─nvme0n1p2 259:2    0    64G  0 part /
└─nvme0n1p3 259:3    0   1.8T  0 part /home
```

`sda`, `sdc`, `nvme0n1` 세개의 블럭 디바이스가 있다. 그중에 sdc가 USB 장치 이고 `sdc1` 이 `/run/media/user/7AFC-CAE9`에 마운트 되어 있다. 

마운트를 해제한다. 

<!--more-->

```
sudo umount /dev/sdc1
```

## Using `dd` command

---
```
dd bs=4M if=/path/to/iso-file of=/dev/sdX status=progress oflag=sync
```


아래는 Ubuntu 설치 iso 파일을 가지고 USB 설치 미디어를 만는 예제이다. 


`.iso` 파일을 USB로 복사한다. 

```
sudo dd bs=4M if=/home/user/Downloads/ubuntu-20.04.2.0-desktop-amd64.iso of=/dev/sdc status=progress oflag=sync
```

예제 출력

```
877227008 bytes (2.9 GB, 2.7 GiB) copied, 257 s, 11.2 MB/s
685+1 records in
685+1 records out
2877227008 bytes (2.9 GB, 2.7 GiB) copied, 257.353 s, 11.2 MB/s
```