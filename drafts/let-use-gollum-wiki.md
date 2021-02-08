---
title: Let use gollum wiki
link: /drafts/let-use-gollum-wiki
description: 
status: publish
tags: [wiki, gollum, ruby, git, Let's Encrypt, certbot]
---

# Let use gollum wiki

## gollum - A git-based Wiki

## Docker Image

```
https://github.com/euikook/gollum-unicorn.git
```

## Install instruction

### Let's Encrypt

Set `DOMAINS` variable
```
export DOMAINS="harues.com notes.harues.com"
```

Start nginx webroot server
```
make webroot
```

Get Let's Encrypt certificate using certbot
```
make certbot
```


### Run Gollum as docker service

```
docker-compose up -d
```

## Generate sitemap.xml



`gollum/app.rb`
```
```

`bin/gollum.rb`
```
```

`views/sitemap.rb`
```
```

<<Note("Did you know?", "https://github.com/euikook/gollum")>>