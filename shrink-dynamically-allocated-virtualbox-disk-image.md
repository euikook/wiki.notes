---
title: Shrink dynamically extended VirtualBox image for export appliance
link: /shrink-dynamically-allocated-virtualbox-disk-image
description: 
status: publish
tags: [Linux, VirtualBox, VDI, Shrink, Export]
date: 2020-11-12 12:40:05 +0900
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/aIlAhLdwk2g
aliases:
    - /gollum/shrink-dynamically-allocated-virtualbox-disk-image
    - /gollum/shrink-dynamically-allocated-virtualbox-disk-image.md
---

# Shrink dynamically allocated  VirtualBox Disk Image(VDI) 
## Motivation

업무에 [VirtualBox](https://www.virtualbox.org/)을 자주 활용한다.   

개발 환경등을 시스템에 설치 하기 힘들때 VirtualBox를 사용하여 개발환경을 구축 하거나 결과물을 설치 하여 테스트용으로 배포한다.

여러대의 머신이 필요하지만 AWS나 GCP를 사용하기 힘들때 유용한 대안이 바로 VirtualBox이다. 

Virtualbox 가상머신의 디스크를 **동적 할당 디스크**로 생성 하였을 경우 경우 환경 설치 후 불필요한 파일을 삭제 하더라도 디스크의 크기가 줄어들지 않기 때문에 내보내기 한 이미지도 같이 커진다.

혼자만 사용할 때는 디스크 용량만 차지할 뿐 아무 문제가 없지만 가상머신을 배포 해야 하는 경우가 되면 이미지의 사이즈가 너무 커서 배포하기 부담스러워 진다.

위와 같은 경우에 효율적인 배포를 위한 동적 할당 디스크의 이미지 사이즈를 줄이는 방법을 소개 한다.


`vboxmanage modifymedium --compact` 명령을 이용하여 VDI 이미지 사이즈를 줄일 수 있다.  `--compact` 옵션에 대한 설명은 다으과 같다.

<!--more-->

> The `--compact` option can be used to compact disk images. Compacting removes blocks that only contains zeroes. Using this option will shrink a dynamically allocated image. It will reduce the _physical_ size of the image without affecting the logical size of the virtual disk. Compaction works both for base images and for differencing images created as part of a snapshot.

자세한 내용은 [여기](https://docs.oracle.com/cd/E97728_01/E97727/html/vboxmanage-modifyvdi.html)를 참고.

하지만 위의 설명과 같이  `--compact` 옵션은 VDI 파일에서 빈 블럭(only contains zero)만을 찾아 제거해주는 옵션이다.

리눅스 시스템에서 `rm` 명령으로 파일을 삭제하더라도 해당 블럭이 실제로 zeroing 되는 것이 아니기 때문에 명령을 실행전 설치된 운영체제나 파일시스템에 맞는 방법으로 비어 있는 블럭을 zeroing 해주어야 한다. (파일 시스템이 extN인 경우 [`zerofree`](http://manpages.ubuntu.com/manpages/xenial/man8/zerofree.8.html) 명령을 사용하여 zeroing을 한다.


## Cleanup your system System (Optional)
불필요한 파일을 삭제 하자.  (필요한 경우에만 수행한다.)

### Cleanup APT cache
```
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
```

### Cleanup docker cache
도커를 사용 하는 경우 테스트를 위해 여러 이미지를 당겨받아 테스트 하다 보면 꽤많은 용량을 사용하게 된다. 

모두 삭제하고 
```
docker system prune -a -f
```
**필요한 이미지만** 다시 당겨받자.
```
docker pull mongo:4
```
 
### Uninstall snap package.
사용하지 않을 경우 삭제 하자.
```
sudo apt-get autoremove --purge snapd
```

### Cleanup */var/log*
시스템을 오래 사용하였을 경우 꽤 많은 로그가 쌓여 있다. 삭제할경우 동작중인 프로그램에 문제가 생길수도 있으니 빈 파일로 만든다.
```
for f in $(find /var/log -type f); do
	sudo cat /dev/null > $f;
	echo " Log $f has been cleared";
done
```
정리를 마쳤으면 시스템을 끈다.
```
sudo shutdown -h now
```

## Zeroing Free Blocks

`zerofree` 명령으로 빈 블럭을 zeroing 하기 위해서는 Root Filesystem을 Readonly Mode로 마운팅 해야 하지만 부팅 상태에서는 잘 되지 않는다. 
```
$ sudo mount -o remount,ro /
mount: /: mount point is busy.
```

여러 방법이 있지만 가장 간단한 Ubuntu 설치 이미지로 부팅한 한 후 `zerofree` 명령으로 Free Block을 Zeroing 하자. 

[Ubuntu 18.04.2 Server Live ](http://releases.ubuntu.com/18.04.2/ubuntu-18.04.2-live-server-amd64.iso) 이미지를 이용하였다.  (이미지에 `zerofree` 명령이 포함되어 있다.)

부팅이 완료된후 다음 과 같은 화면이 나오면 

<img src="https://drive.google.com/uc?id=1C81v5lazrhcVFVKvqN47LC38PzLPRMIr" class="post-image-center">

뜨면 `ALT`+`F2` 키를 눌러 터미널을 실행 시킨다.

<img src="https://drive.google.com/uc?id=10ICCcEs_AlDgPYRBRjDBFxP7EgJTIW-Z" class="post-image-center">

`zerofree` 명령을 사용하여 빈 블럭을 제로잉 한다. 

```
sudo zerofree /dev/sda2
```

완료되면 시스템 종료한다.

```
sudo shutdown -h now
```

## Compact the VDI file.

`vboxmanage modifymedium --compact` 명령을 이용하여 VDI 이미지 사이즈를 줄인다. 

디스크 파일의 위치를 확인하자

```
vboxmanage showvminfo ubuntu-bionic-server |grep vdi
```

아래와 같은 결과를 얻을 수 있다.
```
SATA (0, 0): /home/harues/VMs/ubuntu-bionic-server.vdi (UUID: ********-****-****-****-************)
```

`--compact` 옵션으로 VDI 파일의 사이즈를 줄인다. 
```
vboxmanage modifymedium "/home/harues/VMs/ubuntu-bionic-server.vdi" --compact
```

## Export Virtual Machine

### Using export wizard.
  

### Using Command Line Interface

*vboxmanage list vms* 명령으로 내보낼 가상머신의 이미지를 확인한다.

```
vboxmanage list vms
```

*vboxmanage export* 명령으로 VM 을 내 보낸다.
```
vboxmanage export $VM_NAME -o $IMG_NAME
```

* *$VM_NAME* 은 내보내고자 하는 가상머신의 이름으로 대체 한다. (예: ubuntu-bionic-server)

* *$IMG_NAME* 은 생성될 이미지의 이름으로 대체한다.  (예: ubuntu-bionic-server.ova)

`vboxmanage export` 의 자세한 사용법은 아래 명령을 참고하자
```
vboxmanage export --help
```
다음과 같이 생성될 이미지 파일에 메타데이터를 추가 할수도 있다.
```
vboxmanage export ubuntu-bionic-server \
                  --output ubuntu-bionic-server.ova \
                  --vsys 0 \
                  --product "Ubuntu Clean Image" \
                  --producturl "https://harues.com/posts/" \
                  --vendor "Harues.com" \
                  --vendorurl "https://harues.com" \
                  --version "1.0.0" \
                  --description "Ubuntu Bionic Server Clean Installation"
```