---
title: Hugo Tips and Tricks
tags: [hugo, tips, tricks]
draft: true
date: 2021-02-20 15:00:41 +0900
banner: https://source.unsplash.com/jKU2NneZAbI
aliases:
    - /gollum/hugo-tips-and-tricks
    - /gollum/hugo-tips-and-tricks.md
---

이 글은 Hugo를 사용하면서 경헙한 유용한 팁을 공유 하기 위해 작성 되었다. 

## Summary 페이지에 HTML코드 표시하기

Hugo에서 Summary에 표시될 부분을 명시적으로 지정하지 않을 경우 텍스트를 하나 이상의 공백으로 구분된 `Word`로 분할하여 정의된 단어 수를 표시하도록 하기 때문에 사용자가 추가한 Markdown 데코레이션 이나 사용자 가 직접 추가한 HTML 코드 등이 사용자의 의도대로 표시 되지 않는다. 이유는 단어의 수를 기준으로 표시한 내용을 정하기 때문에 렌더링된 HTML 코드를 표시할 경우 완전하지 않은 코드가 포함되어 전체 페이지를 표시 하는데 문제가 발생 할 수 있기 때문이다. 

Summary에 렌더링된 HTML코드를 표시 하게 하기 위하여 명시적인 구분자를 추가 하는 기능을 제공한다. 

각 포스트의 분할 하고자 하는 부분에 다음 코드를 추가하여 Summary에 표시될 부분과 그렇지 않은 부분으로 구분한다. 

<!--more-->

```
<!--more-->
```

> 소문자로 작성하고 공백이 없는것에 유의한다. 

자세한 내용은 Hugo 공식 문서의 [Manual Summary Splitting    ](https://gohugo.io/content-management/summaries/#manual-summary-splitting) 페이지를 참조 한다. 

## `Lastmod`

문서의 Front Matter에 있는