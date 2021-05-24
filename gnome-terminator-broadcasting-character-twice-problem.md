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


IBus 입력기와 D-Bus 충돌 문제인것 같다. 설정에서 DBus 서버 기능을 껐는 데도 브로드캐스트 기능에 D-Bus를 사용하나 보다.

IBUS를 사용하는 시스템에서만 문제가 발생한다. 


## 해결책

### Fcitx 사용

IBus 입력기와 D-Bus를 같이 사용할 경우 발생하는 문제이므로 입력기를 다른 입력기로 변경하자. 나의 경우 Fcitx로 변경 하였다.


```
pacman -S fcitx5 fcitx5-hangul fcitx5-gtk fcitx5-qt fcitx5-configtool 
```


`/etc/environment`
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

시스템을 다시 시작하면 fcitx가 자동 실행된다. 

자세한 설치 방법은 [fcitx5 한글 입력기 사용하기](/posts/hangul-input-using-fcitx5/) 다음 페이지를 참고한다.


### 해결책 #1

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


문제는 `DBUS_SESSION_BUS_ADDRESS` 변수를 override 했기 때분에 문제가 D-Bus를 사용하는 어플리케이션을 실해 하면 오류메시기가 표시 되거나 실행이 안되는 경우가 있다.


## 참고자료
* [Terminator terminal suddenly inserting each character twice when broadcasting to multiple windows](https://www.claudiokuenzler.com/blog/862/terminator-terminal-inserting-each-character-twice-double-broadcast-multiple-windows)