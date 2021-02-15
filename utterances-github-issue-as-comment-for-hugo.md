---
title: "utterances: github issue as comment for Hugo"
link: utterances-github-issue-as-comment-for-hugo
description: 
draft: false
tags: [utterances, github page, github, issues, comment, hugo]
banner: https://source.unsplash.com/JZ8AHFr2aEg
date: 2021-02-15 12:51:20+0900
banner: https://source.unsplash.com/bzK0qeeoBJo
---

# utterances: github issue as comment for Hugo


## Simple method
`thmem/<theme-name>/partials/` 디렉터리에 `utterances.html` 파일을 만들고 아래 와 같은 내용을 추가 한다.  


`thmem/<theme-name>/partials/utterances.html`

```html
<script src="https://utteranc.es/client.js"
        repo="<username>/<username>.github.io"
        issue-term="pathname" 
        theme="github-light"
        crossorigin="anon"
        async>
</script>
```
> `<username>/<username>.github.io`의 <username>은 자신의 github username으로 변경 한다. 

> Comment를 위한 별도의 저장소를 사용하고자 한다면 해당 저장소의 이름으로 변경한다. 

## More graceful 

`.Site.Params.utterances.repo` 변수가 설정 되었을 경우에만 해당 코드가 로그 되게 설정하고 싶다면 `utterances.html` 파일을 아래와 같이 수정한다. 


`thmem/<theme-name>/partials/utterances.html`

```go-html-template
{{ if (not (eq .Site.Params.utterances.repo "")) }}

{{ $term := "pathname" }}
{{ $theme := "github-light" }}
{{ $crossorigin := "anonymous"}}

<script src="https://utteranc.es/client.js"
        repo="{{ .Site.Params.utterances.repo }}"
        issue-term="{{ .Site.Params.utterances.term | default $term }}" 
        theme="{{ .Site.Params.utterances.theme | default $theme }}"
        crossorigin="{{ .Site.Params.utterances.crossorigin | default $crossorigin }}"
        async>
</script>

{{ end }}
```

`config.toml` 파일에 아래과 같은 내용을 추가한다.

`config.toml`
```toml
[params.utterances]
    repo = "<username>/<username>.github.io"
    # term = "pathname"
    # theme = "github-light"
    # crossorigin = "anonymous"
```
> `<username>/<username>.github.io`의 <username>은 자신의 github username으로 변경 한다. 

> Comment를 위한 별도의 저장소를 사용하고자 한다면 해당 저장소의 이름으로 변경한다. 


## Add utterances to post

적당한 위치에 다음 라인을 추가 한다. 

```go-html-template
{{ partial "utterances" . }}
```
