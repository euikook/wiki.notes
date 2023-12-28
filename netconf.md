---
title: NETCONF - Network Configuration Protocol
link: /netconf
description: 
status: publish
tags: [NETCONF, YANG]
series: ['About NETCONF/YANG']
date: 2023-12-18
---


## 개요

[IETF](ietf.org) [NETCONF Working Group](https://tools.ietf.org/wg/netconf/)에서 발표한 네트워크 관리 프로토콜이다. 
 
기존에 사용되던 SNMP를 대체 하기 위해 개발 되었으며 네트워크 오퍼레이터의 요구 사항을 반영하여 개발되었다. 최신 개정판은 RFC 6241 이다. 


### 출연 배경

이전에 정의된 SNMP가 있었다. SNMP는 버전 3 까지 정의 되었다. 
SNMPv1 은 SNMP의 첫 번째 표준이다. 사실 IETF에서는 체계적인 관리 체계를 개발 하기 원했고 SNMPv1 은 더 나은 관리 프로토콜을 개발할기 까지 과도적으로 사용되는 임시 프로토콜로서 개발 되었다. 하지만 SNMPv1은 구현의 간편함으로 인해 널리 사용되었고 IETF에서는 새로운 프로토콜을 구현하는 대신 대신 SNMP를 발전 시키려고 하였다. 버전 1 에서 문제가 되었던 인증 관련 기능등의 추가 기능이 정의된 SNMPv2를 발표 하였으나 SNMPv1이 널리 사용되게 되었던 원인인 구현의 간편함이 없어졌기 때문에 사용자의 외면을 받았다. 이에 IETF에서는 SNMPv2에서 문제가 되었던 복잡한 인증 관련 기능을 제거한 SNMPV2c 를 발표 하였다. 이후 구현된 SNMPv3에서는 이전 버전에서 문제가 되었던 보안성이 강화되어 데이터의 기밀성, 무결성, 인증관련 기능들이 추가 되었다. 

이러한 네트워크 관리 프로토콜(SNMP)의 발전에도 불구하고 메이저 밴더들은 SNMP를 모니터링이나 간단한 설정 기능을 위해  제한적으로 사용하였고 전체 네트워크 관리를 위해 사용되지 않았다. IETF에서는 이러한 이유에 대해 고찰 하였고 [RFC 3535](https://www.rfc-editor.org/rfc/rfc3535)에서 그 내용을 볼 수 있다. 
 

그이유는 SNMP는 간단한 모니터링에만 사용되었고 설정등은 원격 쉘을 통한 스크립팅으로 처리 되는게 대부분이었다. 

간단한(단일 파라미터 대한) 설정은 상관 매우 잘 처리 할 수 있지만 파라미터를 순차적으로 설정 해야만 하는(Context를 가지는) 동작은 SNMP로 구현 하기가 쉽지 않다. 그리고 네트워크 운영자는 장비의 설정을 텍스트 형식의 파일로 관리하는 것을 선호 한다는 것이다. 새 장비가 설치 되거나 설정이 변경 되엇을 경우 설정을 하나 하나 실행하기 보다는 설정 파일을 변경 한 다음 설정 파일을 장비에 업로드 하여 한번에 적용 하는 경우가 많다. 이렇게 텍스트로 설정을 관리 하면 git로 버젼 관리가 가능해 잔다는 장점이 있다. 


앞서 언급된 문제점을 해결하기 위하여 IETF의 [NETCONF Working Group](https://tools.ietf.org/wg/netconf/)에서 SNMP를 대체할 수 있는 네트워크 관리 프로토콜의 개발을 시작 하였다. 2006년에 RFC 4741으로 처음 발표되었고 최신 개정판은 2011년에 발표된 RFC 6241 다. 



### 프로토콜 구성

NETCONF 프로토콜은 아래와 같이  4 계층으로 구성된다. 

* 컨텐츠 계층(Content Layer)은 설정(Configuration), 운용상태(Operation State), 알림(Notification) 데이터로 구성된다. XML 기반이다. 
* 오퍼레이션 계층(Operation Layer)은  설정 데이터를 수정하기 위한 방법을 정의 한다. 
* 메시지 계층(Message Layer)은  RPC및 Notification 메시지를 인코인 하는 방법을 정의 한다. 
* 전송 계층(Transport Layer)은 클라이언트와 서버간에 메시지 전송을 위한 보안 채널을 정의 한다. 

 
#### Content
설정 정보나 운영 상태 정보등을 정의 한다. 설정 정보나 상태 정보는 XML로 표현되며 이를 모델링 하기 위해 데이터 모델링 언어인 YANG을 정의 하였다. 

> JSON으로도 인코딩 할 수 있다.



#### Operation
설정 데이터를 열람 하거나 수정, 삭제, 장금등 데이터(Content)에 대한 동작을 정의 한다.

아래와 같은 동작이 있다. 

* get
* get-config
* set-config
* copy-config
* delete-config
* lock
* unlock
* close-session
* kill-session



#### Message

RPC(`<rpc>`) 와 RPC(`<rpc-reply>`)에 대한 응답, 알림(`<notification`) 등을 정의 한다. 


### Transport

클라이언트와 서버간에 메시지 전송을 위한 보안 채넣을 제공한다. TLS 와 SSH중 하나를 사용할 수 있다. 보통 SSH를 사용한다. 

> NETCONF는 텍스트 기반 프로토콜이기 때문에 netconf용 계정에 일반 SSH 클라이언트로 접속하여 직접 RPC를 보내도 NETCONF 서버는 올바게 응답한다.


```xml
 <rpc xmlns="urn:ietf:params:xml:ns:netconf:base:1.0"><get-config><source><running/></source></get-config></rpc>
```