---
title: Continous Deployment Hugo with Github Actions
link: /continous-deployment-hugo-with-github-actions
description: 
status: publish
tags: [Linux, Hugo, Github, Actions, Github Actions]
date: 2021-02-09 09:37:41 +0900
banner: /images/github-actions-banner.png
---

# Continous Deployment Hugo with Github Actions

`Github Page`(이하 `GH`를 사용하여 정적 사이트를 배포 하고자 한다. 

몇몇 유명한 Static Site Generator가 있지만 `Go`를 공부할 목적으로 `Hugo` 를 선택했다.

Hugo는 Github Page에서 공식적으로 지원하는 `jekyll`과 달리 로컬에서 정적 사이트를 빌드 하여 GH 저장소에 `push` 해주어야 한다. 

Github 에서지원하는 CI/CD 인 `Github Actions`을 이용하여 이를 자동화 할 수 있는데 Github Actions은 일반적은 CI/CD 와 사용법이 비슷하다. 

## Setting up github repository for github pages 

Github Page를 생성 하기 위해서는 github 계정에 로그인 하여 `<username>.github.io` 저장소를 만들어야 한다.

    Github Page: `<username>.github.io`


앞서 생성한 `<username>.github.io` 저장소 하나를 Branch로 소스와/정적사이트 브랜치로 나누어 사용하는 방법도 있지만 관리의 효율성을 위해 아래와 같이 소스 저장소와 GH 저장소를 나누도록 한다. 


| Repository  | URL                     |
| ---:        | ---                     | 
| Source      | `src.euikook.github.io` |
| Github Page | `euikook.github.io`     |


## Registration Deploy Key 

`src.euikook.github.io` 를 수정하면 Github Action이 자동으로 실행되어 정적 사이트를 빌드하고 결과물을 `euikook.github.io` 저장소에 자동으로 `push`하기 SSH KEY를  `src.euikook.github.io` 와 `euikook.github.io`에 각각 등록 해주어야 한다.



### Create SSH Key

아래와 같이 명령을 수행하여 github-page-deploy 라는 Key Pair를 만든다.
```
ssh-keygen -t rsa -b 4096 -f github-page-deploy
```

| Type | File Name | Respository |
| ---  | ---       | ---         |
| 개인키 |  github-page-deploy | src.euikook.github.io |
| 공개키 | github-page-deploy.pub | euikook.github.io | 


src 저장소의 Settings 항목에서 Secret 메뉴로 이동한다. 

`New repository secret` 버튼을 클릭하여 새로운 Secret을 생성한다.

`Name`: `ACTIONS_DEPLOY_KEY`
`Value`: 개인키(`src.euikook.github.io`)의 내영을 추가한다.


GH 저장소의 Settings 항목에서 Deploy Key 항목을 선택하여 새로운 Deploy Key를 등록한다.

`Add deploy key`


| Field   | Value                                 |
| ---     | ---                                   |
| `Title` | 적당한 이름을 추가한다. (gh-deploy)       |
| `Key`   | 공개키(`github-page-deploy.pub`)의 내용 |


### Public Key Registration

![Github Settings](/images/github-settings.png)

![Github Add Deploy Key](/images/github-add-deploy-key.png)

![Github Add New Deploy Key](/images/github-add-new-deploy-key.png)


### Private Key Registration

![Github Secrets](/images/github-secrets.png)

![Add New Secrets](/images/github-add-new-secrets.png)



### Install Hugo
Hugo Installaion Guide 참조

### Create and Setting up Hugo Project

```
hugo create new project src.euikook.guthub.io
```

### Push Hugo site to repository

```
git remote add origin src.euikook.guthub.io
git push -u origin master
```


### Create Github Actions

Source 저장소에 Action을 생성한다. 

.github/workflows/deployment.yml



```yml
jobs:
  build-deploy:
    runs-on: ubuntu-18.04
    steps:
    - uses: actions/checkout@v1
      with:
        submodules: true

    - name: Setup Hugo
      uses: peaceiris/actions-hugo@v2
      with:
        hugo-version: '0.80.0'

    - name: Build
      run: hugo --minify

    - name: Deploy
      uses: peaceiris/actions-gh-pages@v2
      env:
        ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
        EXTERNAL_REPOSITORY: euikook/euikook.github.io
        PUBLISH_BRANCH: master
        PUBLISH_DIR: ./public
      with:
        emptyCommits: false
        commitMessage: ${{ github.event.head_commit.message }}
```

![Github Actions](/images/github-actions.png)