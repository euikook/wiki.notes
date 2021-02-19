---
title: Linux Shell 에서 대소문자 치환
link: /linux-shell-에서-대소문자-치환
description: 
status: publish
tags: [Linux, Bash, Shell, Shell Command, tr]
date: 2018-01-19
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/Oxl_KBNqxGA
aliases:
    - /gollum/linux-shell-에서-대소문자-치환
    - /gollum/linux-shell-에서-대소문자-치환.md
---

#### Linux Shell 에서 대소문자 치환

Linux tr 명령 사용 
    
```bash    
tr [:lower:] [:upper:]
```
Examples: 
    
```bash    
echo test | tr [:lower:] [:upper:]
```
