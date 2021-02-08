---
title: SSH config with Include
link: /ssh-config-with-include
description: 
status: publish
tags: [Linux, OpenSSH, config, ssh, client, ssh client] 
date: 2020-12-21 15:41:13 +0900
---

# SSH Config with Include

OpenSSH 7.3에서 `Include` 기능이 추가 되었다.

## About `~/.ssh/config`
SSH 접속 정보를 `~/.ssh/config` 파일에 저장한다. 

접속하고자 하는 SSH 서버의 연결 옵션을 달리 해야 되는 경우나 IP를 외울 필요 없이 지정한 서버 이름으로 접속할 수 있기 때문에 매우 유용하다. 

또한 보안등의 이유나 NAT내부의 Port Forwarding된 외우기 힘든 SSH Port 주소로 접속 해야 한다면 아래 예제의 `Port` 파라미터를 정하기만 하면 된다.


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

접속하고자 하는 IP 1.2.3.4에 Domain Name이 할당되어 있지 않거나 해당 IP 정보가 `/etc/hosts`에 지정되어 있지 않더라도 호스트 지정자로 `test` 지정하여 접속할 수 있다.

```
ssh test 
```

## `Include` statement
이게 문제가 되는게 너무 관리해야될 SSH서버의 수가 많아지면 `~/.ssh/config` 파일이 너무 커져 버려서 관리가 힘들게 된다. 해당 설정 파일을 분할 하면 좋겠지만 OpenSSH 7.3 이전 버젼에서는 `Include` 기능을 지원하지 않았기 때분에 불가능 했다. 하지만 이제는 가능하다.

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


### Split config file

`~/.ssh/config` 파일을 분할한다.

나의 경우 아래와 같이  `conf.d` 라는 디렉터리를 만들고 해당 디렉터리에 프로젝트별로 서버들을 분리 하였다.

> 해당 프로젝트가 끝났거나 잠시 중단된 경우 파일 이름뒤에 `.disable` 확장자를 붙여 설정이 로드 되지 않게 한다.


```
.
├── authorized_keys
├── conf.d
│   ├── common.conf
│   ├── p1.conf.disable
│   ├── p2.conf
│   ├── p3.conf
│   ├── p4.conf.disable
│   ├── p5.conf
├── config
```


~/.ssh/config
```
Include conf.d/*.conf
```

