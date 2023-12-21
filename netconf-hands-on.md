---
title: 오픈 소스 구현을 이용한 NETCONF Hands-On
link: /netconf-hans-on
description: 
status: publish
tags: [Linux, NETCONF, YANG, libnetconf2, sysrepo, netopeer2, libyang]
series: ['About NETCONF/YANG']
date: 2023-12-21
---

## 오픈 소스 구현을 이용한 NETCONF Hands-On

오픈소스를 이용하여 NETCONF 의 간단한 동작을 확인 해보자.

사용할 오픈소스 구현은 다음과 같다. 

* [libyang](https://github.com/CESNET/libyang): YANG 데이터 모델링 언어의 파서와 툴킷을 제공한다. sysrepo, libnetconf2, netopeer2에서 사용된다. 
* [sysrepo](https://github.com/sysrepo/sysrepo): YANG 으로 모델링된 데이터의 데이터 스토어를 제공한다.
* [libnetconf2](https://github.com/CESNET/libnetconf2): NETCONF 서버와 클라이언트에서 사용되는 라이브리를 제공한다.
* [netopeer2](https://github.com/CESNET/netopeer2): NETCONF 서버와 테스트용 클라이언트를 제공한다. 


### 설치 하기

설치에 시간이 걸리기 때문에 빠른 테스트를 위해 [도커 이미지](https://hub.docker.com/r/euikook/netconf)를 만들어 놓았다. 

시스템에 도커가 설치되어 있다면 별도의 설치 없이 테스트가 가능하다. 

빌드 방법을 알고 싶다면 [Dockerfile](https://github.com/euikook/netconf-docker/blob/master/Dockerfile)을 참조 하자.

> sysrepo와 netopeer2는 개발과정에는 필요 하지 않기 때문에 [테스트용](https://hub.docker.com/r/euikook/netconf) 이미지와[ 개발용](https://hub.docker.com/r/euikook/netconf-base) 이미지를 분리 하였다. 다음은 개발용 이미지 생성을 위한 [Dockefile](https://github.com/euikook/netconf-docker/blob/base/Dockerfile)이다. 


### 

테스트를 위한  `netconf` 도커 네트워크를 생성한다. 

```
docker network create netconf
```

### 서버 실행

NETCONF 서버 실행을 위해 
```
docker run --name netconf-server \
--rm \
--network netconf \
-p 830:830 \
-it \
euikook/netconf \
bash
```

Docker 쉘이 뜨면 아래 명령을 실행 하여 NETCONF 서버(`netopeer2-server`)를 실행한다. 

```
netopeer2-server -d -v2
```

`-d` 옵션은 Debug 모드로 실행한다. 데몬 모드로 실행 되지 않고 포그 그라운드에서 실행된다. 
`-v2` 옵션은 Logging Level을 Warning 뿐 아니라 일반 디버깅 메시지도 출력 하도록 한다.

> 서버의 로그 메시지를 보면 클라이언트의 접속, RPC 수신및 요청에 대한 응답 정보를 볼 수 있다. 

### 클라이언트 실행

```
docker run --name netconf-client \
--rm \
--network netconf \
-it \
euikook/netconf \
bash
```

Docker 쉘이 뜨면 아래 명령을 실행 하여 NETCONF 서버(`netopeer2-cli`)를 실행한다. 

`netopeer2-cli` 프롬프트(`>`)가 뜬다. 


### NETCONF 서버에 접속

`connect` 명령을 이용하여 `netconf-server`에 접속한다. 

```
connect --ssh --host netconf-server --login netconf
```

아래는 접속 예제다. 따라서 접속 해보자.
```
> connect --ssh --host netconf-server --login netconf
The authenticity of the host 'netconf-server' cannot be established.
ssh-rsa key fingerprint is a4:06:93:97:84:18:6b:56:15:d1:8f:0b:a2:61:75:4e:e0:cc:93:fd.
Are you sure you want to continue connecting (yes/no)? yes
netconf@netconf-server password:
```  
> 비밀전호는  `netconf` 다. 


`help` 명령을 입력 하면 가능한 명령 리스트를 볼 수 있다. 

### RPC 테스트

`get-config` 명령은 `<get-config>` RPC를 호출하여 설정 정보만을 가저 온다. 옵션으로 타킷 데이터 스토어를 지정 해 주어야 한다. 
```
> get-config --source running
```

아래는 `get-config` 예제다. 
```xml
> get-config --source running
DATA
<data xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
  <keystore xmlns="urn:ietf:params:xml:ns:yang:ietf-keystore">
    <asymmetric-keys>
      <asymmetric-key>
        <name>genkey</name>
        <algorithm>rsa2048</algorithm>
        <public-key>MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArWDnLGZ670b5boVK9/brTTGBpc26pLMWPyvOqC81ujYQ7Rgc48rytcrCsiIXa7X/0gY9Oajbq5Swf9mWk+eev8fwdV6P/lrYfUN2nTiMTfLhGq3DcgG+jWObIEiXEB6KIY37awKstUmsxddcA0PG8G5excMFdAfU22jGSRMIudfRhjgFjaQPfuHAYKTUR5O+GiZdn/C9RzJ9yQgxpp1A3XbNT1oiey87BfV3yz8pSK/EgsK48/oq7hTLDGS28asNdEmOqx7oBto16TsACcQTZSNpAlMZzHZAUCUOe3AETaDi/qGGW3JtY6reHqAO1VLOYK8H9pQin67b91VtP7qQNQIDAQAB</public-key>
      </asymmetric-key>
    </asymmetric-keys>
  </keystore>
  <netconf-server xmlns="urn:ietf:params:xml:ns:yang:ietf-netconf-server">
    <listen>
      <endpoint>
        <name>default-ssh</name>
        <ssh>
          <tcp-server-parameters>
            <local-address>0.0.0.0</local-address>
            <keepalives>
              <idle-time>1</idle-time>
              <max-probes>10</max-probes>
              <probe-interval>5</probe-interval>
            </keepalives>
          </tcp-server-parameters>
          <ssh-server-parameters>
            <server-identity>
              <host-key>
                <name>default-key</name>
                <public-key>
                  <keystore-reference>genkey</keystore-reference>
                </public-key>
              </host-key>
            </server-identity>
            <client-authentication>
              <supported-authentication-methods>
                <publickey/>
                <passsword/>
              </supported-authentication-methods>
            </client-authentication>
          </ssh-server-parameters>
        </ssh>
      </endpoint>
    </listen>
  </netconf-server>
</data>
```


`get` 명령은 `<get>` RPC 를 호출 하여 서버에서 설정정보와 운용상태 정보를 가저 온다. 
```
> get
```

```xml
> get
DATA
<data xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
  <keystore xmlns="urn:ietf:params:xml:ns:yang:ietf-keystore">
    <asymmetric-keys>
      <asymmetric-key>
        <name>genkey</name>
        <algorithm>rsa2048</algorithm>
        <public-key>MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArWDnLGZ670b5boVK9/brTTGBpc26pLMWPyvOqC81ujYQ7Rgc48rytcrCsiIXa7X/0gY9Oajbq5Swf9mWk+eev8fwdV6P/lrYfUN2nTiMTfLhGq3DcgG+jWObIEiXEB6KIY37awKstUmsxddcA0PG8G5excMFdAfU22jGSRMIudfRhjgFjaQPfuHAYKTUR5O+GiZdn/C9RzJ9yQgxpp1A3XbNT1oiey87BfV3yz8pSK/EgsK48/oq7hTLDGS28asNdEmOqx7oBto16TsACcQTZSNpAlMZzHZAUCUOe3AETaDi/qGGW3JtY6reHqAO1VLOYK8H9pQin67b91VtP7qQNQIDAQAB</public-key>
      </asymmetric-key>
    </asymmetric-keys>
  </keystore>
  <netconf-state xmlns="urn:ietf:params:xml:ns:yang:ietf-netconf-monitoring">
    <capabilities>
      <capability>urn:ietf:params:netconf:base:1.0</capability>
      <capability>urn:ietf:params:netconf:base:1.1</capability>
      <capability>urn:ietf:params:netconf:capability:writable-running:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:candidate:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:confirmed-commit:1.1</capability>
      <capability>urn:ietf:params:netconf:capability:rollback-on-error:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:validate:1.1</capability>
      <capability>urn:ietf:params:netconf:capability:startup:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:xpath:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:with-defaults:1.0?basic-mode=explicit&amp;also-supported=report-all,report-all-tagged,trim,explicit</capability>
      <capability>urn:ietf:params:netconf:capability:notification:1.0</capability>
      <capability>urn:ietf:params:netconf:capability:interleave:1.0</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-yang-metadata?module=ietf-yang-metadata&amp;revision=2016-08-05</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-inet-types?module=ietf-inet-types&amp;revision=2013-07-15</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-yang-types?module=ietf-yang-types&amp;revision=2013-07-15</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-netconf-acm?module=ietf-netconf-acm&amp;revision=2018-02-14</capability>
      <capability>urn:ietf:params:netconf:capability:yang-library:1.1?revision=2019-01-04&amp;content-id=1892760158</capability>
      <capability>urn:sysrepo:plugind?module=sysrepo-plugind&amp;revision=2022-08-26</capability>
      <capability>urn:ietf:params:xml:ns:netconf:base:1.0?module=ietf-netconf&amp;revision=2013-09-29&amp;features=writable-running,candidate,confirmed-commit,rollback-on-error,validate,startup,url,xpath</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-netconf-with-defaults?module=ietf-netconf-with-defaults&amp;revision=2011-06-01</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-netconf-notifications?module=ietf-netconf-notifications&amp;revision=2012-02-06</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-netconf-monitoring?module=ietf-netconf-monitoring&amp;revision=2010-10-04</capability>
      <capability>urn:ietf:params:xml:ns:netmod:notification?module=nc-notifications&amp;revision=2008-07-14</capability>
      <capability>urn:ietf:params:xml:ns:netconf:notification:1.0?module=notifications&amp;revision=2008-07-14</capability>
      <capability>urn:ietf:params:xml:ns:yang:ietf-x509-cert-to-name?module=ietf-x509-cert-to-name&amp;revision=2014-12-10</capability>
      <capability>urn:ietf:params:xml:ns:yang:iana-crypt-hash?module=iana-crypt-hash&amp;revision=2014-08-06</capability>
    </capabilities>
```

### 결론
오픈 소스 구현을 이용하여 NETCONF 서버와 클라이언트를 실행 하고 간단한 테스트를 진행 해 보았다. 다음은 간단한 YANG 모듈을 모델링하고 하고 생성된 YANG 모듈을 NETCONF 서버에 설치 하는 방법에 대하여 알아보도록 한다. 