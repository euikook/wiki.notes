---
title: How to setup auto renew certbot certificate
tags: [ssl, tls, Let's Encrypt, lencr, certbot, webroot, nginx, apache]
draft: false
date: 2021-03-08 10:00:41 +0900
banner: https://source.unsplash.com/P6vDUuzL90w
aliases:
    - /gollum/how-to-setup-auto-renew-certbot-certificate
    - /gollum/how-to-setup-auto-renew-certbot-certificate.md
---

이 글에서는 [`certbot`](https://certbot.eff.org/)을 통해 발급받은 [Let's Encrypt](https://lencr.org) 인증서를 `Webroot` 플러그인을 이용해 자동 갱신 방법에 대히여 알아본다. 


## Prerequsites

Webroot 디렉터리를 생성한다. 

이미 설정되어 있는 `root` 디렉터리(`/usr/share/nginx/html`  등)에 `.well-known`  디렉터리를 생성해도 되지만 관리의 편의를 위하여 별도의 디렉터리를 생성한다.  디렉터리 위치는 `/var/www/certbot`로 한다. 

```
sudo mkdir -p /var/www/certbot
```
 

## Nginx 설정

기본 설정 파일을 열어 `server`섹션에  다음 내용을 추가 한다.

```nginx
location /.well-known/ {
    root /var/www/certbot/;
}
```

<!--more-->

다음과 같이 수정 되었다. 

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

nginx 서버를 재시작 한다. 

```
sudo systemctl restart nginx.service
```

## Apache 설정

아파지 서버를 사용중이라면 아래와 같이 설정한다. 

```apache
Alias /.well-known "/var/www/certbot"

<Directory "/var/www/certbot/">
    AllowOverride None
    Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
    Require method GET POST OPTIONS
</Directory>
```

## 인증서 발급

```
certbot certonly --webroot -w /var/www/certbot -d www.example.com -d example.com 
```


## 인증서 갱신

`renew` 명령을 이용해 인증서를 갱신한다. 

```
certbot renew
```

결과는 아직 갱신 기한이 아니라고 나온다. 

```
Processing /etc/letsencrypt/renewal/www.example.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert not yet due for renewal

```


## Cron을 이용한 인증서 자동갱신


```
 0  4 *  * * certbot renew
```

> 새벽 4시 마다 인증서를 자동 갱신한다. 

Let's Encrypt의 인증서는 90일동안 유효하고 만료일 30일 이전에 갱신하는 것을 권장한다. `certbot renew` 명령을 수행하면 만료일이 30일 이내일 인증서만을 갱신하기 때문에 `renew`명령을 메일 수행해도 된다. 

만료일을 무시하고 인증서를 갱신하고 싶다면  `--force-renew` 옵션과 `--cert-name` 옵션을 사용한다.

```
certbot renew --force-renew --cert-name example.com
```