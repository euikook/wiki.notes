---
title: 클라우드 플레어에서 DDNS 사용하기
link: /ddns-with-coudflare
draft: true
description: 
status: publish
tags: [Linux, Ubuntu, DDNS, HowTo, 'DNS', 'Google']
date: 2024-03-03
banner: /images/github-actions-banner.png
katex: true
---


## 개요 
[Google Domains](https://domains.google.com)에의 도메인 등록 과 고객 정보를 Squarespace, Inc. 로 이전 하기로 하였다. 자세한 내용은 [여기](https://support.google.com/domains/answer/13689670?authuser=0&hl=ko)를 참고 하자. 아직 [구글 도메인즈](https://domains.google.com)를 통해 도메인에 대한 관리는 가능하지만 이전에 완료 되는 대로 Google Domains 서비는 종료 할 것으로 보인다. 즉, 이전에 완료된 후에는 Squarespace에서 도메인을 관리 해야 한다. 


네임서버를 제공하는 여러 서비스와 도메인 등록 업체를 비교 하여 관리 하고 있는 도메인의 네임서버를 [Cloudflare](https://www.cloudflare.com/)로 이전하기로 결정하였다. 


## DDNS with Google Domains

[구글 도메인즈](https://domains.google.com)에서는 DDNS 서비를 제공하여 DDNS 프로토콜을 통해 도메인 이름에 유동 IP를 할당 하는 기능을 제공하지만 [Cloudflare](https://www.cloudflare.com/)에서는 DDNS기능을 제공하지 않는다. 하지만 REST API를 통해 도메인의 IP주소를 업데이트 할 수 있으므로 이 기능을 이용하여 동적으로 도메인 네임에 대한 IP주소를 업데이트 할 수 있다. 

잠시 짬을 내어 창고에서 잠자고 있던 구형 PC로 개발 서버로 쓰기 위해 리눅스도 설치 하고 몇가지 개발 환경을 구축 했다. 유동 IP를 쓰다 보니 할당받은 IP가 변경 되었을 때 외부에서 접속할 방법이 마땅치 않아 내가 사용하는 도메인 네임 서비스인 [구글 도메인즈](https://domains.google.com)에 을 통해 DDNS 설정을 하기로 하였다. 


[Cloudflare](https://www.cloudflare.com/) DNS 레코드를 만들고 우분투 서버에서 REST API를 통해 IP주소를 업데이트 하는 방법에 대해 알아본다.

DNS나 DDNS의 동작에 대한 간단한 내용은 [구글 도메인에서 DDNS 사용하기](/posts/ddns-with-google-dns/#dns-란)를 참고 하자. 



#### DNS A레코드 추가 하기

[Google Domains](https://domains.google.com/registrar/) 에서 DDNS에서 사용할 A 레코드를 추가 한다. 

1. 내도메인 에서 추가 하고 싶은 도메인을 선택한다. 
2. 오른쪽 사이드 메뉴에서 DNS를 선택한다. 
3. 메인 페이지 맨 아래쪽의 *고급설정표시*를 클릭 하여 고급 설정 을 연다. 
4. *동적 DNS 관리* 버튼을 클릭하면 및에 DDNS 호스트를 입력 할 수 있는 입력 창이 나타난다. 
5. 입력항에 원하는 호스트 이름을 입력하고 저장 버튼을 누른다. 
6. 동적 DNS 하위 메뉴에 *도메인에 동적 DNS가 설정됨*을 클릭하면 설정된 동적 DNS 호스트를 확인할 수 있다. 
7. *사용자 인증 정보 보기* 버튼을 클릭하면 DDNS 클라이언트에서 사용할 사용자 이름과 비밀번호가 나온다. 보기 버튼을 클릭하면 나오는 사용자 이름과 비밀번호를 별도 파일에 저장한다. 


### DDNS 클라이언트 설치 

DDNS 클라이언트로 `ddclient`를 설치 한다. 

`apt` 명령을 사용하여 `ddclient`를 설치 한다. 


```bash
sudo apt install ddclient
```

우분투에서 `apt` 명령을 통해  `ddclient`  설치하면 설정 마법사가 자동으로 실행된다. 


아래와 같이 설정한다. 

1. `Dynamic DNS service provider`를 `domains.google` 로 선택한다.
2. `Optional HTTP proxy` 그냥 빈칸으로 설정한다.
3. `Username` 과  `Password`를 입력한다. 입력값은 앞서 저장한 인증 정보를 사용해야 한다.
4. `IP address discovery method`는 `web-based IP discovery service` 를 선택한다. 
5. `web-based IP discovery service`는 `googledomains https://domains.google.com/checkip`를 선택한다. 
7. `Time between address check`는 5분(`5m`) 그대로 사용하거나 원하는 값을 입력한다. 
8. `Host to update`에는 사용하고자 하는 도메인 이름을 입력한다. 

설정이 완료 되었다. 

설정 마법사에서 생성한 설정파일은 `/etc/ddclient.conf` 에 위치한다.

```
protocol=googledomains 
use=web, web=https://domains.google.com/checkip 
login=XLinEKbiWcJDHNlx 
password='4p5Gzes23RxsfaUw' 
ddns.oneuon.com

```


`ddclient` 설정을 변경하고 싶을 경우 아래와 같이 `dpkg` 명령을 통해 재설정 할 수 있다. 

```bash
sudo dpkg-reconfiguration ddclient
```

설정 업데이트 이후 데몬은 자동으로 재시작 된다.  

클라이언트의 설정은 변경없이 네임서버의 DDNS A레코드를 삭제 했다가 다시 생성한경우 `ddclient` 데몬을 재시작 하더라도 네입서버의 IP주는 업데이트 되지 않는다. 이유는 `ddclient`는 네임서버로 주소 업데이트 요청을 하기전 캐시 파일과 현재 구성을 피교 하여 구성이 없데이트 되었을 경우에만 네입서버로 업데이트 요청을 하기 때문이다. 캐시파일은  `/var/cache/ddclient/ddclient.cache`에 위치한다. 

아래와 같이 캐시 파일을 삭제 하고 데몬을 제사작한다. 

```bash
sudo cat /var/cache/ddclient/ddclient.cache
sudo systemctl restart ddclient
```
