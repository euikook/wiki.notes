---
title: Python3 ad default python interpreter on ubuntu
link: /python3-as-default-python-interpreter-on-ubuntu
description: 
status: publish
tags: [Linux, git, user.name, user.email, override, overriding]
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/eic5Tq8YMk
---

# Python 기본 인터프리터 설정 하기

```
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

sudo update-alternatives --config pip
sudo update-alternatives --config python
```

아래와 같이 직접 `--set` 옵션을 사용하여 설정 한다. 

```
sudo update-alternatives --set python /usr/bin/python3
sudo update-alternatives --set pip /usr/bin/pip3
```
