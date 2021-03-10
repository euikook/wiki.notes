---
title: 공개키 암하화 방식이란? (Waht is Public-Key cryptography)
tags: [ssl, tls, CA, Root CA, public key, private key, cryptography, 공개키, 공개키]
draft: false
date: 2020-03-10 11:00:41 +0900
banner: https://source.unsplash.com/jKU2NneZAbI
aliases:
    - /gollum/what-is-public-key-cryptography
    - /gollum/what-is-public-key-cryptography.md
---

## 공개키 암호화 방식 (Public-Key cryptography)

암호화와 복호화에 같은 키를 사용하는 비밀키 암호화 기법과 간리 암호화와 복호화에 사용하는 키가 서로 다른 암호화 방식을 의미한다. TLS/SSL 에 사용되는 RSA가  대표적인 공개키 암호화 방식의 대표적인 예이다.  

공개키로 암호화한 정보는 개인키로만 복호화 할 수 있고 개인키로 암호화 한 정보는 공개키로만 복호화 할 수 있다. 

암호화와 복호화에 사용되는 키다 서로 다르기 때문에 비대칭 키 암호화라고도 한다. 

공개키 암화화 방식의 대표적인 용도는 다음과 같다. 

* 암호화된 통신을 원하는 두 단말 사이에 암호화를 대칭키를 전달하는 전달하는 용도로 사용된다.
* 전달하고자 하는 문서(파일 또는 정보)를 작성자가 직접 작성하였음과 해당 문서가 변조 되지 않음을 증명하는 용도로 사용된다.


공개키 암호화 방식은 비밀키 암호화 방식(대칭키 암하화 방식)에 비하여 연산량이 훨신 많기 때문에 세션 전체를 공개키 암호화 방식으로 사용하는 것이 아니라 대부분 대칭키 암호화 방식에 사용되는 키를 교환하기 위한 용도로 사용된다. 

> 대칭키(비밀키) 암호화 방식의 경우 연산이 단순하고 반복적인 연산이 대부분이라 하드웨어로 구현하기도 용의하기 때문에 요즘 나오는 CPU들은 기복적으로 유명한 대칭키 암호화 방식에 대한 하드웨어 오프로딩 기능을 제공한다. 때문에 공개키 암호화 방식 보다 매우 빠르게 암호화 및 복호화를 할 수 있다. 


암호화의 방법은 다음과 같다. 

*A*와 *B*사이에 비밀 정보를 전달하고자 할 경우를 가정하자.

1. *B*는 문서를 암호화/복호화를 위한 공개키와 개인키를 만든다. 공개키는 암호화에 사용되고 개인키를 복호화에 사용된다. 
2. *A*는 *B*에게 정보를 전달하기 앞서 *B*가 생성한 공개키를 취득한다. 
3. *A*는 평문인 정보를 *B*의 공개키로 암호화 한다. 
4. *A*는 암호화 된 문서를 *B*에게 전달한다. 
5. *B*는 자신의 개안키로 정보를 복호화한다.

이 방법은 HTTPS에서 브라우저와 사용자 사이에 세션키(비밀키)를 공유 하기 위해 생성하는 키 교환 과정에서 활용된다. 


개인키로 암호화 한 정보를 공개키로 복화화 하는 반대의 경우도 생각 해 볼 수 있는데 공개된 공개키로 아무나 복호화 할 수 있기 때문에 아무 소용이 없을 것 같지만 개인키와 쌍인 공개키로만 복호화 할 수 있기 때문에 해당 정보의 출처를 인증하는데 사용할 수 있다. 이러한 방식을 전자 서명이라고 한다. 

전자 서명 방식은 다음과 같다. 

*A*가 자신이 만든 문서의 출처가 자신음을 증명 하고자 한다. 

1. *A*는 문서의 서명을 위한 공개키와 개인키를 만든다. 개인키는 암호화에 사용되고 공개키는 복호화에 사용된다. 
2. *A*는 서명하고자 하는 문서를 개인키로 암호화 한다.
3. *A*는 서명된(암호화된)문서를 공개 하면서 자신의 만들었음을 공개 한다. 
4. *A*가 서명한 문서를 취득한 *B*는 *A*가 공개한 공개키로 해당 문서를 복호화 할 수 있다. 
5. *B*는 이를 통해 이 문서가 *A*가 생성 하였으며 변조 되지 않았음을 알 수 있다.

이 방법은 우리가 흔히 알 고 있는 공인인증서와 TLS/SSL 인증서의 검증에 사용된다.


자 이제 공개키와 개인키로 암호화 하고 복호화 하는 방법을 알았다. 
그런데 공개키가 변조 되었다면? *C*가 자신의 공개키를 *A*의 공개키라고 속이고 배포 하였거나 *B*가 가지고 있던 *A*의 공개키를 자신의 공개키로 변경 하였을 경우 *B*는 *C*가 보낸 잘못 된 정보를 *A*가 보낸 정보라고 여기게 되는 문제가 발생할 수 있다. 

이제 *B*는 *A*가 배포한 공개키가 정말 *A*가 배포 하였는지에 대하여 검증 할 필요가 생겼다. 

이를 효육적으로 관리 하게 위해 만들어 진 것이 PKI(Public Key Infrastructure) 한글로 바꾸면 *공개키 기반구조*이다. 


* Public Key Infrastructure

> 공개키 기반구조(public key infrastructure, PKI)는 디지털 인증의 생성, 관리, 배포, 사용, 저장, 파기와 공개키 암호화의 관리에 쓰이는 일련의 역할, 정책, 하드웨어, 소프트웨어, 절차의 총칭으로 전자 상거래, 인터넷 뱅킹, 민감한 정보를 담은 이메일을 포함한 다양한 네트워크 활동에 있어 정보의 안전한 전송이 목적이다. 통신 주체를 식별하거나 오가는 정보를 검증함에 있어 단순한 암호를 넘어선 엄격한 확증이 필요한 경우에 중요한 역할을 한다. 암호학적으로는 공개된 키를 개인이나 집단을 대표하는 적절한 주체와 엮는 것이며 이는 인증 기관(Certificate authority, 이하 CA)에의 등록과 해당 기관에 의한 인증의 발행을 통해 성립된다. 이 엮음은 보증의 정도에 따라 완전 자동으로 성립되기도, 사람 손을 거쳐야만 성립되기도 한다. *[Wikipedia](https://ko.wikipedia.org/wiki/%EA%B3%B5%EA%B0%9C_%ED%82%A4_%EA%B8%B0%EB%B0%98_%EA%B5%AC%EC%A1%B0) 에서 발최*

앞에서 설명한 바와 같이 공개키를 검증 할 수 있는 방법이 필요하게 되었다. 

PKI의 정의에 따르면 **인증기관(CA, Certificate Authority)** 이 사용자의 공개키에 대한 (디지털)인증서(Certificate) 발급한다. 이 인증서는 인증서에 포함된 공개키와 정보(소속, 국가, 위치 등)가 틀림 없음을 증명해 준다.

CA는 공개키와 비밀키를 만든다. 공개키는 모든 사람에게 공개된다. 

*A*가 공개키와 비밀키를 만들었다. 공개키를 공개 하기전에 *CA*에게 자신의 공개키와 키에 대한 정보를 주면서 해당 공개키의 인증을 요청한다. *CA*는 요청을 받으면 *A*가 준 공개키와 정보들의 지문(SHA과 같은 방법으로 해시)을 만들어 지문을 자신의 비밀키로 암호화 하고 암하화된 지문 정보와 공개키를 합쳐 인증서를 생성한다.  

이제 ***A*가 받은 인증서는 *CA*의해 인증 되었다.**

*B*가 *A*의 인증서가 유효한지 판단 하는 방법은 다음과 같다. 앞서 설명한 바와 같이 *CA*는 공개키를 공개 하였고 그 공개키는 *B*도 가지고 있다. *B*는 *A*가 준 인증서를 받아 *CA*가 했던 방법과 같은 방법으로 만든 지문(해싱한 결과) 과 인증서에 포함되어 있던 *CA*의 개인키로 암호화된 지문 정보를 *CA*의 공개키로 복호화 한값을 비교 하여 두 지문 정보가 같으면 해당 인증서가 유효하다고 판단한고 같지 않으면 유효하지 않은 인증서로 판단한다. 

그렇다면 *CA의 공개키는 어떻게 검증 할 것인가?* 라는 의문이 생긴다. 

앞서 *A*의 인증서를 인증한 방법과 같은 방법으로 *CA*의 인증서를 인증 하면 될것 같은 생각이 든다. CA의 공개키를 인증해주는 CA를 *상위 CA*이라고 한다. 

***CA를 인증한 CA**의 공개키는 누가 인증하는가?* 이라는 자연 스러운 의문이 생긴다.

이러한 문제를 해결하기 위해 PKI에서는 최상위 인증기관인 *루트 인증기관(Root CA)* 을 정의 하였다. 이 *Root CA* 에서 *루트 인증서(Root Certificate)* 를 발행 하고 이 *루트 인증서*는 *중간 인증기관(Intermediate CA)* 의 인증서를 인증하는 데 사용된다. 

> 루트 인증서는 자신의 공개키를 인증해 줄 상위의 CA가 없기 때문에 자신이 직접 인증한(Self-Signed)인증서이다. 

> *Root CA*는 매우 강력한 보안으로 자신의 개인키를 관리하고 있기 때문에 안전하다고 간주하기로 약속하였다.

*Root CA*와 하나 또는 여러개의 *Intermediate CA*를 거쳐 최종 사용자의 공개키를 인증하는 일련의 과정을 인증서 체인 *Certificate Chain* 또는 *Chain of Trust* 이라고 한다. 

최종 사용자의 인증서에는 Root 인증서 부터 최종 사용자의 인증서를 인증한 CA의 인증서까지의 인증 정보가 모두 포함되어 있다. 