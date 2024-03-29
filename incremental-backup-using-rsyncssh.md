---
title: RSYNC+SSH 를 이용한 증분 백업 설정 및 Cron을 이용한 자동화
link: /incremental-backup-using-rsyncssh
description: 
status: publish
tags: [Linux, Backup, Incremental Backup, RSYNC, SSH, cron]
date: 2018-02-20
lastmod: 2021-02-19 10:47:41 +0900
banner: https://source.unsplash.com/5yEiCUynJ9w
---

RSYNC+SSH 를 이용한 증분 백업 및 Cron을 이용한 자동화


관리 하는 서버가 많아지고 서버에 저장되는 데이터의 양이 늘어 날 수록 백업을 어떻게 하여야 하는지 고민이 생긴다. 

이 포스트에서는 RSYNC와 SSH를 이용하여 여러 서버의 데이터를 백업하고 이를 자동화 하는 방법에 대하여 기술 한다. 테스트를 위한 서버 구성은 다음과 같다.   

아래 예제 에서는 *apple*, *banana*, *coconut*의 */home* 디렉터리를 backupbot으로 백업 하고자 한다. 

![Backup Environment](/images/backup-env.png)

<!--more-->

## 공통 준비 사항

### Backup User 생성

백업 서버와 백업을 할 서버 모두 백업을 위한 사용자 계정 `backupbot`을 생성한다. 
    
```bash
sudo adduser --disabled-password --gecos 'BackupBot' backupbot
```

`/etc/hosts` 파일을 편집하여 아래 와 같이 host 정보를 추가 한다.

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "hosts" >}}

## SSH 키 생성 및 배포
Backup 서버에서 SSH Key Pair를 생성하고 각 서버로 배포 한다. 

`ssh-keygen` 명령으로 SSH Key pair를 생성한다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "ssh-keygen.sh" >}}
    

### SSH KEY 배포

Private Key를 backupbot 서버의 backupbot 계정으로 복사한다.

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "dist.pub.key.sh" >}}


공개 키(`backupbot.pub`)를 각 서버의 `backupbot` 계정으로 복사한다. 

*backupbot* 계정은 *password*를 지정하지 않았기 때문에 직업 복사할 수 없으므로 개인 개정(*user*)으로 먼저 복사한 다음 *backupbot* 계정으로 복사한다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "scp-backupbot.pub.sh" >}}
    

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "ssh-copy-id.sh" >}} 


## Apple, Banana, Coconut

apple, banana, coconut 서버에 접속 하여 다음과 같이 설정 한다. 

### 필요 패키지 설치
    
{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "apt-rsync.sh" >}} 

### 권한 설정

`/etc/sudoers` 파일을 열어 권한을 설정 한다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "visudo.sh" >}} 

backup 계정은 다른 계정에서 생성한 파일들에 대한 접근 권한이 없으므로 *backupbot* 계정으로 `/home` 디렉터리를 백업 하기 위해서는 `sudo`명령으로 root permission을 획득 하여야 한다. *backupbot* 계정이 password없이 rsync 명령을 수행 할 수 있도록 아래 내용을 추가 한다.

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "sudoer" >}} 
    

## Backupbot

### 필요 패키지 설치

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "apt-rsync-uuid.sh" >}} 

### SSH Client 설정

~/.ssh/config 파일을 열어 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "vi-ssh.config" >}} 

다음과 같이 설정한다. (해당 파일이 없을 경우 생성한다.) 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "ssh.config" >}} 

다음 명령으로 배포된 KEY로 SSH접속이 정상적으로 되는지 확인한다. Password를 물어보지 않고 접속되어 명령쉘이 뜨면 성공이다.  
    

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "ssh-conn.sh" >}} 

## RSYNC명령을 이용한 수동 백업


{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "rsync-manual.sh" >}} 

위 명령을 실행 하면 `apple` 서버의 `/home` 디렉터리를  `backupbot` 서버의 `/home/backupbot/apple/latest` 에 동기화 한다. 

## 증분 백업

rsync 명령으로 동기화를 하면 수정된 파일은 덮어 써지거나 삭제 되기 때문에 기록이 남지 않는다. 기록을 남기 기 위해서는 동기화전 기존 백업을 다른 이름으로 복사하고 동기화 하면 되지만 생으로 복사를 하면 디스크 용량이 두배로 늘기 때문에 효율적이지 않다. 리눅스에서 제공하는 *hard link*를 사용하면 될것 같지만 Hard Link는 디렉터리에 적용할 수 없다. 

`cp` 명령의 `-l` 옵션을 사용하면 디렉터리는 카피가 되고 파일은 *hard link*로 생성된다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "cp-al.sh" >}} 

위 명령으로 복사 후 `rsync`명령으로 동기화 하면 최근 동기화 데이터를 남기면서 최신 데이터를 백업 할 수 있다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "rsync-manual.sh" >}} 


`rsync` 명령에서 `--link-dest` 옵션으로 `cp`명령의 `-l` 옵션과 같은 효과를 볼 수 있다. 

먼저 최신 백업을 다른이름으로 저장한다.


{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "mv-dir.sh" >}} 

`rsync` 명령행에 `--link-dest="/home/backupbot/apple/previous"` 옵션을 추가 한다. 


{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "rsync-link-dest.sh" >}} 


`/home/backupbot/apple/previous` 를 `/home/backupbot/apple/$(date +%Y%m%D%H%M%S)`로 바꾸면 날짜 + 시간으로 백업 데이터를 관리 할 수 있다.


## Backupman 스크립트를 이용한 자동화

앞서 설명한 백업 절차를 자동화 하는 Python 스크립트를 만들었다. 

사용방법은 다음과 같다.


### 설치
아래와 같이 `pip` 명령으로 설치 할 수 있다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "backupbot-install.sh" >}} 


### 권한 설정 (backupbot 에서)

*/etc/sudoers* 파일을 열어 권한을 설정 한다. 
    
{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "visudo.sh" >}} 

아래 내용을 추가한다. 

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "visudoer" >}} 

## 백업 테스트

백업테스트를 위해 *backupman* 계정으로 로그인 한다. 
    

다음 명령을 통해 백업 스크립트가 정상적으로 동작 하는지 확인한다. 

### apple

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "backupbot-apple.sh" >}}     

### banana

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "backupbot-banana.sh" >}} 

### coconut

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "backupbot-coconut.sh" >}} 

### Cron에 Job 등록

위 명령이 정상적으로 수행되어 백업이 완료 되었으면 cron에 등록 하여 주기적으로 백업이 이루어 지도록 한다. 
    
{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "crontab-e" >}} 


아래 예제는 *apple*, *banana*, *coconut* 서버에 대하여 각각 매일 오전 3시, 4시 5시에 백업을 수행 하도록 job을 등록한것이다.  

{{< gist euikook e438586239752c3a94a2047f55a2b9a1 "crontab" >}} 

Backupman 스크립트는 아래 Repository에서 확인 할 수 있다. 

[python-backupman](https://github.com/euikook/python-backupman)
