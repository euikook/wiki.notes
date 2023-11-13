---
title: About authentication to Github
tags: [Github, Github.com, SSH, Personal Access Token, PAT]
date: 2021-02-12 17:34:41 +0900
lastmod: 2021-02-12 17:34:41 +0900
banner: https://source.unsplash.com/3wPJxh-piRw
---

다음과 같은 메일이 왔다. 


> Hi @euikook,
>
> You recently used a password to access the repository at euikook/wiki.notes with git using git/2.30.2.
>
> Basic authentication using a password to Git is deprecated and will soon no longer work. Visit https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information around suggested workarounds and removal dates.
>
> Thanks,
> The GitHub Team


[Github Blog Token: Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)

보안 강화를 위하여 2021년 08월 13일 부터 Git 작업을 위한 인증 시 암호를 통한 인증을 지웒 하지 않는다고 한다. 2021년 08월 13일 이후에는 Git 작업을 위해서는 토큰 기반 인증을 사용하거나 SSH 키를 통한 인증을 사용해야 한다. 

> 지금도 [`2 단계 인증`](https://help.github.com/en/github/authenticating-to-github/securing-your-account-with-two-factor-authentication-2fa)을 활성화 한 사람은 암호를 통한 인증을 사용할 수 없다.  


## About authentication to Github

Github에 인증하는 방법은 다음과 같다. 

* (2 단계 인증을 통한) `username`, `password`
* Personal access token
* SSH Key


> Github.com에 수정사항을 기여(Contribution)하지 않는 다면 크게 상관 없다. 

> [`2 단계 인증`](https://help.github.com/en/github/authenticating-to-github/securing-your-account-with-two-factor-authentication-2fa)을 사용하고 있다면 지금도  계정 암호가 아니라 [`Personal Access Token`](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)을 통해서 인증 해야 하기 때문에 상관이 없다. 

<!--more-->


개인 PC 에서는 SSH Key를 등록하면 되니 상관 없지만 이 `Personal Access Token`이 왜우지 못할만큼 엄청나게 길기때문에 개인 PC가 아닌 외부에서 수정사항을 Push 하려면 일일이 github.com에 접속해서 `Personal Access Token`을 복사하여 사용해야 한다. 보안에는 매우 좋겠지만 여간 불편한게 아니다. 


## 바뀌는점

Github.com repository는 HTTPS와 SSH를 통해 액세스 할 수 있다.

### HTTPS 사용자
HTTPS를 이용 하여 저장소에 접근하는 경우 `Personal Access Token`을 이용하여 접근 하면 된다.  
> 다른 대안은 없다. 

SSH를 통해 액세스 방법으로 변경하자.


저장소 URL을 확인한다.
```
git remote -v 
origin https://github.com/USERNAME/REPOSITORY.git (fetch)
origin https://github.com/USERNAME/REPOSITORY.git (push)
```

`set-url` 명령을 이용하여 저장소 URL을 HTTPS에서 SSH로  변경하자.
```
git set-url origin git@github.com:USERNAME/REPOSITORY.git
```

잘 변경되었는지 확인하자.
```
git remote -v 
origin git@github.com:USERNAME/REPOSITORY.git (fetch)
origin git@github.com:USERNAME/REPOSITORY.git (push)
```

### SSH 사용자
변경사항 없이 계속 사용가능하다.


## **아래와 같이 *브라운아웃(Brownout)* 이 예정되어있다.**

> 소프트웨어 공학에서 브라운아웃(Brownout)은 응용 프로그램의 특정 기능을 비활성화 하는 기법이다. [Wikipedia: Brownout (software engineering)](https://en.wikipedia.org/wiki/Brownout_(software_engineering)) 


아래와 같이 예고된 시간에는 Account Password를 통한 인증이 비활성화 되기 때문에 Account Password를 통한 Git 작업을 할 수 없다. 

당황하지 말고 SSH를 통한 접근하던지 Personal Access Token을 발급받아 접속하도록 하자.


> **2021년 06월 30일**
> * 07:00 UTC - 10:00 UTC
> * 16:00 UTC - 19:00 UTC

> **2021년 07월 28일**
> * 07:00 UTC - 10:00 UTC
> * 16:00 UTC - 19:00 UTC


한국 시간으로 변경하면 다음과 같다. 

> **2021년 06월 30일**
> * 16:00 KST - 19:00 KST

> **2021년 07월 01일**
> * 01:00 KST - 04:00 KST

> **2021년 07월 28일**
> * 16:00 KST - 19:00 KST

> **2021년 07월 29일**
> * 01:00 KST - 04:00 KST
