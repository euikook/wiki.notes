---
title: Update Ubuntu Mirror  Site in sources.list
link: /update-ubuntu-mirror-site-in-sources-list
description: 
status: publish
tags: [Linux, Ubuntu, Mirror]
date: 2018-02-05
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/random/800x400
---

#### Update Ubuntu Mirror  Site in sources.list

```bash
sudo sed -i 's|http://archive.ubuntu.com|http://ftp.daumkakao.com|g' /etc/apt/sources.list
```

<!--more-->