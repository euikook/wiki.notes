---
title: Generate SSH keypair for Windows using puttygen
description: 
status: publish
tags: [Windows, putty, puttygen, ssh, keypair]
created: 2021-02-16
date: 2021-02-16 16:26:41 +0900
banner: https://source.unsplash.com/8admGA18lBs
aliases:
    - /gollum/generate-ssh-key-pare-for-windows
    - /gollum/generate-ssh-key-pare-for-windows.md
---

이 글은 `PuTTY` 사이트에서 `PuTTY`와 같이 배포되는 `puttygen`프로그램을 이용하여 SSH Key Pair를 생성하는 방법을 설명한다. 


아래 링크에서 puttygen.exe 파일을 다운 받는다.
https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html


이미 설치 되어 있다면 `puttygen.exe` 파일을 실행한다.

![puttygen - open](/images/puttygen/puttygen-001.png)


아래는 `puttygen.exe`의  실행 화면이다.

![puttygen - start](/images/puttygen/puttygen-002.png)


* `Parameters` 들 중 `Type of key to generate` 는 기본값인 RSA로 두자.
* `Number of buts in a generated key`는 적당한 값을 변경한다. 
* `Generate` 버튼을 눌러 Key를 생성한다.
> 이때 마우스 커서가 진행바 와 `Actions` 사이의 빈 공간사이를 이리저리 이동해야 키가 생성이 진행된다. 

![puttygen - generate](/images/puttygen/puttygen-003.png)

Key Paire 가 만들어 졌다. 

![puttygen - generated](/images/puttygen/puttygen-004.png)


`Save public key` 버튼을 클릭하여 Public Key를 저장한다.

> `Key Comment` 필드에 e-mail주소나 Comment를 적어 나중에 해당 키를 구분할 수 있게 하자.

![puttygen - save public key](/images/puttygen/puttygen-005.png)

적당한 파일 이름을 지정하여 저장한다. 
> `euikook.pub`으로 저장하였다.

![puttygen - euikook.pub](/images/puttygen/puttygen-006.png)

`Save private key` 버튼을 클릭하여 Private Key를 저장한다.

![puttygen - save private key](/images/puttygen/puttygen-007.png)

`passphrase`가 비어 있다고 경고 메시지가 나온다.  `예(Y)` 버튼을 클릭하여 무시한다. 

![puttygen - ignore passphrase](/images/puttygen/puttygen-008.png)

적당한 파일 이름을 지정하여 저장한다. 
> `euikook.ppk` 파일로 저장하였다. 

> 이때 저장되는 파일은 `OpenSSH`에서 사용되는 개인키가 아닌 `Putty` 전용 개인키 이다. 

![puttygen - export as OpenSSH key](/images/puttygen/puttygen-011.png)

`Conversions` > `Export OpenSSH key`를 클릭하여 OpenSSH용 개인키를 내보낸다.

![puttygen - export as OpenSSH key](/images/puttygen/puttygen-009.png)

`passphrase`가 비어 있다고 경고 메시지가 나온다.  `예(Y)` 버튼을 클릭하여 무시한다. 

![puttygen - ignore passphrase](/images/puttygen/puttygen-008.png)

적당한 파일 이름을 지정하여 저장한다. 
> `euikook` 파일로 저장하였다. 

![puttygen - euikook](/images/puttygen/puttygen-010.png) 