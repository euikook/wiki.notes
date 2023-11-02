---
title: 리눅스에서 USB 설치 미디어 만들기
draft: false
date: 2021-03-22 07:37:55 +0900
tags: [iso, usb, bootable, USB Stick, Ubuntu, Arch, Arch Linux, ArchLinux]
banner: /images/ubuntu-desktop-install.png
---

## Prerequisite

어떤 설치 미디어나 라이브 디스크 라도 상관 없지만 이 글에서는 우분투를 기준으로 설명 하도록 한다. 

### 설치 미디어 다운로드 및 검증

원하는 우분투 미러 사이트에서 설치 미디어를 다운로드 한다.  

> 이글에서는 [*ubuntu-22.04.3-live-server-amd64.iso*](https://mirror.kakao.com/ubuntu-releases/22.04.3/ubuntu-22.04.3-live-server-amd64.iso) 파일을 기준으로 설명 한다. 

파일의 검증을 위해 [*SHA256SUM*](https://mirror.kakao.com/ubuntu-releases/22.04.3/SHA256SUMS) 파일과 [*SHA256SUM.gpg*](https://mirror.kakao.com/ubuntu-releases/22.04.3/SHA256SUMS.gpg) 파일도 같이 다운로드 한다. 

*SHA256SUM* 파일은 내려 받은 *ubuntu-22.04.3-live-server-amd64.iso* 파일이 손상 되거나 변조 되었을 우려가 있으므로 파일의 SHA256 해시가 저장되어 있어 파일의 무결성 검증에 사용된다. *SHA256SUM.gpg* 파일은 *SHA256SU*M에 GPG 서명으로 *SHA256SUM* 파일이 손상되거나 변조 되었을 경우 이를 인지 하기 위해 사용된다. 

먼저 *SHA256SUM.gpg* 파일을 이용해 *SHA256SUM* 파일을 검증한다.

```shell
gpg --verify SHA256SUMS.gpg SHA256SUMS
```

아래와 같은 에러 메시지가 나온다면 키서버로 부터 공개키를 내려 받아야 한다. 

```shell
$ gpg --verify SHA256SUMS.gpg SHA256SUMS
gpg: Signature made Fri 11 Aug 2023 03:33:07 AM KST
gpg:                using RSA key 843938DF228D22F7B3742BC0D94AA3F0EFE21092
gpg: Can't check signature: No public key
```

공개키의 ID 가 **843938DF228D22F7B3742BC0D94AA3F0EFE21092** 이라는 것을 알 수 있다. 

```
gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 843938DF228D22F7B3742BC0D94AA3F0EFE21092
```

해당 키를 내려 받는다. 

```
$ gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 843938DF228D22F7B3742BC0D94AA3F0EFE21092
gpg: key D94AA3F0EFE21092: public key "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```

공개키를 내려 받았음니 *SHA256SUM* 파일을 다시 검증해 보자.


```shell
$ gpg --verify SHA256SUMS.gpg SHA256SUMS
gpg: Signature made Fri 11 Aug 2023 03:33:07 AM KST
gpg:                using RSA key 843938DF228D22F7B3742BC0D94AA3F0EFE21092
gpg: Good signature from "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092
```

***gpg: Good signature from "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" [unknown]***

위와 같은 출력이 나온다면 *SHA256SUMS* 파일의 무결성은 확인 되었다. 

이제 *SHA256SUMS* 파일을 이용하여 *ubuntu-22.04.3-live-server-amd64.iso* 파일의 무결성을 검증해보자. 


*SHA256SUMS* 파일의 내용을 보면 sha256 해시와 파일 대상파일의 파일명이 같이 기술되어 있다. 

```
a435f6f393dda581172490eda9f683c32e495158a780b5a1de422ee77d98e909 *ubuntu-22.04.3-desktop-amd64.iso
a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd *ubuntu-22.04.3-live-server-amd64.iso
```

아래 명령을 이용하여 *ubuntu-22.04.3-live-server-amd64.iso*의 무결성을 검증한다. 

*SHA256SUMS* 파일에는 2개의 파일이 기술되어 있지만 우리는 *ubuntu-22.04.3-live-server-amd64.iso* 파일만 다운로드 하였기 때문에 `--ignore-missing` 옵션을 이용하여 없는 파일은 무시 하도록 한다. 4


```
sha256sum --check --ignore-missing SHA256SUMS
```


아래와 같이 ***OK*** 가 나오면 iso 파일의 무결성은 검증이 완료 되었다. 
```shell
$ sha256sum --check --ignore-missing SHA256SUMS
ubuntu-22.04.3-live-server-amd64.iso: OK
```

***FAILED*** 가 나온다면 파일이 손상되었거나 변경되었다는 의미 이므로 다시 다운로드 하자. 


### 설치 미디어 준비 

자동 마운팅 기능이 활성화 되어 있거나 수동으로 마운팅 하여 USB저장 장치가 마운트 되어 있다면 마운트해제한다. 

`lsblk` 명령으로 블럭 디바이스를 확인한다. 

```shell
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



```
sudo umount /dev/sdc1
```

<!--more-->

`lsblk` 명령으로 확인한다. 

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 953.9G  0 disk 
├─sda1        8:1    0   512M  0 part 
└─sda2        8:2    0 953.4G  0 part /home/data
sdc           8:16   1  14.3G  0 disk 
└─sdc1        8:33   1  14.3G  0 part 
nvme0n1     259:0    0   1.9T  0 disk 
├─nvme0n1p1 259:1    0   512M  0 part /boot
├─nvme0n1p2 259:2    0    64G  0 part /
└─nvme0n1p3 259:3    0   1.8T  0 part /home
```

## Using `dd` command

---
```
dd bs=4M if=/path/to/iso-file of=/dev/sdX status=progress oflag=sync
```


다음은 Ubuntu 22.04.3 Server 설치용 ISO 파일을 가지고 USB 설치 미디어를 만는 예제이다. 


`.iso` 파일을 USB로 복사한다. 

```
sudo dd bs=4M if=/home/user/Downloads/ubuntu-22.04.3-live-server-amd64.iso of=/dev/sdc status=progress oflag=sync
```

예제 출력

```
877227008 bytes (2.9 GB, 2.7 GiB) copied, 257 s, 11.2 MB/s
685+1 records in
685+1 records out
2877227008 bytes (2.9 GB, 2.7 GiB) copied, 257.353 s, 11.2 MB/s
```

완료 되었으면 USB 저장 장치를 분리 한 후 다시 삽입한다. 


`lsblk` 명령으로 확인 해보자.

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdc           8:16   1  14.3G  0 disk 
├─sdc1        8:17   1   2.7G  0 part /run/media/user/Ubuntu-Server 22.04.3 LTS amd64
└─sdc2        8:18   1   3.9M  0 part 
```

정상적으로 설치 미디어가 만들어졌다. 