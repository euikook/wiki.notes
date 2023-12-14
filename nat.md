---
title: NAT(Network Address Translate)
link: /nat
description: 
draft: true
tags: [Network, NAT]
date: 2023-12-14
banner: /images/github-actions-banner.png
---


### NAT를 사용하는 하는경우
 공유기를 사용하고 있고 서버가 할당 받은 IP가 사설IP 인경우이다. DDNS 클라이언트가 실행되는 단말기 NAT 뒤에 있으므로 단말기 할당 받은 주소는 사설IP일 경우가 크다. 
당연한 이야기이지만 할당받은 IP주소를 DDNS 서버로 보낸다면 DDNS 서버는 사설 주소를 바인당 하기 때문에 정상적으로 접속이 되지 않는다. 


#### NAT 사용여부 확인
NAT를 사용할 때와 사용하지 않을 때 설정 방법이 다르다. 

> NAT 는 **N**etwork **A**ddress **T**ranslation의 약자로 네트워크 주소 변환 이라고 한다. 우리가 쓰는 인터넷 공유기가  NAT 기능을 수행한다. 인터넷 공유기를 사용하고 있다면 NAT 를 사용하고 있을 확률이 높다. 

> 공인 IP를 할당받은 경우라도 보안상의 이유로 NAT를 사용하는 경우가 있으므로 [여기](https://nordvpn.com/what-is-my-ip/)서 확인한 IP주소와 내가 할당 받은 IP주소가 같은지  확인 해야 한다. 

> 아래 명령을 통해 할당 받은 IP를 확인할 수 있다. 
```bash
echo `curl https://domains.google.com/checkip --silent`
```