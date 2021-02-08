---
title: Instructions of post OS install
link: /post-os-installation
description: 
status: publish
tags: [Linux, git, user.name, user.email, override, overriding]
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/JTn9zj71M4c
---

# OS 재설치 후 해야 하는것 들

OS 재설치 후 해야 하는 내용들을 정리 한다. 

## 파일 복사

`rsync`를 이용한다.

### USB등 외부 디스크를 통한 복사
```
rsync -avzh $SRC $DST
```

### 네트워크(SSH)통한 복사.

시간이 오래 걸리지만 편함.

```
rsync -avz -e ssh $REMOTE_HOST:/$$SRC $DST
```

#### Root 권한이 필요한 경우

```
rsync -avz -e ssh --rsync-path='sudo ssh' $REMOTE_HOST:/$$SRC $DST
```

리모트 시스템에 해당 유저의 `sudo` 설정이  `NOPASSWD`로 설정되어 있아야 한다.

```
visudo
```

```
username ALL=NOPASSWD:/usr/bin/rsync
```

## Application

### Virtualbox
```
rsync -avzh $OLD_HOME/.config/VirtualBox $HOME/.config/VirtualBox
```

### Insync

Stop Insync

이미 Insync를 실행하여 설정 파일이 생성되어 있다면 파일을 삭제한다.
```
rm -rf $HOME/.config/Insync
```

파일을 복사한다.

```
rsync -avzh $OLD_HOME/.config/Insync $HOME/.config/Insync
```