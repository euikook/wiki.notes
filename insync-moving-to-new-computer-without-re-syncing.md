---
title: Insync Moving to new computer without re-syncing
link: /insync-moving-to-new-computer-without-re-syncing
description: 
status: publish
tags: [Linux, Insync, Move, Moving, re-syncing, sync]
date: 2021-03-08 22:34:24 +0900
lastmod: 2021-03-08 22:34:24 +0900
banner: https://uploads-ssl.webflow.com/5c5bbc2b7ebe99d46f9e983b/5cf14ca1fb8dd08aa53a2e58_InsyncSignIn.png
aliases:
    - /gollum/insync-moving-to-new-computer-without-re-syncing
    - /gollum/insync-moving-to-new-computer-without-re-syncing.md
---

이 글에서는 Insync을 사용중 PC를 옯기거나 OS를 재설치 하여야 하는 경우 재 동기화 없이 데이터를 옮기는 방법에 대하여 설명한다. 


## Insync 종료

PC를 *Apple*에서 *Banana*로 옯기는 경우 *Apple* PC와 *Bnana* PC에서 *Insync*를 종료 한다. 
OS를 다시 설치 하는 경우 해당 PC의 *Insync*만 종료 한다. 


```
insync quite
```

```
insync-headless quite
```

## Data 디렉터리 백업 또는 이동

### 다른 컴퓨터로 이동  
*Insync*의 동기화 폴더를 *Apple*에서 *Banana*로 이동한다. 

리눅스의 경우 rsync로  동기화 할 수 있다. 이동 하고자 하는 *Banana*에 접속 하여 아래 명령을 수행한다. 


```
/usr/bin/rsync  -apvz  -e " ssh  " \
--numeric-ids \
"Apple:~/Insync" "~/Insync" 
```
>  실제 명령 입력 시 `Apple`은 자신의 기존 컴퓨터의 호스트네임으로 변경한다.


### OS 재설치
OS를 다시 설치 하는 경우 해당 PC의 동기화 폴더를 백업한다. 

리눅스의 경우 별도의 저장 장치에 저장하거나 OS를 재설치 하더라도 지워지지 않는 디렉터리에 저장한다. 

예제에서는 `/mnt/backup/` 디렉터리에 Insync.data.tar라는 이름으로 백업한다. 

```
tar cvf ~/mnt/backup/Insync.data.tar ~/Insync
```

재설치 후 백업된 데이터를 복구 한다.

OS 재설치 후 Insync를 설치 하고 실행 않은 상태에서 데이터를 복원한다. 이미 설치 하여 `~/Insync` 디렉터리가 존재 할 경우 삭제 복구 한다. 


```
rm -rf ~/Insync
```

백업 데이터를 복구한다. 

```
tar xvf ~/mnt/backup/Insync.data.tar -C ~/
```




## 설정 파일 백업 또는 이동

Insync의 설정 데이터와 인증 정보와 같은 설정 동기화 정보의 위치는 아래와 같다. 

해당 디렉터리를 이동하거나 백업 한다. 


* Windows
    
    * `C:\Users\[Username]\AppData\Roaming\Insync`
    * `C:\Users\[Username]\AppData\Roaming\Insync-headless`

* Mac OS:
  
    * `~/Library/Application Support/Insync`
    * `~/Library/Application Support/Insync-headless`

* Linux

    * `~/.config/Insync`
    * `~/.config/Insync-headless`


### 다른 컴퓨터로 이동

 *Insync*의 동기화 폴더를 *Apple*에서 *Banana*로 이동한다. 

리눅스의 경우 rsync로  동기화 할 수 있다. 이동 하고자 하는 *Banana*에 접속 하여 아래 명령을 수행한다. 


```
/usr/bin/rsync  -apvz  -e " ssh  " \
--numeric-ids \
"Apple:~/.config/Insync" "~/.config/Insync" 
```

> Headless 버전의 경우 `~/.config/Insync`를 `~/.config/Insync-headless`로 변경한다. 

> 실제 명령 입력 시 `Apple`은 자신의 기존 컴퓨터의 호스트네임으로 변경한다.


### OS 재설치
OS를 다시 설치 하는 경우 해당 PC의 동기화 폴더를 백업한다. 

리눅스의 경우 별도의 저장 장치에 저장하거나 OS를 재설치 하더라도 지워지지 않는 디렉터리에 저장한다. 

예제에서는 `/mnt/backup/` 디렉터리에 `Insync.config.tar`라는 이름으로 백업한다. 

```
tar cvf ~/mnt/backup/Insync.config.tar ~/.config/Insync
```

재설치 후 백업된 데이터를 복구 한다.


OS 재설치 후 Insync를 설치 하고 실행 않은 상태에서 데이터를 복원한다. 이미 설치 하여 `~/config/Insync` 디렉터리가 존재 할 경우 삭제 복구 한다. 

```
rm -rf ~/.config/Insync
```

복구한다. 
```
tar xvf ~/mnt/backup/Insync.config.tar -C ~/
```

> OS 재설치 후 Insync를 설치 하고 실행 않은 상태에서 데이터를 복원한다. 


## Insync 시작 및 확인


```
insync start
```

```
insync-headless start
```

아래 명령으로 Insync의 상태를 확인한다. 

```
insync show
```

```
insync-headless status
```