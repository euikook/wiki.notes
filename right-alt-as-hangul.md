---
title: 리눅스에서 한/영 전환키 사용하기
link: /right-alt-as-hangul
description: 
status: publish
categories: ["HowTo", 'Linux']
tags: [Linux, ALt_R, RALT, Hangul, 한／영, Ubuntu, 20.04, 18.04, 리눅스, Focal, Arch Linux]
banner: https://source.unsplash.com/PT_9ux0j-x4
date: 2020-10-21 08:35:41 +0900
lastmod: 2021-05-23 23:37:41 +0900
banner: https://source.unsplash.com/G_EL_XLKBcc
---


## 문제점
* 영문 키보드 구입
* 오른쪽 Alt</kbd> 키 (<kbd>Alt_R</kbd>)을 한글 키로 사용 하고 싶음.
* IBus 등에서 한/영 변환을 <kbd>Alt_R</kbd> 키로 등록
	* 다른 프로그램에서는 잘 동작.
	* <kbd>Alt_R</kbd> 키를 단축키로 사용하는 프로그램(Chrome)등에서는 동작이 안됨
* <kbd>Ctrl_R</kbd>은 Hanja 키로 매핑 시키고 싶지 않음.

<!--more-->


## Gnome Tweak Tool 사용

`Gnome Tweaks Tool`을 실행한다. 

![Gnome Tweaks Tool](/images/hangul/gnome-tweaks-tools-hangul-001.png)

우측 메뉴에서 `Keyboard & Mouse`를 선택한 후 우측 설정 화면에서 `Additional Layout Options` 버튼을 클릭한다. 
![Gnome Tweaks Tool](/images/hangul/gnome-tweaks-tools-hangul-002.png)

`Additional Layout Options` 설정 화면에서 `Korean Hangul/Hanja Keys` 메뉴를 클릭하여 확장한 후  `Make right Alt a Hangul Key`를 선택한다. 
![Gnome Tweaks Tool](/images/hangul/gnome-tweaks-tools-hangul-003.png)

### Gnome Tweak Tool 시용 시 문제점
~~잘 동작한다. 하지만 Ctrl_R 키 까지 한자키로 매핑되어  VirtualBox 사용시 Host Key를 변경 해주어 야 한다.~~
한/영 전환키와 한자 전환키의 설정이 분리 되었다. 

이 방법을 사용하자. 


## Xmodmap 사용

### Hangul key
```
xmodmap -e 'remove mod1 = Alt_R' # Alt_R의 기본 키 매핑 제거
xmodmap -e 'keycode 108 = Hangul' # Alt_R을 Hangul 키로 매핑
```

### Hanja Key
```
xmodmap -e 'remove control = Control_R'
xmodmap -e 'keycode 105 = Hangul_Hanja'
```
### Save permanently
```
xmodmap -pke > ~/.Xmodmap
```

### Xmodmap 사용 시 문제점
ubuntu 18.04이후 부터 XKB가 기본 키보드 매핑 패키지로 바뀌면서 위의 xmodmap 설정이 자동으로 적용되지 않는다. 

자동적용을 위해서는 아래의 [XKB 사용](#xkb-사용) 항목을 참고한다. 


## XKB 사용
Edit `/usr/share/X11/xkb/symbols/altwin`

```
// Meta is mapped to second level of Alt.
partial modifier_keys
xkb_symbols "meta_alt" {
    key <LALT> { [ Alt_L, Meta_L ] };
    key <RALT> { type[Group1] = "TWO_LEVEL",
                 symbols[Group1] = [ Alt_R, Meta_R ] };
    modifier_map Mod1 { Alt_L, Alt_R, Meta_L, Meta_R };
//  modifier_map Mod4 {};
};
```

```
// Meta is mapped to second level of Alt.
partial modifier_keys
xkb_symbols "meta_alt" {
    key <LALT> { [ Alt_L, Meta_L ] };
    key <RALT> { type[Group1] = "TWO_LEVEL",
                 symbols[Group1] = [ Hangul ] };
    modifier_map Mod1 { Alt_L, Alt_R, Meta_L, Meta_R };
//  modifier_map Mod4 {};
};
```

## References
* [Ubuntu XKB를 이용한 keyboard map 확장](https://zapary.blogspot.com/2014/08/ubuntu-xkb-keyboard-map.html)
