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

