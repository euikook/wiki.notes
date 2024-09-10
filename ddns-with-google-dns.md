---
title: 구글 도메인에서 DDNS 사용하기
link: /ddns-with-google-domains
description: 
status: publish
tags: [Linux, Ubuntu, DDNS, HowTo, 'DNS', 'Google']
date: 2023-12-14
banner: /images/github-actions-banner.png
katex: true
---


## Google Domains 
[Google Domains](https://domains.google.com)에의 도메인 등록 과 고객 정보를 Squarespace, Inc. 로 이전 하기로 하였다. 자세한 내용은 [여기](https://support.google.com/domains/answer/13689670?authuser=0&hl=ko)를 참고 하자. 아직 [구글 도메인즈](https://domains.google.com)를 통해 도메인에 대한 관리는 가능하지만 이전에 완료 되는 대로 Google Domains 서비는 종료 할 것으로 보인다. 즉, 이전에 완료된 후에는 Squarespace에서 도메인을 관리 해야 한다. 


시간을 내어 관리 하고 있는 도메인의 네임서버를 Cloudflare로 이전하는 작업을 하였다. 


## DDNS with Google Domains
잠시 짬을 내어 창고에서 잠자고 있던 구형 PC로 개발 서버로 쓰기 위해 리눅스도 설치 하고 몇가지 개발 환경을 구축 했다. 유동 IP를 쓰다 보니 할당받은 IP가 변경 되었을 때 외부에서 접속할 방법이 마땅치 않아 내가 사용하는 도메인 네임 서비스인 [구글 도메인즈](https://domains.google.com)에 을 통해 DDNS 설정을 하기로 하였다. 

DDNS 구글 도메인즈 뿐만 아니라 많은 도메인 등록 업체나 네임서버 서비스 업체에서 제공하는 기능이기 때문에 아래 설명을 활용해 볼 수 있다. 

아래는 구글 도메인에서 DDNS 레코드를 만들고 우분투 서버에서 DDNS 클라이언트를 설정 하는 방법에 대해 적어 본다. 

동적 DNS를 이해 하기 위해서는 먼저 DNS를 이해 해야 한다. 

### DNS 란 
우리가 크롬과 같은 브라우저를 통해 웹 페이지에 접속 할 때 사용하는 주소가 도메인 네입이다. 구글에 접속 한다고 가정한다면 우리는 웹 브라우저 주소창에 `google.com`을 입력 할 것이다. 이때 입력하는 `google.com` 이 도메인 네임이다. 

> 거의 모둔 브라우저가 도메인 네임만 입력하면 자동적으로 프로토콜과 구분자를 자동적으로 추가 하여 `https://google.com`과 같이 입력된다.  이때 `https` 는 응용 프로토콜을 지정하고 `://` 는 구분자이다. 그다음에 오는 `google.com` 이 도메인 네임이다. 

하지만 내 브라우저가 구글의 웹 서버에 접속 하기 위해서는 우리가 자동차 네비게이션을 사용하때 코엑스를 목적지로 설정하면 네비게이션이 알아서 코엣스의 주소인 `서울특별시 강남구 영동대로 513`로 변환하여 안내 해주는 것 처럼 도메인 네임에 매핑된 IP 주소를 알아야 한다. 

DNS는 우리에게 더 친숙한 도메인 네임을 컴퓨터가 이해 할 수 있는 32비트나 128 비트로 구성된 IP주소로 변환해 주는 인터넷의 코어 서비스 중 하나이다.

> IP주소는 버전 4(IPv4) 기준으로 32비트이고 약 40억개가 있다. 32비트를 8비트씩 4그룹으로 나누고 각 그룹을 10진수로 표기한다. 그룹간의 구분 dot(.)으로 구분한것이 우리가 아는 1.2.3.4 같은  IP 주소이다. 이렇게 구분한 것을 우리는 dot-decimal notation 이라고 한다.

> 여담으로 IP 의  여섯번째 버전(IPv6)는 주소가 128 비트로 구성되어 있다. IPv4와 같이 8비트로 나눌경우 16그룹으로  나누어지기 때문에 표기하기가 어렵다. 따라서 16비트씩 여덟 그룹으로 나누고 각각을 16비트를 16빈수로 표기한다. 각 그룹의 구분은 콘론(:)을 사용한다. 이러한 방식을 colon-hex notation 이라고 한다. 


기본적으로 도메인 네임과 IP주소는 $1:N$ 매핑이다. 네임서버의 정책에 따라 우리가 같은 도메인네임에 대한 IP주소를 요청하도라도 다른 IP 주소가 반환될 수 있다. 

### DDNS
기본적으로 도메인 네임과 IP주소를 $1:N$ 매핑이지만 우리는 서버를 여러대 하용하여 로드를 분산 시키거나 가용성을 위해 여러 서버를 두지 않을 것 이기 때문에 여기서는 $1:1$ 매핑으로 가정하고 설명을 진행한다. 

보통 우리가 ISP(KT나 SKT등 통신 서비스를 저공해 주는 업체)에 인터넷에 인터넷을 설치 하면 ISP에서는 인터넷을 연결 해준다. 이때 우리가 인터넷 접속을 위해 UTP 케이블을 단말(PC나 노트묵)에 연결 하게 되면 단말은 DHCP 프로토콜을 통해 IP를 할당 받게 된다. 

이 때 할당 받은 IP 주소는 우리가 사용하는 단말에 고정적으로 할당된 주소가 유동 IP를 할당 받게 된다. 단말을 재 시작하거나 UTP 케이블의 연결을 뺐다 다 시 연결 하였을 경우 단말은 DHCP를 통해 IP를 다시 할당 받게 되는데 이때 할당 받은 IP주소는 이전에 할당 받은 IP주소와 다를 수 있다. 

> DHCP서버는 IP 주소를 할달 할때 단말에 Lease 타임을 같이 알려 주는데 이는 해당 IP의 대여 시간이다. 보통 24시간이 설정된다. 단말은 IP를 할당 받은 이후 이 Lease 타임 안에 다시 IP를 요청하여 IP주소를 재 할당 받아야 한다. 이때 재할당 받은 주소는 이전주소와 같을 수도 있고 다를 수도 있다.

우리가 할당 받은 IP주소는 자주 변경되지 않는다고 하더라도 유동 IP이기 때문에 IP주소가 변결 될 때마다 DNS 서버에 변경된 IP주소를 업데이트해 주어야 한다. 여간 번거로운 일이 아닐 수 없다. 

이때 사용할 수 있는 방법이 DDNS 서비스이다. 

> DDNS를 사용하기 위해서는 자신이 이용하는 도메인의 네임서버(`NS`)가 DDNS를 지원 해야 한다. 


#### 동작원리
DDNS 서비스가 어떻게 동작 하는지 알이 위해서는 먼저 개략적인 DNS 서버의 동작 원리를 알아야 한다. 

우리가 브라우저를 통해 `google.com`에 접속한다고 생각해보자.

우리는 간단하게 크롬의 주소창에 `google.com` 을 입력 하였지만, 브라이저와 운영시스템(OS) 에서 `www.google.com`에 접속하기 위해 아주 많은 일들이 일어난다. 

아주 이러한 동작들을 **DNS관점에서** 아주 간단하게 설명하자면 아래와 같은 일들이 일어난다. 

1. 브라우저는 `www.google.com` 에 접속하기 위해 운영체제에게 `www.google.com`에 대한 IP 주소를 요청한다. 
2. 운영체제는 자신이 가지고 있는 DNS 캐시에 `www.google.com`에 대한 IP주소가 있는지 확인하고 있을 경우 브라우저에게 해당되는 IP주소를 반환한다. DNS 캐시에 해당 도메인에 대한 매핑 정보가 없을 경우 설정된 DNS 서버로 DNS 쿼리를 요청한다. (이 서버를 클라이언트측 DNS 서버라고 하자)
4. DNS 쿼리 요청을 받은 클라이언트측 DNS 서버는 자신의 DNS 캐시에 해당 도메인에 대한 매핑정보가 있는지 확인하고 매핑정보가 있을 경우 IP주소를 반환한다.  캐시에 매핑정보가 없는 경우 `google.com`의 네임서버(NS)에 매핑정보를 요청한다. 
6. `google.com` 네임서버는 `google.com` 도메인 이름에 대한 모든 설정 정보를 관리하고 있기 때문에 `www.google.com` 도메인에 대한 IP주소 정보를 반환한다. 
7. 네임서버로 부터 응답을 받은 클라이언트측 네임서버는 매핑정보를 자신의 **캐시**에 저장하고 클라이언트로 응답한다. 
8. 클라이언트측 DNS 서버로 부터 쿼리에 대한 응답을 받은 운영체제는 매핑정보를 로컬 캐시에 저장하고 브라우저에 IP주소를 반환한다. 
9. 브라이저는 해당 IP로 TCP 연결을 요청하고 정상적으로 연결 되었다면 HTTP나 HTTPS 프로토콜의 절차에 따라 윕페이지를 가져 온다. 

위 과정에서 우리가 중요하게 보아야 하는 관정이 캐싱 과정이다. 캐싱 과정이 없다면 클라이언트측 네임서버는 `google.com`에 대한 DNS 요청이 발생 할때마다 `google.com`의 네임서버에 DNS 쿼리를 수행 해야 하기 때문에 불필요한 트래픽이 발생하게 되어 네트워크 낭비를 물론 네임서버의 부하가 커지에 된다. 사람들이 많이 접속 하는 도메인에 대한 IP주소는 캐시에 있을 확률이 높으므로 DNS서버가 쿼리 요청 없이 직접 응답 함으로서 불필요한 트래픽의 낭비를 줄일 수 있을 뿐만 아니라 빠른 응답을 보장할 수 있다.

이러한 캐싱은 매우 좋은 기능이지만 `google.com`의 관리자가 `www.google.com`의 IP주소를 변경 하였을 경우를 생각해보자. `google.com`의 관리자는 변경된 IP주소로 트래픽이 오기를 기대 하지만 클라이언트측 DNS 서버에 캐싱된 매핑정보를 응답 하기 때문에 문제가 발생한다. 

이런 문제를 방지 하기 위해 DNS 레코드 마다 `TTL`(Time To Live)을 부여 하여 캐싱된 DNS 레코드가 얼마의 시간 동안 유효 한지를 알려 준다. DNS 서버에 캐싱된 정보는 레코드에 설정된 `TTL` 시간 동안만 유효 하고 그 이후에 는 유효하지 않기 때문에 캐시에서 삭제된다. 

아래는 `dig` 명령으로 `www.google.com`에 대한 DNS 정보를 토청 한 것이다. 

```bash
$ dig www.google.com
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> www.google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49873
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;www.google.com.			IN	A

;; ANSWER SECTION:
www.google.com.		218	IN	A	142.250.206.196

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Dec 14 12:48:38 UTC 2023
;; MSG SIZE  rcvd: 59
```

`ANSER SECTION` 에 보면 `www.google.com` 다음이 있는 `218` 이 TTL 값이다. `218`초 후에 해당 레코드는 유효 하지 않다는 의미이다. 

DDNS는 DNS레코드의 업데이트를 관리자가 수동으로 하는것이 아니라 DDNS 클라이언트의 요청에 의해 자동으로 업데이트 할 수 있도록 하고 해당 레코드에 매우 짧은 `TTL`을 부여 하여 (보통 1분) 레코드의 IP가 변경 되더라도 매우 빠른 시간 내에 변경정보가 전파 될 수 있게 한 것이다.  


#### DDNS A레코드 추가 하기

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
