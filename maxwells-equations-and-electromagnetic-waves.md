---
title: 맥스웰 방정식으로 부터 전자기파의 유도 과정
link: /posts/maxwells-equations-and-electromagnetic-waves
description: 
status: publish
tags: [Maxwell's Equations, 맥스웰 방정식, Electromagnetic Wave, 전자기파,  Electrician, 전기기사, ]
date: 2024-01-25 16:53:29 +0900
lastmod: 2024-01-25 16:53:29 +0900
banner: https://source.unsplash.com/JTn9zj71M4c
---

맥스웰 방정식의 4개의 연립 미분 방정식을 통해 전자기파를 예언 하였던 유도 과정을 알아 보자. 

## 멕스웰 방정식

* 전기장에 대한 가우스법칙(전기장 발산)
$$
\boldsymbol{\nabla} \boldsymbol{\cdot} \mathbf{E} = \frac{\rho}{\varepsilon_0} \tag{1}
$$
* 자기장에 대한 가우스 법칙(자기장 발산)
$$
\boldsymbol{\nabla} \boldsymbol{\cdot} \mathbf{B} = 0 \tag{2}
$$
* 페러데이 전자 유도(전기장의 회전)
$$
\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t} \tag{3}
$$

* 앙페르-맥스웰법칙(자기장의 회전)
$$
\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{B} = \mu_0\mathbf{J} + \varepsilon_0\mu_0 \frac{\partial\mathbf{E}}{\partial t} \tag{4}
$$


## 전자기파 유도

자유 공간에서 전하 밀도 $\rho$ 와 전도 전류 밀도 $\mathbf{J}$ 가 $0$ 이므로 멕스웰의 방정식 $(1)$ 과 $(4)$는 다음과 같이 쓸 수 있다. 

$$
\boldsymbol{\nabla} \boldsymbol{\cdot} \mathbf{E} = 0 \tag{1}
$$

$$
\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{B} = \varepsilon_0\mu_0 \frac{\partial\mathbf{E}}{\partial t} \tag{4}
$$

(4) 식의 우항에 있는  $\mathbf{E}$를 소거하기 위해 (4) 식의 양변에 회전 연산을 취하면 다음과 같이 쓸 수 있다. 

$$
\boldsymbol{\nabla} \boldsymbol{\times} (\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{B}) = \boldsymbol{\nabla} \boldsymbol{\times} (\varepsilon_0\mu_0 \frac{\partial\mathbf{E}}{\partial t})
$$

좌항은 백터 3중곱의 연산에 의해 
$$
\boldsymbol{\nabla} \boldsymbol{\times} (\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{B})  = \boldsymbol{\nabla}(\boldsymbol{\nabla} \cdot \mathbf{B}) - (\boldsymbol{\nabla} \cdot \boldsymbol{\nabla}) \mathbf{B}
$$
가 되고  식 (2)의해 $\boldsymbol{\nabla} \cdot \mathbf{B} = 0$ 이므로 다음과 같이 정리 된다. 

$$
\boldsymbol{\nabla}(\boldsymbol{\nabla} \cdot \mathbf{B}) - (\boldsymbol{\nabla} \cdot \boldsymbol{\nabla}) \mathbf{B}
 = -\boldsymbol{\nabla}^2  \mathbf{B}
$$

우항은 우항의 $\boldsymbol{\nabla} \boldsymbol{\times}\mathbf{E}$를  $-\frac{\partial \mathbf{B}}{\partial t}$로 치환하면 

$$
\varepsilon_0\mu_0 \frac{\partial}{\partial t}(\boldsymbol{\nabla} \boldsymbol{\times}\mathbf{E}) = 
\varepsilon_0\mu_0 \frac{\partial}{\partial t}(-\frac{\partial \mathbf{B}}{\partial t})  = - \varepsilon_0\mu_0 \frac{\partial^2\mathbf{B}}{\partial t^2} 
$$

좌변과 우변을 정리하면  다음과 같이 정리 되고 

$$
-\boldsymbol{\nabla}^2\mathbf{B}  = - \varepsilon_0\mu_0 \frac{\partial^2\mathbf{B}}{\partial t^2}
$$
$-$를 곱하여  소거하면 

$$
\boldsymbol{\nabla}^2\mathbf{B}  = \varepsilon_0\mu_0 \frac{\partial^2\mathbf{B}}{\partial t^2} \tag{5}
$$
가 된다. 

(3) 식의 우항에 있는  $\mathbf{B}$를 소거하기 위해 (3) 식의 양변에 회전 연산을 취하면 다음과 같이 쓸 수 있다. 

$$
\boldsymbol{\nabla} \boldsymbol{\times} (\boldsymbol{\nabla} \boldsymbol{\times} \mathbf{E}) = \boldsymbol{\nabla} \boldsymbol{\times} (-\frac{\partial\mathbf{B}}{\partial t})
$$

앞서 (4) 번 식과 같은 방법으로 정리하면 좌항은  다음과 같이 정리된다. 

$$
 \boldsymbol{\nabla}^2 \mathbf{E}
$$

우항은 다음과 같이 정리 된다. 

$$
\boldsymbol{\nabla} \boldsymbol{\times} (-\frac{\partial\mathbf{B}}{\partial t}) = 
\frac{\partial}{\partial t}(\boldsymbol{\nabla} \boldsymbol{\times}\mathbf{B}) = 
-\frac{\partial}{\partial t}(\varepsilon_0\mu_0 \frac{\partial \mathbf{E}}{\partial t})  = - \varepsilon_0\mu_0 \frac{\partial^2\mathbf{E}}{\partial t^2}
$$

우항과 좌항을 같이 정리 하면 

$$
-\boldsymbol{\nabla}^2\mathbf{E}  = - \varepsilon_0\mu_0 \frac{\partial^2\mathbf{E}}{\partial t^2}
$$
$-$를 곱하여  소거하면 

$$
\boldsymbol{\nabla}^2\mathbf{E}  = \varepsilon_0\mu_0 \frac{\partial^2\mathbf{E}}{\partial t^2}  \tag{6}
$$
가 된다. 

식 (5) 와 식(6)은 아래와 같은 식 (7)의 파동방정식을 만족한다. 

$$
\boldsymbol{\nabla}^2\mathbf{\mathbf{\psi}}  = \frac{1}{v_2}\frac{\partial^2\mathbf{\mathbf{\psi}}}{\partial t^2} \tag{7}
$$

파동방정식을 만족하는 대상은 파동으로 존재 함으로 전기장과 자기장은 파동으로 존재 한다고 할 수 있으며 식(3) 과 식 (4)의 해 시변 자기장에 의해 전기장이 형성되고 이렇게 형성된 시변 전기장에 의해 또다시 시변 자기장이 형성되고 무한이 반복되어 파동의 형태로 퍼저 나가는 것을 알 수 있다. 

이때 식 (7) 우항의 $v$ 는 파동의 속도를 나타낸다. 식(5) 와 식(6) 에서 파동의 속도 $v$를  유도하면 다음과 같다.

$$
\frac{1}{v^2} = \varepsilon_0\mu_0
$$

양변에 역수를 취하면

$$
v^2 = \frac{1}{\varepsilon_0\mu_0}
$$

양변에 제곱근을 취하면 다음과 같이 풀 수 있다. 

$$
v = \frac{1}{\sqrt{\varepsilon_0\mu_0}} = 2.99 \times 10^8 \  \mathrm{m}/\mathrm{s}
$$

이를 통해 전자기파의 속도가 빛의 속도와 같음을 알 수 있다. 이를 통해 빛 이 전자기파의 일종임을 유추 할 수 있다. 