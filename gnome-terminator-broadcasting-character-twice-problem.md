---
title: Terminator 화면 분할 상태에서 브로드캐스트시 문자 두번 입력 문제
link: /disable-ralt-as-iso-level3-shift
description: 
draft: false
tags: [Linux, Gnome, Terminator, dbus, Broadcast, Twice]
date: 2021-02-07 23:19:29 +0900
banner: /images/gnome-terminator-broadcasting-character-twice-problem.png
---

Multiple GNOME terminal in one window


## Terminator Terminal Emulator


터미털 에뮬레이터의 화면 분할 기능을 제공하는 [Terminator Terminal Emulator](https://gnome-terminator.org/)를 사용한다. 

무엇 보다 손에 익었고 화면 분할 기능을 제공하는 터미널 에뮬레이터에는 없는 그룹 브로드캐스트 기능을 제공하기 때문에 터미널을 여러 개 열어 놓고 그룹별로 다른 입력을 해야 하는 테스트에 적합하다.

## 문제점

![브로드캐스트 시 문자 두번 입력](/images/gnome-terminator-broadcasting-character-twice-problem.png)

얼마전 아래 위의 그림 처럼 부터 화면 분할 상태에서 브로드캐스트 기능을 키면 수신받는 터미널에서 문자가 2번 입력되는 문제가 발생한다. 


iBus 와 D-Bus 충돌 문제인것 같다. 설정에서 DBus 서버 기능을 껐는 데도 브로드캐스트 기능에 D-Bus를 사용하나 보다. 

## 해결책

아래 참고 자료를 참고하여  `DBUS_SESSION_BUS_ADDRESS` 환경변수를 `''`로 설정하니 잘 동작 한다. 


```
DBUS_SESSION_BUS_ADDRESS='' /usr/bin/terminator"
```

터미널을 열때마다 적용될 수 있게  `/usr/bin/termiantor` 파일에 다음 라인을 추가 하자.

```python
os.environ['DBUS_SESSION_BUS_ADDRESS'] = ''
```

먼저 기존 파일을 백업한 후 위 라인을 추가 한다. 

```
sudo cp /usr/bin/termiantor /usr/bin/termiantor-org
```

```
sudo vi /usr/bin/termiantor
```

적당한 위치에 추가 한다. 나는 *31번째 라인* 에 추가 하였다. 

아래는 `diff` 파일이다. 

```diff
--- /usr/bin/terminator-org	2021-02-07 23:09:53.058253048 +0900
+++ /usr/bin/terminator	2021-02-07 23:10:33.610035415 +0900
@@ -28,6 +28,8 @@
 except OSError:
     ORIGCWD = os.path.expanduser("~")
 
+os.environ['DBUS_SESSION_BUS_ADDRESS'] = ''
+
 # Check we have simple basics like Gtk+ and a valid $DISPLAY
 try:
     import gi
```

Termiantor를 실행 하여 테스트 해본다. 

잘 동작 한다. 


![브로드캐스트 시 문자 입력 문제 해결](/images/gnome-terminator-broadcasting-character-twice-solved.png)


## 참고자료
* [Terminator terminal suddenly inserting each character twice when broadcasting to multiple windows](https://www.claudiokuenzler.com/blog/862/terminator-terminal-inserting-each-character-twice-double-broadcast-multiple-windows)