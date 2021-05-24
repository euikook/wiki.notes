---
title: fcitx 한글 입력기 사용하기 
tags: [Hangul, 한글, IM, 입력기, Input Method, Linux, 리눅스, fcitx, fcitx5, Arch Linux, Ubuntu, 18.04, 20.04]
date: 2021-05-23 22:34:39 +0900
draft: false
banner: https://source.unsplash.com/PT_9ux0j-x4
aliases:
    - /posts/hangul-input-using-fcitx5/
---

Gnome 기본 IM(Input Method)인  IBus 입력기에 문제가 있어 fcitx로 입력기를 변경 했다.

## Arch Linux

```
pacman -S fcitx5 fcitx5-hangul fcitx5-gtk fcitx5-qt fcitx5-configtool 
```


`/etc/environment`
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

시스템을 재시작 하면 fcitx가 자동 실행된다. 


<!--more-->


한글 입력 모드에서 태극 회오리 아이콘이 작업 표시줄에 표시된다.  변경 하려면 다음과 같이 실행한다.

```
sudo rm -f /usr/share/icons/hicolor/64x64/apps/fcitx-hangul.png
sudo wget https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/Papirus/24x24/actions/fcitx-hangul.svg -O /usr/share/icons/hicolor/64x64/apps/fcitx-hangul.png
```

## Ubuntu

```
sudo apt update
sudo apt install fcitx-hangul
```


설정 매뉴를 실행한 후 우측 설정 메뉴에서 `Region & Language` 을 선택한다.

설정 메뉴에서 `Manage Installed Language` 버튼을 클릭 한다. 

`Language Support` 화면이 나타나면 하단의 `Keyboard input method system` 항목을 `fcitx`로 설정한다.

적용을 위해 시스템을 재시작한다.

상단 패널의 우측에 키보드 모양의 아이콘이 보이면 정상적으로 설치 된 것이다.

상단 패널의 기보트 아이콘을 클릭하여 설정 메뉴를 오픈한다. 

`Configure Current Input Method` 메뉴를 실행한다. 

![Input Method 설정](/images/hangul/fcitx-ubuntu-hangul-001.png)


* `Keyboard - English(US)` 

![Input Method 설정](/images/hangul/fcitx-ubuntu-hangul-002.png)

좌측 하단의 `+` 버튼을 클릭한다.

`Search Input Method` 항목에 `Hangul`을 입력 하여 검색한다. 

![Input Method 설정](/images/hangul/fcitx-ubuntu-hangul-003.png)

검색 내용이 보이지 않으면 `Only Show Current Language`의 선택을 해제한다. 

![Input Method 설정](/images/hangul/fcitx-ubuntu-hangul-004.png)

`Hangul` 을 선택 한 후 `OK` 버튼을 눌러 추가 한다.




`Input Method` 리스트에 다음과 같이  `Hangul`이 추가 되었다.

* `Keyboard - English(US)`
* `Hangul`

![Input Method 설정](/images/hangul/fcitx-ubuntu-hangul-005.png)


## 한/영 전환 키 설정

`Global Config` 탭을 선택 한다. 

![한/영 전환 설정](/images/hangul/fcitx-ubuntu-hangul-006.png)


`HotKey` 항목의 첫 번째 항목인 `Trigger Input Method` 항목의 첫번째 항목이 `Ctrl+Space`로 설정 되어 있다. 두번째 항목을 클릭 하여 `한/영` 전환키를 입력 한다. 

![한/영 전환 설정](/images/hangul/fcitx-ubuntu-hangul-007.png)

한/영 전환 키가 `Ralt`로 인식된다면 [리눅스에서 한/영 전환키 사용하기](/posts/right-alt-as-hangul)를 참고 하여 한/영 전환키를 설정한다. 


