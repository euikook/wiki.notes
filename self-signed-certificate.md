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


Test Domain Name `acme.com`


/etc/hosts

```
192.168.0.100 acme.com www.acme.com
```

### Generate RSA key
```
openssl genrsa -out ca.key 2048
```

### Create a Certificate Authority root
```
openssl req -new -x509 -days 365 -key ca.key \
-subj "/C=KR/ST=Daejeon/L=Yuseong-gu/O=ACME Inc./CN=ACME Certificate Autority/OU=acme.com" \
-out ca.crt
```

### Create Certificate Request
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