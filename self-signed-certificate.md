---
title: Self Signed Certification
tags: [ssl, tls, self signed, nginx, apache]
draft: true
date: 2021-03-10 11:00:41 +0900
banner: https://source.unsplash.com/jKU2NneZAbI
---

## SSL/TLS 인증서 발급 절차

1. 암호화 하고자 하는 도메인 이름 결정
2. CSR 생성
3. CSR를 CA로 전송하여 인증서 발급 요청
4. 사이트의 정보와 공개키가 담긴 인증서를 인증기관의 비공개 키로 암호화 하여 발급

> Private CA를 사용하거나 생성한 경우 Private CA의 관리자나 생성한 CA 크를 통하여 인증서를 암호화

> Private CA을 사용하는 경우, 브라우저에서 경고 메시지를 제거하기 위해 Private CA의 공개키를 브라우저에 등록 해야 한다.


> PKI 즉 공개기 기반 시스템에서 CSR (Certificate Singing Request)은 *Digital Identity*를 생성하기 위해 신청자가 PKI의 등록 기관에게 보내는 메시지이다. 일반적으로 인증서를 발급해야 하는 공개키, 도메인과 같은 식별정보와 무결성 호보(디지털 서명)가 포함된다. CSR의 가장 일반적인 형식은 PKCS #10 이다. 


아래는 CSR에 필요한 일반적인 정보이다. 입력 하여야 하는 `DN`이 복수개라면 해당 `DN`을 선호하는 순서대로 나열하면 된다. 

| DN | Information | Description | Example |
|---|---|---|---|
| CN | Common Name | FQDN | *.example.com |
| O | Organization Name | 조직의 이름, 일반적으로 회사 또는 법인의 이름 | ACME Corp. |
| OU | Organization Unit | 내부 조직의 부서 / 부서의 이름 | DevOps |
| L | Locality | 소재지의 시, 도등의 이름 | Seoul |
| ST | State | 주, 지역 등의 이름 | Seoul |
| C | Country | 국가 이름 | Korea | 
| EMAIL | Email Address | 인증서 관리자 또는 해당 부서의 연락처 |  |


## Prerequsites

Test Domain Name `acme.com`


/etc/hosts

```
192.168.0.100 acme.com www.acme.com
```

### Create a root certification authority (CA)

> StartSSL같은  인증된 인증기관(CA)을 사용할 경우 생성 하지 
않아도 사설 인증 기관의 인증서를 생성하지 않아도 된다. 


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


다음은 예제 CSR 파일이다.  `-----BEGIN CERTIFICATE REQUEST-----` 으로 파일이 시작된다. 


```
-----BEGIN CERTIFICATE REQUEST-----
MIICszCCAZsCAQAwbjELMAkGA1UEBhMCS1IxEDAOBgNVBAgMB0RhZWplb24xEzAR
BgNVBAcMCll1c2VvbmctZ3UxEjAQBgNVBAoMCUFDTUUgSW5jLjEPMA0GA1UECwwG
RGV2b3BzMRMwEQYDVQQDDAoqLmFjbWUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAuQ3nm95Gy1FtHm+msl3vtMXiD4uZm53EbtRoX7/TSCPTvFvP
n+vNc4oqlYTzmw3ToV6qB5wL9UR0Tv40JRAs7Vc9YGBY7pvRbWNfYQZ6pKEc/ETy
mcMvwWPnR49AGOOtdPTB9ATHHmcVRvHxDDFzQ4wGbmspN6ajoz6l9+skaPQmHlvw
OnFmMcnSMI8wRdr8Crkn9ysc8G/SBahQFGJ09YLD84DoeJxf00IlPMQMOKr/rIeH
XRI9+0K9RIiKuzJ8Q9M5kh4a2aK0CeaMzOq4DEuQddG1CZYMGgQudMQlvJdLYGJl
uoK664j2kpq8gmbpbe/SnCOzh41gaucW9AuSWQIDAQABoAAwDQYJKoZIhvcNAQEL
BQADggEBAKD5Hmvfblp6cGhWRdL+NHz5LMyH2uTMEmWrePxLA1frPJ6ken167XQG
PBfeGtX1ZD4aojeiVpfGaBi7qKZeTrGRdXBFMsVQZsnOGi2C54jk9VdWU+Cj+7kV
Zh0kP/B/p+H0NYKGIAS9xgBwbsnQ5yk0kqaBCp1gAVP5q++zDkWd0U364TEVkQ1G
I5ydg3uK6j0pstAbXR1d26QDFvgTe3u+6OZ9uouq0u9r9kydFLJoz+7r2x3e1qvo
X06HV4zKIT3T5PuL1amZLUrhUzYBgspFP0Hlmyyg42o154GT03geibh3XcAm5scb
oWuyKbwjEfCEyaUFTSCvtLILgizaQUU=
-----END CERTIFICATE REQUEST-----
```


```
openssl asn1parse -i -in cert.csr
```


### Create Self-Signed Certificate
```
openssl x509 -req -days 365 \
-CA ca.crt -CAkey ca.key -CAcreateserial \
-extfile <(printf "subjectAltName=DNS:acme.com,DNS:www.acme.com") \
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

## 브라우저(운영체제)에 사설 인증기관(Private CA)의 인증서 등록하기

### Linux

#### Google Chrome
Setting -> Advanced -> Security -> Manage Certificate -> Authorities -> Import

#### Mozilla Firefox


### Microsoft Windows 10
#### Google Chrome
설정 -> 개인정보 및 보안 -> 보안 -> 인증서 관리 -> 신뢰할 수 있는 루트 인증 기관 -> 가져오기

#### Microsoft Edge
설정 -> 개인정보, 검색 및 서비스 -> 보안 -> 인증서 관리 -> 신뢰할 수 있는 루트 인증 기관 -> 가저오기

