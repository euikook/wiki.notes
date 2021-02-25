---
title: Hugo Tag Cloud with jQCloud
status: publish
tags: [Hugo, Tags, jQCloud, Tag Cloud, Blog]
date: 2021-02-17 14:35:59 +0900
lastmod: 2021-02-17 14:35:59 +0900
banner: /images/tag-cloud.png
aliases:
    - /gollum/hugo-tag-cloud-with-jqcloud
    - /gollum/hugo-tag-cloud-with-jqcloud.md
---

이 글은 Hugo 기반 Blog에서 jQuery 기반 Word Cloud 라이브러인 [jQCloud](http://mistic100.github.io/jQCloud/)를 이용하여 Tag Cloud를 만드는 방법에 대하여 설명한다.


![tag cloud](/images/hugo-tag-qcloud.png)

<!--more-->

`<head>` 내에 위치하도록 아래 코드를 추가한다.

head.html
```html
<script src="https://golangkorea.github.io/js/jqcloud/jqcloud.min.js"></script>
```



`<head>` 내에 위치하도록 아래 코드를 추가한다.

head.html
```html
<link rel="stylesheet" href="https://golangkorea.github.io/js/jqcloud/jqcloud.min.css">
```


Tag Cloud가 위치할 자리에 다음 코드를 추가한다.

```html
<div style="width:90%; min-height:300px" id="tags-cloud"></div>
```

> `width` 와 `height`는 페이지 크기에 맞게 조절한다.

위 코드가 추가된 파일 마지막에 다음 코드를 추가한다.

```go-html-template
<script type="text/javascript">

    $(document).ready(function() {

        var words = [
            {{ range $name, $taxonomy := $.Site.Taxonomies.tags }}
                { text: {{ $name }}, weight: {{ len $taxonomy.Pages }}, link: {{ (print ("/tags/" | relLangURL) ($name | urlize)) }} },
            {{ end }}
        ]

        $('#tags-cloud').jQCloud(words,  { autoResize: true });
    });
</script>
```