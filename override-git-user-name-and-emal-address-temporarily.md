---
title: Override git user name and email address temporarily
link: /override-git-user-name-and-emal-address-temporarily
description: 
status: publish
tags: [Linux, git, user.name, user.email, override, overriding]
date: 2020-11-16
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/842ofHC6MaI
aliases:
    - /20/11/16/override-git-user-name-and-email-address-temporarily/
    - /override-git-user-name-and-emal-address-temporarily
    - /override-git-user-name-and-emal-address-temporarily.md
    - /gollum/override-git-user-name-and-emal-address-temporarily
    - /gollum/override-git-user-name-and-emal-address-temporarily.md
---

# Override git user name and email address temporarily

이 글에서는 전역이나 프로젝트에 설정된 git 사용자가 자신이 아닌경우 임시로 username과 email을 설정 하는 방법을 설명한다. 


Terminal에서 git 명령을 수행 하기 전에 아래 명령을 수행하여 git 명령을 잠시 override 하자.

```
alias git='git -c "user.name=euikook" -c "user.email=euikook@harues.com"'
```
> 임시 사용자 이름 및 이메일 주소 설정

Terminal을 빠져 나오면 설정이 날아가기 때문에 타인의 PC에서 수정한 사항을 커밋할 경우 유용하게 사용할 수 있다. 

<!--more-->


현재 설정된 `user.name`나 `user.email`을 확인하기 위해서는 

```
git config user.name
```

```
git config user.email
```

설정된 설정을 모두 확인 하고 싶으면 `--list` 옵션을 사용하면 된다. 

```
git config --list
```
