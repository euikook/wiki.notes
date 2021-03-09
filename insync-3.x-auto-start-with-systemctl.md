---
title: Insync 3.x auto start with systemctl
link: /insync-3.x-auto-start-with-systemctl
description: 
status: publish
tags: [Linux, Insync, autostart, systemctl]
date: 2021-03-08 21:56:31 +0900
lastmod: 2021-03-08 21:56:31 +0900
banner: https://uploads-ssl.webflow.com/5c5bbc2b7ebe99d46f9e983b/5cf14ca1fb8dd08aa53a2e58_InsyncSignIn.png
aliases:
    - /gollum/insync-3.x-auto-start-with-systemctl
    - /gollum/insync-3.x-auto-start-with-systemctl.md
---

이 글에서는 Google Drive 와 One Drive의 third-party 동기화 유틸인 [Insync](https://www.insynchq.com/)의 headless 버전을 설치 하고 자동 실행 하는 방법에 대하여 알아본다.

> Insync: Google Drive Syncing Application for Linux

> Insync: 리눅스를 위한 Google Drive 동기화 어플리케이션

Insync가 3.x 버전으로 판올림 되면서 headless 버전이 사라지는 바람에 [xvfb를 통해 우회 실행 하는 방법](/posts/insync-3.x-auto-start-with-xvfb-and-systemctl)에 대하여 설멍한 적이 있다. 

하지만 Insync 3.x 대한 headless 버전이 릴리즈 되었기 때문에 이런 번거로운 작업이 필요 없어 졌다. 

잘 돌아가는 Insync를 headless 버전으로 바꾸기 귀찮아서 미루고 있었는데 이번에 Ubuntu Box를 `Bionic`에서 `Focal`로 판올림 하는 김에 시간을 내서 headless 버전으로 변경 하였다.


## Prerequisites
* insync-headless

### Insync headless 설치 
Insync의 설치 방법은 [Insync - Linux에서 Google Drive Desktop Client 사용하기](/posts/alternative-google-drive-desktop-client-for-linux)를 참고 한다. 


<!--more-->

## Stop and Remove Insync with xvfb version
이전에 [xvfb 버전]((/posts/insync-3.x-auto-start-with-xvfb-and-systemctl)문서를 참고 하여 설정 하였다면 xvfb와 insync 서비스를 삭제 하자.

```
systemctl --user stop insync.service
systemctl --user stop xvfb.service
```

```
rm -f /home/$USER/.config/systemd/user/xvfb.service
rm -f /home/$USER/.config/systemd/user/insync.service
```

## UI 버전에서 Headless 버젼으로 변경 시 유의 사항
각 설정 과 데이터베이스 파일의 구조는 크게 변하지 않은 것 같으나 위치가 변경 되었다.

* UI Version의 경우 `~/.config/Insync`
* Headless 버젼의 경우 `~/.config/Insync-headless`

따라서 UI 버젼에서 Headless 버젼으로 변경하고 Insync를 실행하면 UI 버전에서 사용하던 계정 등의 설정 정보를 같이 로드 되지 않는다.


`~/.config/Insync` 디렉터리를 `~/.config/Insync-headless`로 복사한다. 

```
cp -ap ~/.config/Insync ~/.config/Insync-headless
```

> UI 버전과 Headless 버젼의 설정 파일 구조가 언제 바뀔지 모르기 때문에 *Symbolic Link* 보다는 *Hard Link*링크로 복사하여 Headless 버젼을 실행 해 보고 문제가 발생하면 해당 디렉터리를 삭제 후 다시 설정하자.

> Headless 버전에서 UI 버젼으로 바꾸는 경우에는 반대로 수행하면 된다. 


## Systemctl script

### Insync headless

Create a file `/home/$USER/.config/systemd/user/insync-headless.service`
```
[Unit]
Description=insync on start up
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/insync-headless start

[Install]
WantedBy=default.target
```

### Enable unit file

```
systemctl --user enable insync-headless.service
```


### Enable Lingering
```
loginctl enable-linger ${USER}
loginctl show-user ${USER} | grep Linger
```

### Post reboot
```
systemctl --user status insync-headless.service
ps ef |grep insync-headless
```