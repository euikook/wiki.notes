---
title: Windows 환경에서 사설 인증 기관 인증서(Private CA Certificate) 설치 하기 
draft: false
tags: [CA, Private, Certificate, SSL, TLS]
date: 2021-03-23 13:47:01 +0900
banner: https://source.unsplash.com/ZNOxwCEj5mw
---

직접 서명한 인증서를 가지고 서비스를 제공 하는 경우 인증서를 인증한 인증 기관의 정보가 브라우저 또는 운영체제에 없기 때문에 
경고 메시지를 보게 된다. 경고 메시지를 없에려면 인증서를 인증한 사설 인증기관의 인증서를 브라우저 또는 운영체제에 설치 하여야 한다. 이 글에서는 Windows환경에서 사설 인증 기관 인증서를 설치 하는 벙법에 대하여 알아본다. 

Windows는 운영체제 수준에서 CA 인증서를 관리 하기 때문에 운영체제의 CA 인증서 저장소에 인증서를 등록하면 특별한 경우를 제외 하면 거의 모든 프로그램에서 해당 인증서에 접근 할 수 있다. 


## MMC(Microsoft Management Console)를 이용하여 설치 하기


`mmc`를 입력 하고 <kbd>Enter</kbd> 키를 누른다. 

`시작` 에서 `실행`을 검색하여 실행한다. 

![시작 > 실행](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-000.png)


<!--more-->

`mmc` 를 입력 하여 실행한다. 

![Run MMC](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-001.png)


`파일` > `스냅인 추가/제거`를 선택한다.

![스냅인 추가/제어](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-002.png)

사용가능한 스냅인 목록에서 인증서를 선택하고 `추가(A) >` 버튼을 클릭한다.

![인증서 추가](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-003.png)

스냅인이 관리할 인증서 대상을 선택한다. 잘모르겠다면 그냥 `마침` 버튼을 클릭하여 스냅인을 추가한다. 

![관리 주체 설정](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-004.png)

인증서 스냅인이 추가 되었다. `확인` 버튼을 클릭하여 완료 한다. 

![스냅인 추가 완료](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-005.png)

우측 트리 메뉴에서 `인증서 - 현재사용자` >  `신뢰할 수 있는 루트 인증 기관` 을 차례대로 확장 한다. 

![인증서 > 신뢰할 수 있는 루트 인증 기관](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-006.png)

`인증서 - 현재사용자` >  `신뢰할 수 있는 루트 인증 기관` > `인증서`에 마우스 커서를 위치 시키고 마우스 오른쪽 버튼을 클릭하여 메뉴가 표시되게 한다. `모든 작업` > `가저오기`를 선택한다. 

![모든 작업 > 가저오기](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-007.png)

### 인증서 가저오기 마법사 {id=cert-import-wizard}
인증서 가져오기 마법사가 시작 된다. 다음을 클릭하여 인증서 가져오기를 시작한다.

![인증서 가져오기 마법사 시작](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-008.png)

`찾아보기` 버튼을 클릭하여 가져올 인증서 파일을 선택한 후 `다음` 버튼을 클릭한다. 

![가져올 인증서 파일 선택](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-009.png)

### {id=import-ca-cert}

인증서 저장소 선택 메뉴가 나온다. `모든 인증서를 다음 저장소에 저장(P)`를 선택한 후 `찾아보기` 버튼을 클릭 한다. 

![모든 인증서를 다음 저장소에 저장(P)](/images/inst-ca-cert/win-dc/win-inst-ca-dc-004.png)

 인증서 자장소 선택 착에서 `신뢰할 수 있는 루트 인증 기관`을 선택 한 후 `확인` 버튼을 클릭한다. 

![신뢰할 수 있는 루트 인증 기관](/images/inst-ca-cert/win-dc/win-inst-ca-dc-005.png)

`다음(N)` 버튼을 눌러 다음으로 넘어간다.

![인증서 저장소 선택](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-010.png)

입력한 정보를 확인 하는 창이 나온다. 입력한 정보가 맞다면 `마침` 버튼을 클릭한다.

![확인 후 마침](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-011.png)

인증서 출처를 확인 할 수 없다는 경고 메시지가 뜬다. `예(Y)` 버튼을 눌러 인증서를 가저온다. 

![설치 확인 / 예(Y)](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-012.png)

인증서 가저오기 가 완료 되었다. `확인` 버튼을 클릭한다. 

![가저오기 완료](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-013.png)


인증서 리스트에서 가저온 인증서를 더블클릭 하여 인증서 정보를 확인해보자.

![인증서 정보 확인](/images/inst-ca-cert/win-mmc/win-inst-ca-mmc-014.png)


## 인증서파일을 통해 설치 하기 

CA 인증서의 확장자에 따라서 인증서를 직접 설치 할 수도 있다. 

탐색기에서 인증서 파일의 유형이 `보안 인증서`로 나온다면 인증서파일을 통해 설치 할 수 있다. 

인증서를 더블 클릭하거나 인증서 파일에 마우스 커서를 위치 시키고 마우스 오른쪽 버튼을 클릭 하여 `열기(O)` 메뉴를 선택한다. 

![탐색기 - 인증서 파일](/images/inst-ca-cert/win-dc/win-inst-ca-dc-000.png)

![인증서 속성 - 일반](/images/inst-ca-cert/win-dc/win-inst-ca-dc-001.png)

인증서 상태가 

> 이 CA 루트 인장서가 신뢰할 수 있는 루트 인증 기관 저장소에 있지 않으므로 신뢰할 수 없습니다.

라고 나온다. 

![인증서 속성 - 인증 경로](/images/inst-ca-cert/win-dc/win-inst-ca-dc-002.png)


### 인증서 설치
`인증서 설치(I)` 버튼을 클릭 하여 `인증서 가저오기 마법사`를 실행한다. 

![인증서 설치](/images/inst-ca-cert/win-dc/win-inst-ca-dc-001.png)

또는 인증서 파일에 마우스 커서를 두고 마우스 오른쪽 버튼을 클릭하여 메뉴가 나오면 `인증서 설치(I)` 메뉴를 선택 하여 `인증서 가져오기 마법사`를 실행한다.

![인증서 더블클릭](/images/inst-ca-cert/win-dc/win-inst-ca-dc-001-1.png)



인증서 가져오기 마법사가 실행 되면 [MMC를 이용한 설치 방법을 참고하여 인증서를 설치 한다.](#import-ca-cert)



## Google Chrome

크롬에서도 인증서 가저오기 마법사를 실행 할 수 있다. 


메뉴 > 설정 메뉴을 선택한다. 

![메뉴 > 설정](/images/inst-ca-cert/win-chrome/win-inst-ca-chrome-000.png)

우측 메뉴에서 `개인정보 및 보안` 메뉴를  선택한다. 그 후 좌측 메뉴에서 `개인정보 및 보안 > 보안` 메뉴를 선택한다. 

![메뉴 > 설정](/images/inst-ca-cert/win-chrome/win-inst-ca-chrome-002.png)

화면을 밑으로 내려 `인증서 관리` 메뉴을 클릭한다.

![메뉴 > 설정](/images/inst-ca-cert/win-chrome/win-inst-ca-chrome-003.png)

인증서 관리 창이 나타난다. `가져오기(I)` 버튼을 클릭하여 가져오기 마법사를 실행한다. 
![메뉴 > 설정](/images/inst-ca-cert/win-chrome/win-inst-ca-chrome-004.png)

인증서 가져오기 마법사가 실행된다. [MMC를 이용한 설치 방법을 참고하여 인증서를 설치 한다.](#import-ca-cert)



## 인증서 설치 검증

인증서 설치 후 인증서 파일을 연어 정보를 확인하자. 


![인증서 속성 - 일반](/images/inst-ca-cert/win-dc/win-inst-ca-dc-010.png)


`인증서 경로` 탭을 선택 하여 인증서 경로 정보를 확인해보자. 



![인증서 속성 - 인증 경로](/images/inst-ca-cert/win-dc/win-inst-ca-dc-011.png)

인증서 상태에  `올바른 인증서입니다.` 라는 메시지가 나오면 인증서가 올바르게 설치 된 것이다.