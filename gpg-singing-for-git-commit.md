---
title: GPG를 이용하여 Git 커밋에 서명하기
draft: false
tags: [Git, Github, GPG Signed Commit, GPG, Signing, PGP, OpenPGP]
banner: /images/sign.jpg
date: 2021-03-17 21:56:32 +0900
---

## 커밋에 서명이 필요한 이유
Git은 버전관리 시스템(VCS, Version Control System)이기 때문에 가지는 태생적인 문제가 있다. Subversion과 같은 중앙 집중형 버전관리 시스템은 모든 소스트리가 중앙에서 관리 되기 때문에 사용자사 자신의 수정사항을 저장하고 싶으면 중앙에 있는 버전관리 시스템으로 커밋(서브버전 기준)하여야 한다. 인증 이 필요한 원격의 저장소를 사용한다고 가정하면 커밋할때 마다 매번 인증을 받아야 하고 인증 받은 정보가 Commit에 포함되기 때문에 인증 정보를 도용당하지 않는 이상 기여자의 정보가 부정 사용될 경우는 거의 없다. 

하지만 Git와 같은 분산형 버전관리 시스템의 경우 로컬에서 자신만의 소스 관리가 가능하고 커밋에 저장되는 커밋의 작성자(Author) 커밋터(Committer)정보가 커밋의 주체가 제공하는 정보에 의존하기 때문에 기여자의 정보가 부정 사용될 우려가 있다. 

최근 나오는 사기의 대부분은 권위있는 사람이나 사이트 또는 단체로 가장하여 사용자의 결제 정보를 포함한 개인 정보를 탈취하는 것이다.  

프로젝트의 관리자가 Pull Request를 받았다고 가정하자. 가장 이상적인 관리 방법은 관리자가 모든 코드를 리뷰 하고 문제가 없을 경우에만 해당 요청을 승인 하는것이지만 관리자가 모든 코드를 리뷰 하지 못하는 경우 앞서 학습된 기여자의 평판에 의존 하여 승인 여부를 결정 할 수 있다. 공격자는 관리자가 신뢰할 만한 기여자의 이름을 도용하여 Pull Request를 하면 관리자는 도용된 기여자의 평판을 기반으로 승인 여부를 결정할 수 있기 때문에 문제가 발생할 수 있다. 그렇다면 이러한 명의의 도용을 막는 방법은 무엇이 있을까? 


## 도용을 막기 위한 방법은 무엇이 있을까?

Git에서는 인터넷에서 가저온 커밋이 실뢰할 수 있는 출처에서 온것인지 확인하는 방법으로 GPG를 사용하여 커밋에 서명하는 기능을 제공한다.  

> 커밋에대한 서명은 Git v1.7.9 또는 그 이상에서만 제공된다. 

> GPG(GNU Privacy Cuard)는 GNU에서 제공하는 OpenPGP(RFC4880)의 오픈소스 구현이다. 

GPG의 사용법은 [GPG(GnuPG) 사용하기](/posts/how-to-use-gpg)를 참고 한다. 

## 커밋에 서명하기 


GPG Key Pair가 없는 경우 `--full-gen-key` 옵션으로 키를 생성한다. 

```
gpg --full-gen-key
```

Key Pair 생성에 대한 자세한 방법은 [GPG(GnuPG) 사용하기/Key Pair 생성](/posts/how-to-use-gpg/#key-pair-생성)을 참고 한다. 


아래와 같이 개인 키의 리스트 중에 사용할 개인 키의 ID를 복사 한다. 

```
gpg --lst-secret-keys --keyid-format LONG 
```

아래는 `john@acme.com`의 개인 키에 대한 예제 출력이다. 
```
sec   rsa4096/70278B7766602624 2021-03-17 [SC] [expires: 2023-03-17]
      4D4E4059E7068A5C703C898E70278B7766602624
uid                 [ultimate] John Doe (ACME Inc.) <john@acme.com>
ssb   rsa4096/EC736BC8E36D823D 2021-03-17 [E] [expires: 2023-03-17]
```

위 출력에서 첫 번째 라인의  `70278B7766602624`가 GPG key ID 이다. 


`git config` 명령으로 `user.signingkey` 옵션을 설정한다. 


```
git config user.signingkey 70278B7766602624
```

계정의 기본 옵션을 설정 하려면 `--global` 옵션을 사용한다. 

```
git config --global user.signingkey 70278B7766602624
```


이제 커밋에 서명을 해보자. 수정 사항을 스테이징 하고 커밋 한다. `--gpg-sign` `-S` 옵션을 사용하면 커밋이 개인키로 서명된다. 

```
git commit -S -m "My first signed commit"
```


`--show-signature` 옵션으로 서명 정보를 볼 수 있다.
```
git log --show-signature -1
```

```
commit 20872c5f0673a47a78a8fafa0c8b9ccba4d766b6 (HEAD -> master, origin/master)
gpg: Signature made Wed 17 Mar 2021 09:25:04 PM KST
gpg:                using RSA key 4D4E4059E7068A5C703C898E70278B7766602624
gpg: Good signature from "euikook <john@acme.com>" [ultimate]
Author: John Doe <john@acme.com>
Date:   Wed Mar 17 21:25:04 2021 +0900

    My first signed commit
```



## Github에 GPG 공개키 등록 하기

다음 명령으로 공개키 리스트를 확인하고 서명한 키에 대응되는 공개키의 Key ID를 복사한다. 
```
gpg --list-key
```

```
pub   rsa4096 2021-03-17 [SC] [expires: 2023-03-17]
      4D4E4059E7068A5C703C898E70278B7766602624
uid           [ultimate] John Doe (ACME Inc.) <john@acme.com>
sub   rsa4096 2021-03-17 [E] [expires: 2023-03-17]
```

Key ID 가 `4D4E4059E7068A5C703C898E70278B7766602624` 이다.


`--export` 옵션과 `--armor` 옵션을 사용하여 공개키를 내보낸다. 

```
gpg --export --armor  4D4E4059E7068A5C703C898E70278B7766602624
```

아래는 john@acme.com의 공개 키(`4D4E4059E7068A5C703C898E70278B7766602624`)를 내보내기 한 결과이다. 

안전한 곳에 복사해 둔다. 

```
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
NwHPf0tX2G2Mz2KR
=y3/s
-----END PGP PUBLIC KEY BLOCK-----
```


Github에 수정사항을 푸쉬하기 전에 서명한 키에 대응되는 공개키를 Github에 등록 하여야 한다. 

Github에 접속하 로그인 하자. 우측 상단의 아바타를 클릭 하여 설정(Setting) 화면으로 이동한다. 

![Github - Settings](/images/github-gpg-001.png)

우측의 메뉴 중 `SSH and GPG Keys`를 선택 한다. 

![Github - Settings](/images/github-gpg-002.png)

`New PGP Key` 버튼을 클릭한다. 

![Github - Settings](/images/github-gpg-003.png)

앞서 복사한 공개 키를 붙여 넣고 `Add GPG Key` 버튼을 눌러 키를 등록한다.


![Github - Settings](/images/github-gpg-004.png)

비밀번호를 입력하여 키를 등록한다. 


![Github - Settings](/images/github-gpg-005.png)

`jone@acme.com` 에 대한 공개키가 등록 되었다. 뒤에 `Unverified` 배지는 메일주소 `jone@acme.com`가 내 계정에 등록된 메일주소가 아니기 때문이다. 


![Github - Settings](/images/github-gpg-007.png)

그림과 같이 `Setting` / `Emails`에 등록된 이메일에 대한 키를 등록하면 된다.


![Github - Settings](/images/github-gpg-006.png)

그림의 `euikook@gmail.com` 에 대한 GPG Key는 `Unverified` 배지가 없다.


## 커밋 올리기


Github에 서명된 커밋을 Push 한다. 
```
git push
```

Push 후 해당 저장소의 커밋 정보를 열람 해보자. 

이래와 같이 `Verified` 베지가 붙어 있다. 바르게 서명 되었고 Github에서 서명을 등록한 공개키로 검증 한 것이다. 

![Github GPG Signed Commit](/images/github-gpg-signed-commit.png)

[euikook/gpg-sign-test](https://github.com/euikook/gpg-sign-test/commits/main)