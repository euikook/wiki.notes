---
title: Override git user name and email address temporarily
link: https://notes.harues.com/override-git-user-name-and-emal-address-temporarily
author: euikook
description: 
tags: [Linux, git, user.name, user.email, override, overriding]
---

# Override git user name and email address temporarily

```
alias git='git -c "user.name=euikook" -c "user.email=euikook@harues.com"'
```

git 커밋 시 임시 사용자 이름 및 이메일 주소 설정