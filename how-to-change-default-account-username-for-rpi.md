---
title: 라즈베리파이(RPi, Raspberry Pi) 기본계정 pi 변경하기
titlen: How to change default account username for RPi
link: /how-to-change-default-account-username-for-rpi
description: 
status: publish
tags: [Linux, RPi, Raspberry Pi, HowTo, Username, Password, Raspian, 계정, 라즈베리파이]
date: 2018-03-14
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/random/800x400
---

## How to change default account username for RPi(Raspberry Pi)

Raspberry Pi 공식 이미지의 username 과 password는 다음과 같다. 

> username: _pi_  
> password : _raspberry_

쓸때마다 느끼는 거지만 pi 와 raspberry는 정말 손에 익지 않는다. 키보드로 칠때마다 오타가 나서 한번에 로그인 할때가 거의 없다. pi 계정을 계속 쓰면 보안 문제도 생길 수 있으니 자신만의 손에 익은 username과 password로 변경 해 보자. 

> 다른 리눅스 시스템에도 적용할 수 있다. 

먼저 root 계정으로 로그인 해야 한다. 먼저 root 로 로그인 하기 위하여 root 계정의 Password를 설정한다. 
    
```bash
sudo passwd root
```

<!--more-->     

pi 계정 에서 로그아웃 후 root 계정으로 로그인 한다. 
    
```bash    
logout
```
    

pi 계정을 oneuon로 변경한다. 
    
```bash    
usermod -l oneuon pi
```

이제 /home/pi 디렉터리를 /home/oneuon로 변경하자. 
    
```bash    
usermod -m -d /home/oneuon oneuon
```
    

필요하다면 변경한 oneuon계정의 Password를 변경한다. 
    
```bash    
passwd oneuon
```
    

필요 하다면 pi group도 변경 한다. 
    
```bash    
groupmod -n oneuon pi
```
    

root 계정에서 로그 아웃 후 oneuon으로 로그인 한다. 

root 계정을 비활성화 하기전 sudo 명령이 잘 동작 하는지 확인한다. 
    
```bash    
sudo ls
```
    

password를 Lock 하여 root 계정을 비활성화 한다. 
    
```bash    
sudo passwd -l root
```
