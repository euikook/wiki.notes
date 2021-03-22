---
title: Virtualbox에서 사용 호스트에 연결된 USB 장치가 나타나지 않을 경우
draft: false
tags: [Virtualbox, USB, usermod, Mini HowTo]
banner: https://source.unsplash.com/JZ8AHFr2aEg
date: 2021-02-08 20:09:07 +0900
banner: /images/empty-frame.jpg
---

USB 장치를를 게스트에서 직업 접근 하려고 하는데 USB 설정 화면에서 사용 가능한 디바이스 목록에 장치가 하나도 없다. 

아래 명령으로 `vboxusers` 그룹에 사용자를 추가 한다. 

```
sudo usermod -aG vboxusers $USER
```

로그아웃 후 다시 로그인 하거나 시스템을 재시작 한다. 

추가 가능한 USB 장치의 장치 목록이 뜬다. 


자세한 내용은 [The vboxusers Group ](https://www.virtualbox.org/manual/ch02.html#install-linux-vboxusers) 을 참고 하자.



## TMI

> 리눅스를 포함한 유닉스 계열 시템에서 권한을 할당을 위해 자주 사용되는 방법이다. Group에 권한을 부여한다음 해당 그룹에 속한 사용자에게 권한을 부여한다.
> 다른 예로는 `root`권한 없이 시리얼 포트에 접근하기 위해서는 RedHat 계열 및 Ubuntu를 포함한 Debian 계열 배포본에서는 `dialout` 그룹에 속해야 하며 Arch 리눅스 계열 배포본에서는 `uucp` 그룹에 속해있어야 한다. 

> `dialout` 과 `uucp`는 모두 통신을 위해 사용되던 시리얼 모뎀과 관련이 있다.