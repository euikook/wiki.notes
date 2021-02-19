---
title: Generate SSH keypair for Linux
description: 
status: publish
tags: [Linux, OpenSSH, ssh, keypair]
created: 2021-02-16
date: 2021-02-16 17:34:41 +0900
banner: https://source.unsplash.com/8admGA18lBs
aliases:
    - /gollum/generate-ssh-key-pare-for-linux
    - /gollum/generate-ssh-key-pare-for-linux.md
---

이 글은 `Linux`환경에서 SSH Key Pair를 생성하는 방법을 설명한다. 


* `OpenSSH`가 설치 되어 있다고 가정한다. 


```
ssh-keygen -t rsa -b 4096 -f euikook -C "euikook@gmail.com"
```

* `-t rsa`: 생성된 Key의 Type를 RSA로 설정한다.
* `-b 4096`: 생성될 Key의 길이를 4096 bit로 설정한다.
* `-f euikook`: 생상될 Key의 이름은 euikook로 설정한다.(`euikook.pub`, `euikook`)
    * `euikook.pub`: Public Key
    * `euikook`: Private Key
* `-C euikook@gmail.com`: Comment로 `euikook@gmail.com`로 설정한다.