---
title: Override git user name and email address temporarily
link: /override-git-user-name-and-emal-address-temporarily
description: 
status: publish
tags: [Linux, git, user.name, user.email, override, overriding]
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/842ofHC6MaI
---

# Override git user name and email address temporarily

```
alias git='git -c "user.name=euikook" -c "user.email=euikook@harues.com"'
```

git 커밋 시 임시 사용자 이름 및 이메일 주소 설정