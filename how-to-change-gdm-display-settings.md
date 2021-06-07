---
title: GDM 모니터 설정 변경하기
date: 2021-06-06 23:02:02 +0900
tags: [Arch Linux, GDM, GNOME, Displays, Settings, Tips  and Tricks]
banner: /images/banners/gdm-display-settings-banner.jpg
---
사용자 모니터 설정은 `~/.config/monitors.xml`에 저장된다.   GNOME에서 사용하는 모니터 설정을 GDM에도 적용하자.

```
sudo cp ~/.config/monitors.xml ~gdm/.config/monitors.xml
sudo chmod gdm:gdm  ~gdm/.config/monitors.xml
```

`monitors.xml`를 복사해도 설정이 적용 안되는 경우 아래와 같이 GDM과 GNOME에서 사용하는 디스플레이 서버가 같은지 확인해 보자. 다음과 같은 경우일 수 있다.

* GDM은 Wayland를 사용하고 GNOME은 Xorg를 사용하는 경우
* GDM은 Xorg를 사용하고 GNOME은 Wayland를 사용하는 경우

<!--more-->

Xorg와 Wayland에서 사용하는 `monitors.xml` 파일의 포멧이 틀려서 발생하는 문제다.

GNOME에서 사용하는 X 서버로 GDM을 변경 하도록 한다.

Xorg에서 GDM을 시작 하고자 할때,

`cat /etc/gdm/custom.conf`

```
[daemon]
WaylandEnable=false
```

Wayland에서 GDM을 시작 하고자 할때,
`cat /etc/gdm/custom.conf`

```
[daemon]
# WaylandEnable=false
```
