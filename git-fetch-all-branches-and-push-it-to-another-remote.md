---
title: git fetch all branches and push it to another remote
link: /git-fetch-all-branches-and-push-it-to-another-remote
description: 
status: publish
tags: [Linux, git]
date: 2020-11-16 09:37:41 +0900
---

#### git fetch all branches and push it to another remote

## git fetch all branches and tags from origin, then push it to new remote
    
```bash
git fetch --all
for branch in `git branch -r`; do git branch --track ${branch#origin/} $branch; done
git remote add new https://newrepos.com/new.git
git push new --all
git fetch --tags
git push new tags
```