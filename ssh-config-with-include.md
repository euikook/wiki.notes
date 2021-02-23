---
title: SSH config with Include
link: /ssh-config-with-include
description: 
status: publish
tags: [Linux, OpenSSH, config, ssh, client, ssh client] 
banner: https://source.unsplash.com/F_m44ut3XTw
date: 2020-11-25 11:34:02 +0900
lastmod: 2021-02-23 10:16:13 +0900
aliases:
    - /gollum/ssh-config-with-include
    - /gollum/ssh-config-with-include.md
---

## About `~/.ssh/config`

SSH를 사용하다보면 서버별 접속 옵션이나 암호화 방식을 달리 해야 될 경우가 있다. 이때 이러한 설정 정보들을 `~/ssh/config` 파일에 저장해 두면 접속시에 명령행에 옵션으로 주지 않더라도 자동 적용된다. 

`~/.ssh/config`파일의 활용법은 다음과 같다. 


### 서버 별칭(Aliases) 부여

또한 Domain Name이 할당되어 있지 않고 IP 주소로 접속하는 경우 서버에 자신만의 이름을 부여한 후 그 이름으로 접속할 수 있기 때문에 매우 유용하다. 

접속하고자 하는 IP 1.2.3.4에 Domain Name이 할당되어 있지 않거나 해당 IP 정보가 `/etc/hosts`에 지정되어 있지 않더라도 호스트 지정자로 `1.2.3.4`와  `test`로 지정돼어 있기 때문에 `1.2.3.4` 뿐 아니라 `test`로 접속 해도 `1.2.3.4` 로 접속된다. 

```
ssh 1.2.3.4
```
또는 
```
ssh test
```

### 접속 SSH Port 변경 

또한 보안등의 이유나 SSH Port가 변경된 경우 매 서버마다 변경된 SSH 포트를 외우기 보다 `config` 파일에 `Port` 파라미터를 지정한다.

```
Host example.com
    Hostmname example.com
    Port 5545
    PreferredAuthentications password 
    PubkeyAuthentication no
```


### 인증을 위한 Identity 파일 지정

키 관리를 위해 Key Agent를 사용하지 않는 경우 인증을 위해 Identity 파일을 명시적으로 `-i` 옵션으로 지정할 수 있다.

`~/ssh/config` 파일에 `IdentityFile` 옵션을 사용하여 명시적으로 Private Key를 지정할 수 있다. 

아래는 `example.com`인증을 위해 개인키로 `~/.ssh/test`를 지정한 예제이다. 

```
Host example.com
    Hostmname example.com
    IdentityFile ~/.ssh/test

```

<!--more-->

### 강제로 Password 인증하기

강제로 Password 인증을 하기 위해서는 `PreferredAuthentications=password` 옵션과 `PubkeyAuthentication=no`을 사용해야 한다. 

명령행으로 실행 하려면 아래와 같이 실행한다. 

```
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no example.com
```

하지만 매번 이 옵션을 명령행에 넣지 않고 아래와 같이 `~/.ssh/config` 파일을 설정하면 example.com 에 접속할 때마다 위 옵션들이 자동으로 설정된다. 

`~/.ssh/config`

```
Host example.com
    Hostmname example.com
    PreferredAuthentications password 
    PubkeyAuthentication no
```

SSH 접속 정보를 `~/.ssh/config` 파일에 저장한다. 


### Keepalive 설정

SSHD 데몬은 기본적으로 접속된 클라이언트로 부터 데이터를 보내지 않는 경우 해당 연결을 닫는다. 연결이 끊어지는것을 방지하기 위해서는 주기적으로 메시지를 보내어 자기가 Active 세션임을 증명하여야 한다.
유휴세션 상태에서 세션을 유지하기 위해서는 `ServerAliveInterval` 옵션을 사용한다. 

아래는 240초 마다 Alive 신호를 SSH 서버로 보내는 예제다.

```
Host example.com
    Hostmname example.com
    ServerAliveInterval 240
```

아래는 ~/ssh/config 파일의 예제 이다.
```
Host 1.2.3.4 test
    Hostname 1.2.3.4
    Port 22
    User username
    SendEnv LANG LC_*
    IdentityFile ~/.ssh/test
    ConnectTimeout 0
    HashKnownHosts yes
    GSSAPIAuthentication yes
    GSSAPIDelegateCredentials no
    ServerAliveInterval 30
    ServerAliveCountMax 3
```



## `Include` statement

OpenSSH 7.3에서 `Include` 기능이 추가 되었다.

`~/.ssh/config`파일은 매우 유용하지만 `config`파일에서 관리되는 호스트의 수가 많아지면 파일이 너무 길어져 관리가 어렵게 된다. 나의 경우 2000라인 정도 되는 `config`파일을 관리하고 있다. 

프로젝트 또는 서버의 용도에 따라 파일을 분리해서 설정을 관리 하면 좋겠지만 7.3 버전 이전의 OpenSSH에서는 해당 기능을 지원하지 않아 어쩔수 없이 하나의 파일에 관리하였지만 7.3 버전 부터는 `Include` 키워드를 지원하기 때문에 `config` 파일을 용도에 따라 나누어 관리할 수 있다. 


먼저 설치된 OpenSSH 패키지의 버젼을 확인한다.

```
ssh -V
```

내가 사용하는 시스템의 경우 `8.4p1`이다. 
```
$ lsb_release -a
LSB Version:	1.4
Distributor ID:	Arch
Description:	Arch Linux
Release:	rolling
Codename:	n/a
$ ssh -V
OpenSSH_8.4p1, OpenSSL 1.1.1h  22 Sep 2020
```

`Ubuntu 18.04` 의 경우 `7.6p1` 이로 확인되었다.

```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.5 LTS
Release:	18.04
Codename:	bionic
$ ssh -V
OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
```

SSH Client가 `7.4` 이전 버전이거나 OpenSSH 가 아니라면 7.4 이상의 OpenSSH 패키지를 설치 한다.


### 설정파일 분리

`~/.ssh/config` 파일을 분할한다.

나의 경우 아래와 같이  `conf.d` 라는 디렉터리를 만들고 해당 디렉터리에 프로젝트별로 서버들을 분리 하였다.


```
.
├── authorized_keys
├── conf.d
│   ├── common.conf
│   ├── p1.conf.disabled
│   ├── p2.conf
│   ├── p3.conf
│   ├── p4.conf.disabled
│   ├── p5.conf
├── config
```

> 프로젝트가 끝났거나 잠시 중단되어 설정 파일이 로드될 필요가 없을 경우 파일 이름뒤에 `.disabled` 확장자를 붙여 설정이 로드 되지 않게 한다.

### 분리된 설정파일 불러오기


~/.ssh/config
```
Include conf.d/*.conf
```

