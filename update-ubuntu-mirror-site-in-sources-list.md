---
title: Update Ubuntu Mirror  Site in sources.list
link: /update-ubuntu-mirror-site-in-sources-list
description: 
status: publish
tags: [Linux, Ubuntu, Mirror]
---

#### Update Ubuntu Mirror  Site in sources.list

```bash
sudo sed -i 's|http://archive.ubuntu.com|http://ftp.daumkakao.com|g' /etc/apt/sources.list
```