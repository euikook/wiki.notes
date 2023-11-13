---
title: "Waht is system-journald"
link: waht-is-system-journald
draft: true
tags: [Linux, systemd, journald, system-journald]
date: 2021-03-05 14:35:33 +0900
lastmod: 2021-03-05 14:35:33+0900
banner: https://source.unsplash.com/bzK0qeeoBJo
---

이 글에서는 systemd의 일부분인 journald에 대해서 설명한다.


`journald`는   `systemd`의 일부분으로 로깅 기능을 담당한다.

> `systemd`는 `sshd`등과 같은 서비스의 시작 시키고 서비스가 계속 유지되도록 한다.

`journald`는 systemd에서 관리되는 서비스에서 생성된 로그 메시지를 수집하고 관리 합니다. 

