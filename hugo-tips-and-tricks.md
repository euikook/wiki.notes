---
title: Hugo Tips and Tricks
tags: [hugo, tips, tricks]
draft: true
date: 2021-02-26 13:00:41 +0900
banner: https://source.unsplash.com/jKU2NneZAbI
aliases:
    - /gollum/hugo-tips-and-tricks
    - /gollum/hugo-tips-and-tricks.md
---

이 글은 Hugo를 사용하면서 경헙한 유용한 팁을 공유 하기 위해 작성 되었다. 

## Summary에 HTML코드 표시하기

Hugo에서 Summary에 표시될 부분을 명시적으로 지정하지 않을 경우 텍스트를 하나 이상의 공백으로 구분된 `Word`로 분할하여 정의된 단어 수를 표시하도록 하기 때문에 사용자가 추가한 Markdown 데코레이션 이나 사용자 가 직접 추가한 HTML 코드 등이 사용자의 의도대로 표시 되지 않는다. 이유는 단어의 수를 기준으로 표시한 내용을 정하기 때문에 렌더링된 HTML 코드를 표시할 경우 완전하지 않은 코드가 포함되어 전체 페이지를 표시 하는데 문제가 발생 할 수 있기 때문이다. 

Summary에 렌더링된 HTML코드를 표시 하게 하기 위하여 명시적인 구분자를 추가 하는 기능을 제공한다. 

각 포스트의 분할 하고자 하는 부분에 다음 코드를 추가하여 Summary에 표시될 부분과 그렇지 않은 부분으로 구분한다. 

<!--more-->

```
<!--more-->
```

> 소문자로 작성하고 공백이 없는것에 유의한다. 

자세한 내용은 Hugo 공식 문서의 [Manual Summary Splitting](https://gohugo.io/content-management/summaries/#manual-summary-splitting) 페이지를 참조 한다. 


## Lastmod

최근 수정 날짜 순으로 글 정렬하기


### `lastmod` Front Matter 
글의 Front Matter에  `lastmod` 추가 

```
---
lastmod: 2021-02-26
---
```

### GitInfo 활용하기
Hugo 사이트를 `git`로 관리 하고 있다면 git의 리비젼 정보에서 `Lastmod` 정보를 불러올 수 있다. 

명령행에서 `--enableGitInfo` 옵션을 주던지 사이트 설정파일(config.toml 같은)에 `enableGitInfo` 를 `true`로 설정하면 된다. 

```
enableGitInfo = true
```

> GitInfo Variable에 대한 내용은 다음을 참고 한다. [Git Info Variables](https://gohugo.io/variables/git/)


아래와 같이 Fromt Matter설정에서 각 변수의 선호도를 지정할 수 있다. 

```
[frontmatter]
date = ["date","lastmod"]
lastmod = [":git", "lastmod", "date"]
publishDate = ["publishDate", "date"]
expiryDate = ["expiryDate"]

```

`.Date` 변수를 *Front Matter*의 `date` 필드에서 불러오고 `date` 필드가 없을 경우 `lastmod` 필드에서 불러온다. 

> GitInfo에서 가저오고 싶으면 `:git`을 사용한다. 


> 나의 경우 예전부터 쓰는 글을 별도의 git 저장소에 관리한다. Hugo Site를 구축할때도 해당 저장소를 `content/posts` 디렉터리에 submodule로 추가하여 사용하였다. 그런데 이 GitInfo정보는 submodule에 서 가지고 오지 못하기 때문에 *Front Matter*에 `lastmod` 필드를 추가하여 활용하고 있다.



## Page Aliaes
다른 블로그나 위키 플렛폼에서 Hugo로 넘어와서 각 포스트에 대한 URL 형식이 바뀐 경우 이를 매핑 해주는 작업이 필요하다. 

같은 포스트라도 URL이 변경되면 이미 인덱싱된 데이터를 쓸모 없어져 버리기 때문이다. 

### PermLink 

`config.toml`
```
[permalinks]
  posts = "/:year/:month/:title/"
```

```
[permalinks]
  "/" = "/:year/:month/:filename/"
```

### Aliases
```
---
aliases:
    - /posts/my-original-url/
    - /2010/01/01/even-earlier-url.html
---
```

## Draft 활용하기

글을 적다 보면 임시 저장 하고 싶을 경우 *Front Matter*에 `draft` 변수를 `true`설정하자. 

```
---
draft: true
---
```

파일은 Git 저장소에서 관리되지만 정적 사이트를 생성시 해당 파일은 제외된다. 



draft도 같이 빌드 하고 싶으면 `-D` 옵션을 사용한다. 

정적 사이트 생성 시 draft를 포함 하고자 하는 경우 
```
hugo -D
```

휴고 개발서버에서 draft를 확인하고 싶을 경우 
```
hugo server -D
```
