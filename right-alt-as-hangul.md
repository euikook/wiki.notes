---
title: Alt_R as Hangul on Ubuntu 18.04
link: /right-alt-as-hangul
description: 
status: publish
tags: [Linux, ALt_R, RALT, Hangul, 한/영]
---

# Alt_R as Hangul on Ubuntu 18.04

## Troubles
* 영문 키보드 구입
* 오른쪽 Alt</kbd> 키 (<kbd>Alt_R</kbd>)을 한글 키로 사용 하고 싶음.
* IBus 등에서 한/영 변환을 <kbd>Alt_R</kbd> 키로 등록
	* 다른 프로그램에서는 잘 동작.
	* <kbd>Alt_R</kbd> 키를 단축키로 사용하는 프로그램(Chrome)등에서는 동작이 안됨
* <kbd>Ctrl_R</kbd>은 Hanja 키로 매핑 시키고 싶이 않음.

## Use Xmodmap

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

### Troubles
ubuntu 18.04 로 가면서 X11 이 아나라 Wayland가 기본 X 서버로 변경 되면서 xmodmap은 더이상 도작 하지 않는다. 
xmodmap이 동작 하게 하려면 기본 X 서버를 xorg로 변경 하여야 한다.


## Use  Gnome Tweak Tool
Run `Gnome Tweaks Tool` > `Keyboard & Mouse` > `Additional Layout Options` > `Korean Hangul/Hanja Keys`
Check `Right Alt as Hangul, right Ctrl as Hanja`

### Troubles
잘 동작한다. 하지만 Ctrl_R 키 까지 한자키로 매핑되어  VirtualBox 사용시 Host Key를 변경 해주어 야 한다. 


##  Use XKB 
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
* [https://zapary.blogspot.com/2014/08/ubuntu-xkb-keyboard-map.html](https://zapary.blogspot.com/2014/08/ubuntu-xkb-keyboard-map.html)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk3NTMzMDksLTExNTk4OTYzOTddfQ==
-->