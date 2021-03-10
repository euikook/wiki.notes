---
title: Weighted Tag Cloud to Hugo
status: publish
tags: [Hugo, Tags, Tag Cloud, Blog]
date: 2021-02-17 10:22:59 +0900
lastmod: 2021-02-17 10:22:59 +0900
banner: /images/tag-cloud.png
series: ["Go Web Dev"]
aliases:
    - /gollum/hugo-weighted-tag-cloud
    - /gollum/hugo-weighted-tag-cloud.md
---

이 글은 Hugo 기반 Blog에서 Tag Cloud를 만드는 방법에 대하여 설명한다.


![tag cloud](/images/hugo-tag-cloud.png)

Tag의 사용빈도에 따라 Tag의 크기를 조절한다.

<!--more-->

{{< gist euikook 1ba98f13df7741e12771b3ed51f73788 "tag_cloud.html" >}}


`unordered list`(`<ul>`)를 이용하였기 때문에 Tag가 한 라인에 하나씩 표시된다. 

아래와 같이 스타일링 하여 여려 목록이 한 라인에 표시 되도록 한다.

style.css

{{< gist euikook 1ba98f13df7741e12771b3ed51f73788 "style.css" >}}


그냥 두면 조금 알파벳 순으로 정렬되어 조금 심심해 보인다. Tag의 순서를 무작위로 썩자.

두가지 방법이 있다. 

1. Template에서 썩는 방법
2. Javascript로 썩는 방법

Template으로 썩으면 Hugo 사이트를 빌드 할때 Tag의 순서가 결정됨으로 조금 심심한 감이 있다. 

Javascript를 이용하여 Tag를 썩자 이러면 페이지를 새로 고칠때 마다 Tag의 순서가 바뀐다.


다음 내용을 적당한 곳에 추가하자. 
> Template 파일에 직접 추가해도 되지만 Tag Cloud를 여러 Template에서 사용하는 경우 `<head>`에서 불러 오는 custom js 파일에 추가하자.


custom.js

{{< gist euikook 1ba98f13df7741e12771b3ed51f73788 "custom.js" >}}


다음에는 jQuery 기반 Word Cloud 라이브러리인 [jQCloud](http://mistic100.github.io/jQCloud/demo.html)를 이용하는 방법에 대해 설명한다. 

## References
* [Weighted tag cloud](https://discourse.gohugo.io/t/weighted-tag-cloud/3491/4)