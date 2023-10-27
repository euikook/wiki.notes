--- 
 title: 2 전력계법
 link: /two-wattmeter-method 
 categories: ["전기기사", 'Electrician'] 
 description:
 draft: false
 series: ['계측장비를 이용한 유효전력 측정방법']
 tags: [2전력계법, 전기기사, 전기기사실기, 2-wattmeter, wattmeter] 
 date: 2023-10-22 21:10:41 +0900 
 lastmod: 2023-10-22 21:37:41 +0900 
 banner: https://source.unsplash.com/EcdWBhV81q4 
--- 
  

## 2 전력계법

이전 글에서 단상부하의 경우 유효전력을 측정하기 위한 [3 전압계법](/posts/three-voltmeter-method)과 [3 전류계법](/posts/three-ammeter-method)에 대하여 알아보았다. 이번에는 평형 삼상회로  부하에서 2개의 유효전력계를 이용하여 3상 유효 전력을 측정하는 방법에 대해 알아본다.

> 유효전력계는 전압계, 전류계, 역률계로 구성되어 있으므로 전압계, 전류계, 역률계가 각각 2개씩 있으면 유효전력을 측정할 수 있다.

> 세상의 전압과 전류의 크기가 같고 그 위상이 서로 $120^\circ$ 차이날 때 평형삼상 이라고 한다. 평형 삼상회로에서 3상의 전압과 전류의 합은 $0$이다. 

### 유효전력
3상에서 유효전력을 구하기 위해서는 선간전압과 선전류의 곱에$\sqrt{3}$배를 해주고 역률을 곱해 주어야 한다.

$$
P = \sqrt{3}VI\cos{\theta}
$$ 

> 3상 부하의 전력은 각 상에서 소비하는 전력의 합이다. 한상의 소비전력은 $EI\cos{\theta}$ 이므로 3상 부하의 소비전력은 $3EI\cos{\theta}$가 된다.
> $Y$ 결선일 경우 선간전압이 상전압의 $\sqrt{3}$배이고 $\Delta$ 결선일 경우 선전류가 상전류의 $\sqrt{3}$배이기 때문에 소비 전력을 선간전압과 선간 전류로 나타내면 $\sqrt{3}VI\cos{\theta}$ 가 된다. 


### 결선도 
3상의 각 상을 $A$, $B$, $C$라고 하자. 

![Two Wattmeter Method Circuit Diagram](https://raw.githubusercontent.com/euikook/stock/main/two-wattmeter-method-circuit.svg "2 전력계법 결선도")

$W_1$ 은 전압 $V_{ab}$, 전류 $I_a$와 이 둘 사이의 위상차 $\cos{\phi_1}$를 측정한다.

$$
W_1= V_{ab} \times I_a \times \cos{\phi_1}
$$

$W_2$ 은 전압 $V_{cb}$, 전류 $I_c$와 이 둘 사이의 위상차 $\cos{\phi_2}$를 측정한다.

$$
W_2= V_{cb} \times I_c \times \cos{\phi_2}
$$

삼상 평형이므로 삼상의 선간전압과 선전류는 그 크기가 같고 각 상의 위상이 $120^\circ$차 이기 때문에 그 크기만을 나타내는 $V_{ab}$와 $V_{cb}$는 $V$로  $I_1$과 $I_2$는 $I$로 바꾸더라고 등식이 성립한다.

$$
V = V_{ab} = V_{cb}
$$

$$
I = I_a = I_c
$$

3상 평형일 경우 위와 같은 등식이 성립함으로 $W_1$ 과 $W_2$를 다음과 같이 고쳐 쓸 수 있다. 

$$
W_1= V \times I \times \cos{\phi_1}
$$

$$
W_2= V \times I \times \cos{\phi_2}
$$

### 페이저도

앞서 알아본 바와 같이 $W_1$과  $W_2$이 측정하는 값은 다음과 같다. 
* $W_1$ 은 전압 $V_{ab}$, 전류 $I_a$와 이 둘 사이의 위상차 $\cos{\phi_1}$를 측정한다.
* $W_2$ 은 전압 $V_{cb}$, 전류 $I_c$와 이 둘 사이의 위상차 $\cos{\phi_2}$를 측정한다.

측정값을 페이저도로 나타내면 다음과 같다. 

![Two Wattmeter Method Phase Diagram](https://raw.githubusercontent.com/euikook/stock/main/two-wattmeter-method-phase.svg "2 전력계법 페이저도")

페이저 도에서 보면,

$\phi_1$은 $V_{ab}$ 와 $I_a$ 사이의 위상차이고 $V_a$ 와 $V_{ab}$ 사이의 위상차에 $V_a$ 와 $I_a$ 사이의 위상차의 더한 값이다. 

$\phi_2$은 $V_{cb}$ 와 $I_c$ 사이의 위상차이고 $V_c$ 와 $V_{cb}$ 사이의 위상차에서 $V_c$ 와 $I_c$ 사이의 위상차를 뺀 값이다. 

$Y$ 결선의 경우 상전압과 선간 전압은 $30^\circ$의 위상차가 있으므로 다음과 같이 나태낼 수 있다. 

$$
\phi_1 = 30 + \theta 
$$


$$
\phi_2 = 30 - \theta 
$$


$W_1$ 과 $W_2$의  $\phi_1$과 $\phi_2$를 앞에서 구한 값으로 치환 하면 다음과 같이 고쳐 쓸 수 있다. 


$$
W_1= V \times I \times \cos{\phi_1} = V \times I \times \cos{(30 + \theta)}
$$

$$
W_2= V \times I \times \cos{\phi_2} = V \times I \times \cos{(30 - \theta)}
$$

위 식은 삼각함수 덧셈정리를 이용하면 다음과 같이 나타낼 수 있다. 

>삼각함수 덧셈정리 $\cos{(\alpha \pm \beta)} = \cos{\alpha} \cos{\beta} \mp \sin{\alpha} \sin{\beta}$


$$
W_1= V \times I \times (\cos{30}\cos{\theta} - \sin{30}\sin{\theta}) = VI\cos{30}\cos{\theta} - VI\sin{30}\sin{\theta}
$$

$$
W_2= V \times I \times (\cos{30}\cos{\theta} + \sin{30}\sin{\theta}) = VI\cos{30}\cos{\theta} + VI\sin{30}\sin{\theta}
$$


### 우효전력, 무효전력, 피상전력 그리도 역률
$W_1$ 과 $W_2$를 더해보자. 
$$
W_1 + W_2 = 2VI\cos{30}\cos{\theta} = 2 VI \frac{\sqrt{3}}{2}\cos{\theta} = \sqrt{3}VI\cos{\theta}
$$

따라서 유효전력 $P$는 다음과 같이 나타낼 수 있다. 

$$
P = W_1 + W_2
$$


이번에는 $W_1$에서 $W_2$를 빼보자 

$$
W_1 - W_2 = 2VI\sin{30}\sin{\theta} = 2 VI \frac{1}{2}\cos{\theta} = VI\cos{\theta}
$$

위의 최종 값에 $\sqrt{3}$ 만 곱해주면 무효전력 $P_r$을 유도할 수 있다. 

$$
P_r = \sqrt{3}(W_1 - W_2)
$$

이제 우리는 유도한 유효전력과 무효전력을 통해 피상전력 $P_a$와 역률 $\cos{\theta}$를 유도할 수 있다. 
 
$$
 P_a =  \sqrt{P^2 + P_r^2} = 2\sqrt{W_1^2 + W_2^2 - W_1W_2}
$$
 
$$
\cos{\theta} = \frac{P}{P_a} = \frac{W_1 + W_2}{2\sqrt{W_1^2 + W_2^2 - W_1W_2}}
$$


### 결론 

2 전력계법을 통해 우리는 유효젼럭과 무효전력을 유도할 수 있고 이를 통해 피상전력과 역률을 유도할 수 있다는 것을 알았다. 


$$
P = W_1 + W_2
$$

$$
P_r = \sqrt{3}(W_1 - W_2)
$$
 
$$
P_a =  2\sqrt{W_1^2 + W_2^2 - W_1W_2}
$$
 
$$
\cos{\theta} = \frac{W_1 + W_2}{2\sqrt{W_1^2 + W_2^2 - W_1W_2}}
$$