---
title: 3 전압계법 
link: /three-voltmeter-method
categories: ["전기기사", 'Electrician']
description: 
status: publish
tags: [voltmeter, 3-voltmeter, 3전압계법, 전기기사, 전기기사실기]
date: 2023-08-21
lastmod: 2023-08-21 09:37:41 +0900
banner: https://source.unsplash.com/Oxl_KBNqxGA
---

## 개요
직류(DC) 회로에서 전력을 구하려면 부하전압(부하에 인가되는 전압)과 부하전류(부하에 흐르는 전류)의 곱으로 계산할 수 있지만  교류(AC) 회로에서 부하전압과 부하전류간 위상차가 존재하기 때문에 전원측에서 공급하는 전력과 실제 부하에서 소비되는 전력과 크기가 다르다. 교류 회로에서는 전원측에서 공급되는 전력을 피상전력($P_a$)이라고 하고 실제 부하에서 소비되는 전력을 유효전력($P$)이라고 한다. 피상전력으로부터 유효전력을 계산하기위해 역률($\cos{\theta}$)을 곱해주어야 한다. 

$$
 P = VI\cos{\theta}
$$

> 역률은 부하전압과 부하전류의 위상차를 코사인 값으로 나타낸 것이다. 역률은 피상전력에 대한 유효전력의 비로 나타낼 수 있다. 

$$\cos{\theta} = \frac{P}{P_a}$$

 앞서 설명한 바와 같이 유효전력을 측정 하기 위해서는 부하에 인가되는 전압, 전류 그리고 역률을 알아야 한다. 
전압계 3개를 이용하여 유효전력을 측정하는 방법을 알아보자. 

## 3 전압계법

아래와 같은 교류회로가 있다고 가정하자.  전원($V_{in}$) 과 부하($Z_L$) 사이에 하나의 직렬 저항과 3개의 전압계가 있다.  $V_1$은 입력전압, $V_2$는 부하와 직렬로 연결된 저항 $R$에서의 전압강하, $V_3$는 부하에 인가되는 전압을 측정한다. 
![Three Voltmeter Method Circuit Diagram](https://raw.githubusercontent.com/euikook/stock/main/three-voltmeter-method-circuit.svg)


### 부하전압 ($V$)
부하에 인가되는 전압은 저항 다음단에서 부하와 병렬로 전압계를 연결하고 전압계의 지시값을 읽으면 된다.  ( 전류를 측정하기 위해 부하와 전원 사이에 직렬 저항을 추가 하였기 때문에 공급전압과 부하전압 사이에서 $V_2$ 만큼의 전압차가 발생한다. )

### 저항기에서의 전압강하($I$)
전원측의 공급 전압을 측정 했으니 이제 부하에 흐르는 전류를 구해보자.  저항에 흐르는 전류를 구하기 위해서는 저항 의 크기와  저항에서 발생하는 전압 강하를 측정해야 한다. 저항의 크기와 저항에서의 전압 강하를 알면 다음 식을 통해 전류를 구할 수 있다.  

$$
I = \frac{V_2}{R}
$$

 저항과 전압계를 병렬로 연결하고 전압계의 지시값($V_2$)을 읽는다.

 
> 저항은 부하와 직렬로 연결되어 있고 직렬로 회로에서는 전류가 일정 하기 때문에 저항에 흐르는 전류와 부하에 흐르는 전류는 같다.


### 공급전압
전원측에서 공급되는 전압($V_1$)을 측정해보자. 다음 그림과 같이 전압계 저항기 앞단에 전원과 병렬로 연결하고 전압계에 지시값을 읽으면 전원 측에서 공급되는 전압을 알수 있다. 


### 역률 ($\cos{\theta}$)

이제 부하에 인가되 전압 $V_3$ 와 부하에 흐르는 전류 ($I$ = $\frac{V_2}{R})$를 알았으니 역률 $\cos{\theta}$를 알면 부하에서 소비되는 전력 $P$를 구할 수 있다. 앞서 측정한 공급전압($V_1$),   저항에서의 전압강하($V_2$),  부하전압($V_3$)을 가지고 역률을 구해보자. 

저항 $R$은 순저항 부하이기 때문에 $R$에  인가되는 전압 $\hat{V_2}$는 회로에 흐르는 전류($\hat{I}$)와 위상이 같다. 

$V_2$를 기준으로 페이저도를 그려보자. 

부하를 지상 부하라고 가정한다면 $\hat{V_3}$는 전류($\hat{I}$)보다 위상이 빠르기 때문에 다음과 같이 페이저도를 그릴 수 있다. $\hat{V_2}$와 $\hat{V_3}$위상차를 $\phi$ 라고 하자. 

직류회로에서 모든 전압의 합은 0 이므로 $\hat{V_1}$ 을 다음과 같이 표현할 수 있다. 

$$
\hat{V_1} = \hat{V_2} + \hat{V_3}
$$

다음과 같은 페이저도를 그릴 수 있다. 

![Three Voltmeter Method Circuit Diagram](https://raw.githubusercontent.com/euikook/stock/main/three-voltmeter-method-phase.svg)


페이저도를 통해  $\hat{V_3}$와 $\hat{I}$ 사이의 역률각 $\theta$는 다음과 같음을 알 수 있다. 

$$
\theta = 180 - \phi
$$

$\phi$를 구하면 역률각 $\theta$를 찾을 수 있다. 

rrr우리는 삼각형을 이루는 세 변의 길이를 알고 있으므로 코사인 법칙을 이용하여  $\phi$ 를 구할 수있다. 

> 코사인 법칙을 통해 삼각형에서 두 변의 길이와 그 사잇각으로 부터 제 3변의 길이 구하거나 삼각형 세변의 길이를 알고 있을 경우 세 각을 크기를 알 수 있다. 

$$
V_1^2 = V_2^2 + V_3^2 - 2V_2V_3\cos{\phi}
$$

$\cos{\phi}$ 에 대하여 식을 정리하면 다음과 같다. 

$$
\cos{\phi} = -\frac{V_1^2-V_2^2 - V_3^2 }{2V_2V_3}
$$

앞서 그린 페이저도를 보자 부하에 인가되는 전압($V_3$) 와 부하에 흐르는 전류($I$)의 위상차 $\theta$는 다음과 같이 나타낼 수 있다.

$$
\theta = 180 - \phi
$$

코사인의 특성을 이용하면 $\cos{(180 - x)} = -\cos{(x)}$ 이므로  $\cos{\phi}= - \cos{\theta}$ 가 된다.  앞의 식의  $\cos{\phi}$ 를  $-\cos{\theta}$ 로 치환하여 정리하면 역률을 $\cos{\theta}$ 를 다음과 같이 정리할 수 있다.

$$
\cos{\theta} = \frac{V_1^2-V_2^2 - V_3^2 }{2V_2V_3}
$$

### 유효전력

앞에서 우리는 유효전럭을 구하기 위한 3가지 값을 측정 또는 계산 하였다. 

부하에 인가되는 전압

$$
V_3
$$

부하에 흐르는 전류

$$
\frac{V_2}{R}
$$

역률
$$
\frac{V_1^2-V_2^2 - V_3^2 }{2V_2V_3}
$$


위 세가지 값을 곱하면 유효전력을 구할 수 있다. 

$$
P = V_3 \times \frac{V_2}{R} \times \frac{V_1^2-V_2^2 - V_3^2 }{2V_2V_3} = \frac{1}{2R} \times (V_1^2-V_2^2 - V_3^2)
$$

##  결론

3전압계법을 통해 부하에서 소비되는 전력을 구하는 공식은 

$$
P = \frac{1}{2R} \times (V_1^2-V_2^2 - V_3^2)
$$

이다.