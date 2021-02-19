---
title: How to use Hugo for starter
link: /how-to-use-hugo-for-starter
description: 
status: publish
tags: [Hugo, Static Site Generator, Linux, Ubuntu, ArchLinux]
created: 2021-02-10
date: 2021-02-10 14:44:10 +0900
banner: /images/hugo-banner.png
aliases:
    - /gollum/how-to-use-hugo-for-starter
    - /gollum/how-to-use-hugo-for-starter.md
---

## Installing

### ArchLinux
pacman 명령으로 설치한다. 

```
sudo pacman -Syu hugo
```

### Ubuntu
Ubuntu 공식 패키지로 등록 되어 있으므로 apt 명령으로 설치 한다.
```
sudo apt install hugo
```

### Snap Package

with Sass/CSCC support
```
snap install hugo --channel=extedned
```

whtiout Sass/CSCC support
```
snap install hugo
```

### Create New Sites


```
hugo new site sandbox
```

### Add a Theme

`themes.gohugo.io`에서 테마를 선택한다. 

본 예제에서는 [`ananke`](https://github.com/budparr/gohugo-theme-ananke.git) 테마를 사용하도록 한다. 

```
cd sandbox
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke

echo 'theme = "ananke"' >> config.toml
```


테마의 사용법은 해당 테마의 [READMD.md](https://github.com/theNewDynamic/gohugo-theme-ananke/blob/master/README.md) 파일을 참고 한다.

### Add Posts

```
hugo new posts/about.md
```

### Start the hugo server

```
hugo server -D
```

`-D` include contet marked as draft

or 

```
hugo server
```

기본적으로 http://localhost:1313 으로 접속하면 볼수 있다. 


기본적으로 Posts 등의 파일이 변경되면 이를 인지 하여 브라우저가 자동으로 Refresh 된다. 


### Build Static Pages

```
hugo -D
```
`-D` include contet marked as draft

or 

```
hugo
```


public 디렉터리가 생상되고 배포를 위해서 public 디렉터리를 github page나 Web 서버에 올리면 된다.