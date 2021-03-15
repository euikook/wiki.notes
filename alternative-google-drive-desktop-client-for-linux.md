---
title: Insync - Linux에서 Google Drive Desktop Client 사용하기
link: /alternative-google-drive-desktop-client-for-linux/
description: 
status: publish
categories: ["HowTo", 'Linux', 'Google']
tags: [Linux, Insync, Google, Google Drive, G Suite]
date: 2018-02-27
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/B_j4LJbam5U
aliases:
    - /18/02/27/insync-linux%EC%97%90%EC%84%9C-google-drive-desktop-client-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0/
    - /alternative-google-drive-desktop-client-for-linux
    - /alternative-google-drive-desktop-client-for-linux.md
    - /gollum/alternative-google-drive-desktop-client-for-linux
    - /gollum/alternative-google-drive-desktop-client-for-linux.md
---

이 글에서는 몇 없는 Google Drive의 리눅스 동기화 어플리케이션인 [Insync](https://insynchq.com) 에 대하여 알아본다. 

> Insync: Google Drive Syncing Application for Linux

> Insync: 리눅스를 위한 Google Drive 동기화 어플리케이션


Linux를 메인 OS로 사용한지도 벌써 10년 ~~가까이 되어 간다~~ 넘었다.. 처음 메인 OS를 Linux로 변경하고 불편했던 인터넷 뱅킹등의 문제는 스마트폰에서 은행 업무를 볼 수 있게 되면서 해결되었다. 그외 민원업무등 반드시 Windows가 필요한 일은 VirtualBox를 통해 해결한다.

그외 어플리케이션들은 Google Docs같은 웹 기반 어플리케이션으로 대체 가능하다.  하지만 데이터 백업 및 파일 관리용으로 사용하는 Google Drive는 신뢰할 수 있는 Alternate가 없어 고민 했하던 차에 2015년 즈음에 insync라는 Thrid-Party Application을 알게 되었다 유료지만 요즘 트렌트인 정기 결제(구독)가 아닌 One Time 결제로 사용 가능하고 각 배포판용 Repository도 별도로 제공 하기때문에 설치 역시 간편하다.headless application도 지원(3.x 버젼에 잠시 지원이 중단 되었다가 다시 지원하기 시작함) 하기 때문에 UI 없이 콘솔 상에서 실행도 가능하다. <https://www.insynchq.com>   다른 Agent들과 비교한 자료를 원하면 아래 사이트를 참조 하기 바란다. 

[use google drive linux](https://itsfoss.com/use-google-drive-linux/ )

<!--more-->

## Insync 설치

### Add APT Repository
    
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
```

_/etc/apt/sources.list.d/insync.list_ 을 생성 한다. 내용은 다음과 같다. 
    
```     
deb http://apt.insynchq.com/[DISTRIBUTION] [CODENAME] non-free contrib
```

*Ubuntu 16.04*의 경우 `[DISTRIBUTION]` 은 `ubuntu` `[CODENAME]` 은 `xenial`을 입력한다. 
*Ubuntu 18.04*의 경우 `[DISTRIBUTION]` 은 `ubuntu` `[CODENAME]` 은 `bionic`을 입력한다. 
*Ubuntu 20.04*의 경우 `[DISTRIBUTION]` 은 `ubuntu` `[CODENAME]` 은 `focal`을 입력한다. 

*Ubuntu 20.04*의 경우 아래 명령을 실행하여 
    
```bash    
echo deb http://apt.insynchq.com/ubuntu focal non-free contrib | sudo tee /etc/apt/sources.list.d/insync.list
```

패키지 리스트를 업데이트 한다. 
```
sudo apt update
```

## Installation

### UI Version
    
UI로 로그인 하였을 Insync가 실행되기를 원한다면 UI 버젼을 설치 하자. 대부분 이 버젼을 설치 하면 된다. 

```bash
sudo apt install insync
```

###  Headless Version

GUI가 없는 서버나 UI 로그인 없이 Insync를 실행 하고 싶으면 headless version을 설치 한다. 
    
```bash
sudo apt-get install insync
```

## UI 버전에서 Headless 버젼으로 변경(또는 반대의 경우) 시 유의 사항
각 설정 과 데이터베이스 파일의 구조는 크게 변하지 않은 것 같으나 위치가 변경 되었다.

* UI Version의 경우 `~/.config/Insync`
* Headless 버젼의 경우 `~/.config/Insync-headless`

따라서 UI 버젼에서 Headless 버젼으로 변경하고 Insync를 실행하면 UI 버전에서 사용하던 계정 등의 설정 정보를 같이 로드 되지 않는다.


`~/.config/Insync` 디렉터리를 `~/.config/Insync-headless`로 복사한다. 

```
cp -ap ~/.config/Insync ~/.config/Insync-headless
```

> UI 버전과 Headless 버젼의 설정 파일 구조가 언제 바뀔지 모르기 때문에 *Symbolic Link* 보다는 *Hard Link*링크로 복사하여 Headless 버젼을 실행 해 보고 문제가 발생하면 해당 디렉터리를 삭제 후 다시 설정하자.

> Headless 버전에서 UI 버젼으로 바꾸는 경우에는 반대로 수행하면 된다. 