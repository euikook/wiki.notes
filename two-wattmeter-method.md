--- 
 title: 2 전력계법
 link: /two-wattmeter-method 
 categories: ["전기기사", 'Electrician'] 
 description:
 draft: true
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

>  $Y$ 결선일 경우 전압이 상전압에 비해  $\sqrt{3}$배이고  $\Delta$ 결선일 경우 선전류가 상전류에 비해  $\sqrt{3}$배이기 때문이다. 

3상 부하에 다음과 같이 전력계를 결선한다. 

$W_1$ 은 전압 $V_{12}$, 전류 $I_1$와 이 둘 사이의 위상차 $\cos{\phi}$를 측정한다.

$$
W_1= V_{12} \times I_1 \times \cos{\phi_1}
$$

$W_2$ 은 전압 $V_{23}$, 전류 $I_2$와 이 둘 사이의 위상차 $\cos{\phi}$를 측정한다.

$$
W_2= V_{23} \times I_2 \times \cos{\phi_2}
$$

삼상 평형이므로 삼상의 선간전압과 선전류는 그 크기가 같고 위상이 $120^\circ$  차를 가짐으로 그 크기는 $V$와  $I$로 나타낼 수 있다. 

$$
V = V_1 = V_2 = V_3
$$

$$
I = I_1 = I_2 = I_3
$$

$$
W_1= V \times I \times \cos{\phi_1}
$$

$$
W_2= V \times I \times \cos{\phi_2}
$$

$$
\phi_1 = 30 - \theta 
$$

$$
\phi_2 = 30 + \theta 
$$

>삼각함수 덧셈공식
$$
\cos{(\alpha \pm \beta)} = \cos{\alpha} \cos{\beta} \mp \sin{\alpha} \ sin{\beta}
$$

$$
P = W_1 + W_2
$$

$$
P_r = \sqrt{3}(W_1 - W_2)
$$
 
$$
 P_a =  \sqrt{P^2 + P_r^2} = 2\sqrt{W_1^2 + W_2^2 - W_1W_2}
$$
 
$$
\cos{\theta} = \frac{P}{P_a} = \frac{W_1 + W_2}{2\sqrt{W_1^2 + W_2^2 - W_1W_2}}
$$



### $\Delta$ 결선

### $Y$ 결선
