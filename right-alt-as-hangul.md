---
title: Ubuntu Key Mapping Right Alt as Hangul Key
date: "2020-09-11 14:05:55 +0900"
author: euikook
description:
permalink: posts/right-alt-as-hangul
status: publish
layout: post
tags: [Linux, Gitlab, CI, CD, CI/CD, Docker, Container, Compose, docker-compose]
---
# Right ALT key as Hangul

## gnome-teaks tools

```
sudo apt install gnome-tweak
```

`gnome-tweak`을 실행한다.


Keyboard & Mouse > Additional Layout Options > Korean Hangul/Hanja keys

Check `Right Alt` as `Hangul`, `Right Ctrl` as `Hanja`

### Cons
* 거의 사용하지 않는 `Right Ctrl` 키를 한자 변환 키로 사용하여야 한다.

## xmodmap

한글 키 매핑
```
xmodmap -e 'remove mod1 = Alt_R'
xmodmap -e 'keycode 108 = Hangul'
```

한자변환 키의 경우
```
xmodmap -e 'remove control = Control_R'
xmodmap -e 'keycode 105 = Hangul_Hanja'
```

현재 설정 저장

```
xmodmap -pke > ~/.Xmodmap
```


## Cons
* Ubuntu 13.04 부터 `xmodmap` 대신 `xkb`를 사용한다. 따라서 `~/.Xmodmap`에 키를 리매핑하여도 로그인 시 적용되지 않는다. `xkb`의 설정 방법은 다음 색션을 참고 한다. 

수동으로 로드 하기 위해서는 아래 명령을 수행한다.

```
xmodmap ~/.Xmodmap
```

## XKB (X Keyboard Extension)

`/usr/share/X11/xkb/symbols/altwin` 파일을 열어 `symbols[Group1] = [ Alt_R, Meta_R ]` 부분을 `symbols[Group1] = [ Hangul ]`로 수정한다.


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

### Pros

### Cons
