---
title: Weighted Tag Cloud to Hugo
description: Append Tag Cloud to Hugo based blog
status: publish
tags: [Hugo, Tags, Tag Cloud, Blog]
created: 2021-02-17 10:22:59 +0900
date: 2021-02-17 10:22:59 +0900
banner: /images/tag-cloud.png
aliases:
    - /gollum/hugo-weighted-tag-cloud
    - /gollum/hugo-weighted-tag-cloud.md
---

이 글은 Hugo 기반 Blog에서 Tag Cloud를 만드는 방법에 대하여 설명한다.


![tag cloud](/images/hugo-tag-cloud.png)

Tag의 사용빈도에 따라 Tag의 크기를 조절한다.

tag_cloud.html
```go-html-template 

{{ if .Site.Params.widgets.tag_cloud }}
{{ if isset .Site.Taxonomies "tags" }}

<div class="widget-wrap">
    <h3 class="widget-title">
        {{ with .Site.Data.l10n.widgets.tags.title }}{{.}}{{end}}
    </h3>

    {{ if not (eq (len $.Site.Taxonomies.tags) 0) }}
        {{ $fontUnit := "rem" }}
        {{ $largestFontSize := 2.0 }}
        {{ $largestFontSize := 2.5 }}
        {{ $smallestFontSize := 1.0 }}
        {{ $fontSpread := sub $largestFontSize $smallestFontSize }}
        {{ $max := add (len (index $.Site.Taxonomies.tags.ByCount 0).Pages) 1 }}
        {{ $min := len (index $.Site.Taxonomies.tags.ByCount.Reverse 0).Pages }}
        {{ $spread := sub $max $min }}
        {{ $fontStep := div $fontSpread $spread }}

        <ul class="term-cloud" style="padding: 5px 15px">
            {{ range $name, $taxonomy := $.Site.Taxonomies.tags }}
                {{ $currentTagCount := len $taxonomy.Pages }}
                {{ $currentFontSize := (add $smallestFontSize (mul (sub $currentTagCount $min) $fontStep) ) }}
                {{ $count := len $taxonomy.Pages }}
                {{ $weigth := div (sub (math.Log $count) (math.Log $min)) (sub (math.Log $max) (math.Log $min)) }}
                {{ $currentFontSize := (add $smallestFontSize (mul (sub $largestFontSize $smallestFontSize) $weigth) ) }}
                <!--Current font size: {{$currentFontSize}}-->
                <li class="term-items">
                    <a href="{{ "/tags/" | relLangURL }}{{ $name | urlize }}" style="font-size:{{$currentFontSize}}{{$fontUnit}}">{{ $name }}</a>
                </li>
            {{ end }}
        </ul>
    {{ end }}
</div>
{{ end }}
{{ end }}
```

`unordered list`(`<ul>`)를 이용하였기 때문에 Tag가 한 라인에 하나씩 표시된다. 

아래와 같이 스타일링 하여 여려 목록이 한 라인에 표시 되도록 한다.

style.css
```css
.term-cloud li a:hover {
  color: hotpink;
}

ul {
  list-style-type: none;
}

.term-cloud li {
  text-decoration: none;
  display: inline-block;
  padding: 0px 4px;
}
```

그냥 두면 조금 알파벳 순으로 정렬되어 조금 심심해 보인다. Tag의 순서를 무작위로 썩자.

두가지 방법이 있다. 

1. Template에서 썩는 방법
2. Javascript로 썩는 방법

Template으로 썩으면 Hugo 사이트를 빌드 할때 Tag의 순서가 결정됨으로 조금 심심한 감이 있다. 

Javascript를 이용하여 Tag를 썩자 이러면 페이지를 새로 고칠때 마다 Tag의 순서가 바뀐다.


다음 내용을 적당한 곳에 추가하자. 
> Template 파일에 직접 추가해도 되지만 Tag Cloud를 여러 Template에서 사용하는 경우 `<head>`에서 불러 오는 custom js 파일에 추가하자.


custom.js
```javascript
const shuffle = array => {
    let shuffled = [...array],
        currIndex = array.length,
        tempValue,
        randIndex
    
    while (currIndex) {
        randIndex = Math.floor(Math.random() * currIndex)
        currIndex--
    
        tempValue = shuffled[currIndex]
        shuffled[currIndex] = shuffled[randIndex]
        shuffled[randIndex] = tempValue
    }
    return shuffled
}
    
let termClouds = document.querySelectorAll('.term-cloud')

for (let termCloud of termClouds) {
    if (termCloud) {
        let terms = termCloud.querySelectorAll('.term-cloud li')
        shuffle(terms).forEach(term => term.parentElement.appendChild(term))
    }
}
```

다음에는 jQuery 기반 Word Cloud 라이브러리인 [jQCloud](http://mistic100.github.io/jQCloud/demo.html)를 이용하는 방법에 대해 설명한다. 

## References
* https://discourse.gohugo.io/t/weighted-tag-cloud/3491/4