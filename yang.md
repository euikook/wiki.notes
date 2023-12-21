
---
title: YANG
link: /yang
description: 
draft: true
series: ['About NETCONF/YANG']
tags: [NETCONF, YANG]
date: 2023-12-20
---


## YANG

NETCONF의 데이터 모델링 언어다. NETCONF에서는 RPC와 Operation 만 정의 하였고 설정 데이터에 대해서는 정의 하지 않았다. IETF에서는 효과적으로 관리데이터와 운용 데이터를 모델링 하기 위해서 YANG이라는 언어를 정의 하였다. 

하지만 YANG은 매우 확장성 있는 데이터 모델링 언어로 당초 목적인 네트워크의 설정 데이터와 운용 데이터의 모델링 뿐 아니라 다른 분야 에서도 사용되고 있다. 



## NETCONF/YANG Open Source Implementations 

NETCONF 관련 프로젝트를 진행 한적이 있다. NETCONF/YANG의 오픈 소스 구현에 대해 알아보자. 

### libyang
YANG 파일에 대한 파싱, 트리 생성 XML에 대한 검증 등을 담당
### sysrepo
데이터 저장소

### libnetconf
NETCONF 

### netopeer
NETCONF 서버와  클라이언트구현