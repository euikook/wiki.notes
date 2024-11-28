---
title: YANG - Data Modeling Language
link: /yang
description: 
draft: false
series: ['About NETCONF/YANG']
tags: [NETCONF, YANG]
date: 2023-12-20
toc: true
---


## YANG: Data Modeling Language

## 개요
IETF NETCONF Working Group 에서 네트워크 관리 프로토콜인 NECONF의 데이터 모델링을 위해 개발한 데이터 모델링 언어다. NETCONF 프로토콜([RFC 6241](https://datatracker.ietf.org/doc/html/rfc6241)은 표준에서 정의한 4 계층 중 Operation, Message, Transport 계층에 대해 정의 하였지만 최상위 계층인 Content 계층의 내용에 대해서는 정의하지 않았다. 

> SNMP에서 MIB를 정의 하기 위해 SMI를 정의 하였듯이 NETCONF에서 관리 데이터를 정의 하기 위해 데이터 모델링을 위한 언어인 YANG을 정의 하였다. 

 YANG은 매우 확장성 있는 데이터 모델링 언어로 당초 목적인 네트워크의 설정 데이터와 운용 데이터의 모델링 뿐 아니라 다른 분야 에서도 사용되고 있다. 

## 데이터 구조
데이터 구조는 계층적이며 트리 구조를 가진다. 트리를 구성하는 각 노드는 이름을 가지며 스스로 특정 값을 가지거나 하위 노드는 가진다. YANG은 각 노드와 이러한 노드간의 관계를  대해 명확하고 간결하고 정의 한다. 

YANG 의 데이터 모델은 모듈(Module) 과 하위모듈(Submodule)로 구성된다. 모듈은 다른 외부 모듈에서 정의를 가져올수(import) 있으면 하위 모듈은 정의를 포함 할 수 있다. 계층 구조는 확장(agument) 할 수 있으며 다른 모듈에서 정의된 계층 구조에 노드를 추가할 수 있다. 
> 예를 들어 ietf-ip 모듈의 ipv4 타입에는 dscp 값을 설정 할 수 없지만 내부 적으로   QoS나 서비스구분을 위해 DSCP 필드의 설정이 필요하다면  DSCP 노드를 추가하여 확장할 수 있다. 

```yang
augment "/if:interfaces/if:interface/ip:ipv4" {
  description "augments for QoS";  
  leaf qos-marking {    
    type inet:dscp;    
    default 0;    
    description "0 represents best effort'";  
   }
}
```
이러한 확장 기능은 조건부로 특정 노드의 값이 조건에 일치할 때만 적용 할수도 있다.

YANG 데이터 모델은 데이터 계층 구조에 특정 노드가 존재 하는지의 여부나 그 노드의 값에  근거하여 특정 노드의 존재 여부나 노드의 값을 제한하여 노드의 데이터가 반드시 지켜야 하는 제약 조건(constraints)을 정의할 수 있다. 

이러한 제약조건(constraints)이용하여 데이터를 정교하게 모델링 한다면 의존성 있는 설정의  누락에 의한 설정 오류를 디바이스에 내리기 전에 검증할 수 있다. 

> 예를 들어 Interface가 L3 모드인 경우에만 IP 주소를 설정 할 수 있도록 하는 제약 조건을 생각해 볼 수 있다. 

### 데이터 모델링

#### `leaf`
정수, 문자열 같은 단순한 데이터를 가질 수 있다. 반드시 특정 형식을 가지는 하나의 값을 가져야하며 하위 노드를 가질 수 없다.  
#### `leaf-list`
특정타입을 가지는 연속적인  값이다. 
#### `container`
하위 트리에서 관련노드들을 그룹화 하는데 이용된다.
#### `list`
`list`에는 리스트 엔드리의 시퀀스를 정의한다. `container` 와 같은 각 엔트리는 `key leaf` 를 가지며 `key leaf`의 값에 의해  고유하게 식별된다. 

### 설정 및 상태 데이터
YANG에서는 설정(Configuration) 과 상태(Operation state) 데이터로 구분된다. 이는 NETCONF를 정의할 때 논의 되었던 주요 요구사항중 하나다. 
YANG에서는 `config` 문을 통해 상태 데이터를 구분한다.
 아래 예제를 보자 `interface` 노드는 `name`이 `key`인 리스트다.  `interface` 노드는 `config` 값이 `true` 이므로 설정 가능한 노드다. 
 `speed` 리프는 열거형이고 10, 100, auto 중 선택가능하다. 명시적인 `config` 문은 없지만 부모 노드로 부터 상속받으므로 설정가능한 노드다.  `observed-speed` 는 `config` 문이 `false`이므로 운용상태를 나타내는 노드다. `speed`가 `auto`로 설정 되어 있을 때 자동 협상(auto negotiation)을 통해 결정된 속도가 반영될 것이다.  
```yang
list interface {
  key "name";       
  config true;       
  leaf name {         
    type string;      
  }       
  leaf speed {       
    type enumeration {           
      enum 10m;         
      enum 100m;         
      enum auto;        
    }       
  }      
  leaf observed-speed {         
    type uint32;         
    config false;       
  }     
}
```

정리하자면 설정데이터와 상태 데이터의 구분은 `config`문에 의해 결정되며 명시적으로 지정되지 않았을 경우 부모 노드의 설정값이 상속된다.

### 데이터 타입

#### Built-In Data Types
다른 언어들과 비슥하게 YANG에서도 사전정의된 데이터 타입을 제공한다. 해당목록은 아래와 같다.

| Type | Descriptions | 
| --- | --- |
| binary | Any binary data |
| bits | A set of bits or flags |
| boolean | "true" or "false" |
| decimal64 | 64-bit signed decimal number |
| empty | A leaf that does not have any value |
| enumeration | One of an enumerated set of strings |
| indentifyref | A reference to an abstract identity |
| instance-identifier | A reference to a data tree node |
| int8 | 8-bit signed integer |
| int16 | 16-bit signed integer |
| int32 | 32-bit signed integer |
| int64 | 64-bit signed integer |
| leafref | A reference to a leaf instance |
| string | A character string |
| uint8 | 8-bit unsigned integer |
| uint16 | 16-bit unsigned integer |
| uint32 | 32-bit unsigned integer |
| uint64 | 64-bit unsigned integer |
| union | Choice of member types |

#### Drived Types(typedef)
YANG은 기본 데이터 타입에서 파생된 데이터 타입을 정의 할 수 있다.  파생된 데이터 타입을 `typedef` 문을 통해 정의된다. 기본 데이터 타입을 사전정의된 내장 데이터 타입뿐 아니라 파생데이터 타입을 수도 있다. 

아래 예제는  `uint8` 데이터 타입에서 파생된 `percent` 타입을 정의하는 예제다. `range` 문을 통해  0에서 100 사이의 값만을 가질수 있는 제약사항이 적용된  `uint8`  타입이다.

```yang
typedef percent {
  type uint8 {
    range "0 .. 100";
  }
}
leaf completed {
  type percent;
}
```

다음에는 앞으로 사용할 예제 YANG 모듈을 모델링하고 YANG 파일로 표현해 보도록 한다. 

## References
1. [RFC 7950 - The YANG 1.1 Data Modeling Language
](https://datatracker.ietf.org/doc/html/rfc7950#section-4.2.4)