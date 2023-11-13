---
title: jQCloud를 이용하여 Hugo 사이트에 Tag Cloud 추가하기
titlen: Hugo Tag Cloud with jQCloud
status: publish
tags: [Hugo, Tags, jQCloud, Tag Cloud, Blog]
date: 2021-02-17 14:35:59 +0900
lastmod: 2021-02-17 14:35:59 +0900
banner: /images/tag-cloud.png
---

이 글은 Hugo 기반 Blog에서 jQuery 기반 Word Cloud 라이브러인 [jQCloud](http://mistic100.github.io/jQCloud/)를 이용하여 Tag Cloud를 만드는 방법에 대하여 설명한다.


![tag cloud](/images/hugo-tag-qcloud.png)

<!--more-->

jQCloud의 js 파일을 `<head>` 내에 위치하도록 아래 코드를 추가한다.

head.html
{{< gist euikook 712b370025f1af40efa125a6384e79f2 "head.js.html" >}}



jQCloud의  stylesheet 파일을 `<head>` 내에 위치하도록 아래 코드를 추가한다.

head.html
{{< gist euikook 712b370025f1af40efa125a6384e79f2 "head.css.html" >}}


Tag Cloud가 위치할 자리에 다음 코드를 추가한다.

{{< gist euikook 712b370025f1af40efa125a6384e79f2 "tag.html" >}}


> `width` 와 `height`는 페이지 크기에 맞게 조절한다.

위 코드가 추가된 파일 마지막에 다음 코드를 추가한다.


{{< gist euikook 712b370025f1af40efa125a6384e79f2 "tag-cloud.html" >}}