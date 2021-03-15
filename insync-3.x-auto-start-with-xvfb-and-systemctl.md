---
title: Insync 3.x auto start with xvfb and systemctl
link: /Insync-3.x-auto-start-with-xvfb-and-systemctl
description: 
status: publish
tags: [Linux, Insync, autostart, xvfb, systemctl]
date: 2020-10-21
lastmod: 2020-11-16 09:37:41 +0900
banner: https://uploads-ssl.webflow.com/5c5bbc2b7ebe99d46f9e983b/5cf14ca1fb8dd08aa53a2e58_InsyncSignIn.png
aliases:
    - /20/10/21/insync-3.x-auto-start-with-xvfb-and-systemctl
    - /insync-3.x-auto-start-with-xvfb-and-systemctl
    - /insync-3.x-auto-start-with-xvfb-and-systemctl.md
    - /gollum/insync-3.x-auto-start-with-xvfb-and-systemctl
    - /gollum/insync-3.x-auto-start-with-xvfb-and-systemctl.md
---

이 글에서는 Google Drive 와 One Drive의 third-party 동기화 유틸인 [Insync](https://www.insynchq.com/)의 headless 버전을 설치 하고 자동 실행 하는 방법에 대하여 알아본다.

> Insync: Google Drive Syncing Application for Linux

> Insync: 리눅스를 위한 Google Drive 동기화 어플리케이션

Insync가 3.x 버전으로 판올림 되면서 headless 버전이 없어 졌기 때문에 Gnome등의 UI로 로그인 하여야 Insyc를 설행 할 수 있다. 

하지만 서버의 경우 자동 로그인을 실행하면 보안 상의 문제가 있으므로 자동 로그인 설정을 할 수 없다. 

이문제를 해결 하기 위하여 xvfb와 systemctl 을 이용하여 Insync UI 버전을 자동 실행하는 방법에 다여 알아본다. 


> 3.x 버전의 Headless 버전이 릴리즈 되었다. 이를 이용한 자동 실행 방법은 다음 [Insync 3.x auto start with systemctl](/posts/insync-3.x-auto-start-with-systemctl)를 참고한다. 

## Prerequisites
* insync
* xvfb

### Insync 설치 
Insync의 설치 방법은 [Insync - Linux에서 Google Drive Desktop Client 사용하기](/posts/alternative-google-drive-desktop-client-for-linux)를 참고 한다. 

### xvfb 설치

```
sudo apt install xvfb
```

<!--more-->

## Systemctl script

### xvfb

Create a file `/home/euikook/.config/systemd/user/xvfb.service`
```
[Unit]
Description=X Virtual Frame Buffer Service
After=network.target

[Service]
ExecStart=/usr/bin/Xvfb :99 -screen 0 1024x768x24

[Install]
WantedBy=default.target
```

### Insync

Create a file `/home/euikook/.config/systemd/user/insync.service`
```
[Unit]
Description=insync on start up
After=xvfb.service

[Service]
Type=forking
Environment="DISPLAY=:99"
ExecStart=/usr/bin/insync start

[Install]
WantedBy=default.target
```

### Enable unit file

```
systemctl --user enable xvfb.service
systemctl --user enable insync.service
```


### Enable Lingering
```
loginctl enable-linger ${USER}
loginctl show-user ${USER} | grep Linger
```

### Post reboot
```
systemctl --user status xvfb.service
systemctl --user status insync.service
ps ef |grep insync
```