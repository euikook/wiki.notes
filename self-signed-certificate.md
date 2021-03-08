---
title: Self Signed Certification
tags: [ssl, tls, self signed, nginx, apache]
draft: true
date: 2021-02-26 13:00:41 +0900
banner: https://source.unsplash.com/jKU2NneZAbI
aliases:
    - /gollum/self-signed-certificate
    - /gollum/self-signed-certificate.md
---

## SSL/TLS 인증서 발급 절차

1. 암호화 하고자 하는 도메인 결정
2. CSR 생성
3. CSR를 CA로 전송하여 인증서 발급 요청
4. 사이트의 정보와 공개키가 담긴 인증서를 인증기관의 비공개 키로 암호화 하여 발급

> Private CA를 사용하거나 생성한 경우 Private CA의 관리자나 생성한 CA 크를 통하여 인증서를 암호화

> Private CA을 사용하는 경우, 브라우저에서 경고 메시지를 제거하기 위해 Private CA의 공개키를 브라우저에 등록 해야 한다.


## Prerequsites

Test Domain Name `acme.com`


/etc/hosts

```
192.168.0.100 acme.com www.acme.com
```

### Create a root certification authority (CA)

> StartSSL같은  Public CA를 사용할 경우 생성 하지 
않아도 Private CA를 생성하지 않아도 된다. 


```
openssl genrsa -out ca.key 2048
```

```
openssl req -new -x509 -days 365 -key ca.key \
-subj "/C=KR/ST=Daejeon/L=Yuseong-gu/O=ACME Inc./CN=ACME Certificate Autority/OU=acme.com" \
-out ca.crt
```

### Create Private Key and CSR

먼저 개인키와 키 요청을 위한 CSR 를 생성한다. 

```
openssl req -newkey rsa:2048 -nodes -keyout cert.key \
-subj "/C=KR/ST=Daejeon/L=Yuseong-gu/O=ACME Inc./OU=Devops/CN=*.acme.com" \
-out cert.csr
```

### Create Self-Signed Certificate
```
openssl x509 -req -days 365 \
-CA ca.crt -CAkey ca.key -CAcreateserial \
-extfile <(printf "subjectAltName=DNS:acme.com,DNS:www..acme.com") \
-in cert.csr -out cert.crt
```


```
tree
```

```
.
├── ca.crt
├── ca.key
├── ca.srl
├── cert.crt
├── cert.csr
└── cert.key
```

Install `cert.crt` and `cert.key` to /etc/nginx/certs

```
mkdir -o /etc/nginx/certs
cp cert.crt cert.key /etc/nginx/certs
```

```
erver {
    listen 443 ssl;

    ssl_certificate        /etc/nginx/certs/cert.crt;
    ssl_certificate_key    /etc/nginx/certs/cert.key;
}

```

## Add a certification authority (CA) to the browser

### Google Chrome

#### Linux
Setting -> Advanced -> Security -> Manage Certificate -> Authorities -> Import

#### Windows



## Microsoft Windows
### Google Chrome
설정 -> 개인정보 및 보안 -> 보안 -> 인증서 관리 -> 신뢰할 수 있는 루트 인증 기관 -> 가져오기

### Microsoft Edge
설정 -> 개인정보, 검색 및 서비스 -> 보안 -> 인증서 관리 -> 신뢰할 수 있는 루트 인증 기관 -> 가저오기


설정 -> 업데이트 및 보안



```nginx
server {
    listen *:80 default_server;
    server_name *;

    server_tokens off;

    location /.well-known/ {
        root /var/www/certbot/;
    }
}
```

`/var/www/certbot`

```
certbot certonly --webroot -w /var/www/certbot -d www.example.com -d example.com -w 
```

## 공개키 암호화 방식 (Public-Key cryptography)

암호화와 복호화에 같은 키를 사용하는 비밀키 암호화 기법과 간리 암호화와 복호화에 사용하는 키가 서로 다른 암호화 방식을 의미한다. 


* 암호화된 통신을 원하는 두 단말 사이에 암호화를 대칭키를 전달하는 전달하는 용도로 사용된다.
* 전달하고자 하는 문서(파일 또는 정보)를 작성자가 직접 작성하였음과 해당 문서가 변조 되지 않음을 증명하는 용도로 사용된다.


암호화와 복호화에 사용되는 키다 서로 다르기 때문에 비대칭키 암호화라고도 한다. 

암호화의 방법은 다음과 같다. 

*A*와 *B*사이에 비밀 정보를 전달하고자 할 경우를 가정하자.

1. *B*는 문서를 암호화/복호화를 위한 공개키와 개인키를 만든다. 공개키는 암호화에 사용되고 개인키를 복호화에 사용된다. 
2. *A*는 *B*에게 정보를 전달하기 앞서 *B*가 생성한 공개키를 취득한다. 
3. *A*는 평문인 정보를 *B*의 공개키로 암호화 한다. 
4. *A*는 암호화 된 문서를 *B*에게 전달한다. 
5. *B*는 자신의 개안키로 정보를 복호화한다.


전자 서명 방식은 다음과 같다. 

*A*가 자신이 만든 문서의 출처가 자신음을 증명 하고자 한다. 

1. *A*는 문서의 서명을 위한 공개키와 개인키를 만든다. 개인키는 암호화에 사용되고 공개키는 복호화에 사용된다. 
2. *A*는 서명하고자 하는 문서를 개인키로 암호화 한다.
3. *A*는 서명된(암호화된)문서를 공개 하면서 자신의 만들었음을 공개 한다. 
4. *A*가 서명한 문서를 취득한 *B*는 *A*가 공개한 공개키로 해당 문서를 복호화 할 수 있다. 
5. *B*는 이를 통해 이 문서가 *A*가 생성 하였으며 변조 되지 않았음을 알 수 있다.


자 이제 공개키와 개인키로 암호화 하고 복호화 하는 방법을 알았다. 
그런데 공개키가 변조 되었다면? *C*가 자신의 공개키를 *A*의 공개키라고 속이고 배포 하였거나 *B*가 가지고 있던 *A*의 공개키를 자신의 공개키로 변경 하였을 경우 *B*는 *C*가 보낸 잘못 된 정보를 *A*가 보낸 정보라고 여기게 되는 문제가 발생할 수 있다. 

이제 *B*는 *A*가 배포한 공개키가 정말 *A*가 배포 하였는지에 대하여 검증 할 필요가 생겼다. 

이를 효육적으로 관리 하게 위해 만들어 진 것이 PKI(Public Key Infrastructure) 한글로 바꾸면 *공개키 기반구조*이다. 


> 공개 키 기반구조(public key infrastructure, PKI)는 디지털 인증의 생성, 관리, 배포, 사용, 저장, 파기와 공개 키 암호화의 관리에 쓰이는 일련의 역할, 정책, 하드웨어, 소프트웨어, 절차의 총칭으로 전자 상거래, 인터넷 뱅킹, 민감한 정보를 담은 이메일을 포함한 다양한 네트워크 활동에 있어 정보의 안전한 전송이 목적이다. 통신 주체를 식별하거나 오가는 정보를 검증함에 있어 단순한 암호를 넘어선 엄격한 확증이 필요한 경우에 중요한 역할을 한다. 암호학적으로는 공개된 키를 개인이나 집단을 대표하는 적절한 주체와 엮는 것이며 이는 인증 기관(Certificate authority, 이하 CA)에의 등록과 해당 기관에 의한 인증의 발행을 통해 성립된다. 이 엮음은 보증의 정도에 따라 완전 자동으로 성립되기도, 사람 손을 거쳐야만 성립되기도 한다. *[Wikipedia](https://ko.wikipedia.org/wiki/%EA%B3%B5%EA%B0%9C_%ED%82%A4_%EA%B8%B0%EB%B0%98_%EA%B5%AC%EC%A1%B0) 에서 발최*

* Public Key Infrastructure


위의 방식으로 문서의 암호화 / 복호화 및 변조 여부를 확인할 수 있다. 그러나 공개된 공개키가 *A*가 생성한 공개키가 아니라면 

인증기관이 필요한다. 