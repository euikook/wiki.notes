--- 
 title: 3 전류계법 - 단상 전력을 측정하는 방법
 link: /three-ammeter-method 
 categories: ['Electrician'] 
 description:  
 series: ['계측장비를 이용한 유효전력 측정방법']
 tags: [ammeter, 3-ammeter, 3전류계계법, 전기기사, 전기기사실기] 
 date: 2023-10-15 09:37:41 +0900 
 lastmod: 2023-10-15 09:37:41 +0900 
 banner: /images/banners/ammeter.jpg
 katex: true
--- 
  
 ## 개요 
 이전 글인 [3전압계법](/posts/three-voltmeter-method)을 다룬 글에서 이미 설명 했듯이 교류(AC) 회로에서 부하전압과 부하전류간 위상차가 존재하기 때문에 전원측에서 공급하는 전력과 실제 부하에서 소비되는 전력과 크기가 다르다. 교류 회로에서는 전원측에서 공급되는 전력을 피상전력($P_a$)이라고 하고 실제 부하에서 소비되는 전력을 유효전력($P$)이라고 한다. 피상전력으로부터 유효전력을 계산하기위해 역률($\cos{\theta}$)을 곱해주어야 한다.  자세한 내용은 [3전압계법 의 개요](/posts/three-voltmeter-method/#개요)를 참고하자. 
  
 본문에서는 전류계 3개를 이용하여 유효전력을 측정하는 방법을 알아본다.

## 들어가기 앞서
3전류계법을 시작하기 앞서 결론을 먼저 설명 하자면 역률을 유도하는 과정이 전압 $V$를 전류 $I$ 로 치환하면 될 정도로 3 전압계법과 거의 같다.
  
## 3전전류계법
 
 아래와 같은 교류회로가 있다고 가정하자.  전원($V_{in}$) 과 부하($Z_L$) 사이에 하나의 병렬 저항과 3개의 전류계가 있다.  $I_1$은 전원측에서 측정한 전류, $I_2$는 부하와 병렬로 연결된 저항 $R$에 흐로는 전류, $I_3$는 부하에 흐르는 전류를 측정한다.  

 ![Three Voltmeter Method Circuit Diagram](https://raw.githubusercontent.com/euikook/stock/main/three-ammeter-method-circuit.svg) 
  

 ### 공급전류 
 전원측에서 공급되는 전류($I_1$)을 측정해보자. 다음 그림과 같이 저항기 앞단에 전원과 직렬로 연결하고 전류계의 지시값을 읽으면 전원 측에서 공급되는 진류를 알 수 있다.  

 ### 부하전류 ($V$) 
 부하에 흐르는 전류는 저항 다음단에서 부하와 직렬로 전류계를 연결하고 전류계의 지시값을 읽으면 된다. 
  
 ### 저항에 흐르는 전류($V$) 
 부하에 흐르는 전류를 측정해보자.
 저항에 흐르는 전류를 구하기 측정하기 위해서는 부하와 병렬로 연결된 저항 $R$과 직렬로 전류계를 연결하고 전류계의 지시값을 읽으면 된다. 병렬회로에서는 전압이 같으므로 저항 $R$에 인가되는 전압을 계산하면 부하에 인가되는 전압을 유도할 수 있다. 저항에 인가되는 전압은 다음 식을 통해 
  
 $$ 
 V = I \times R 
 $$ 
  
$I$ 와 $R$의 곱임을 알 수 있다. 
  
 > 저항은 부하와 병렬로 연결되어 있고 병렬 회로에서는 전압이 일정 하기 때문에 저항에 인가되는 전압과 부하에 인가되는 전압은 그 크기와 위상이 같다.
  
  
 ### 역률 ($\cos{\theta}$) 
  
 부하에 인가되 전압($V = I \times R $) 와 부하에 흐르는 전류 ($I_3$)를 알았으니 역률 $\cos{\theta}$를 알면 부하에서 소비되는 전력 $P$를 구할 수 있다. 앞서 측정한 공급전류($I_1$), 저항에서의 흐르는 전류($I_2$), 부하에 흐르는 전류($I_3$)을 가지고 역률을 유도해 보자.  
  
  
 아래와 같은 조건을 기억하면서 페이저도를 그려보자.  
  
 * 부하 $Z_L$를 지상 부하라고 가정한다.  
 * 부하에 흐르는 전류 $\hat{I_3}$ 는 저항에 흐르는 전류 $\hat{I_2}$ 보다 지상이다.  $\hat{I_2}$와 $\hat{I_3}$위상차를 $\phi$ 라고 하자. 
 * 키르히호프의 전류 법칙(KCL)에 의해 회로내 임이의 지점에서 들어오는 전류의 합과 나가는 전류의 합은 같으므로 $\hat{I_1}$ 를 다음과 같이 표현할 수 있다.  
  
 $$ 
 \hat{I_1} = \hat{I_2} + \hat{I_3} 
 $$ 

 * 저항 $R$은 순저항 부하이기 때문에 $R$에 흐르는 전류 $\hat{I_2}$는 저항 $R$에 인가되는 전압과 위상이 같다. 
 * 부하 $Z_L$은 저항 $R$과 병렬로 연결되어 있으므로 부하 $Z_L$에 인가되는 전압은 저항 $R$에 인가되는 전압과 크기 및 위상이 같다.
 * 따라서 부하 $Z_L$에 인가되는 전압($\hat{V}$)은 전류 $\hat{I_2}$와 위상이 같다. 
  
 $I_2$를 기준으로 페이저도를 그리면 다음과 같은 페이저도를 얻을 수 있다. 
  
 ![Three Voltmeter Method Circuit Diagram](https://raw.githubusercontent.com/euikook/stock/main/three-ammeter-method-phase.svg) 
  
  
 페이저도를 통해  $\hat{I_2}$와 $\hat{V}$ 사이의 역률각 $\theta$는 다음과 $180 - \phi$ 임을 알 수 있다.   
  
 $$ 
 \theta = 180 - \phi 
 $$ 
  
 우리가 알고 있는 정보로는 $\theta$ 를 직접 구할 수 없지만 $\phi$를 통해 역률각 $\theta$를 유도할 수 있다. 
  
 $\phi$ 가 속해 있는 삼각형의 세 변의 길이를 알고 있으므로 코사인 법칙을 이용하여 $\phi$ 를 구한다. 
  
 > 코사인 법칙을 통해 삼각형에서 두 변의 길이와 그 사잇각으로 부터 제 3변의 길이 구하거나 삼각형 세변의 길이를 알고 있을 경우 세 각을 크기를 알 수 있다.  
  
 $$ 
 I_1^2 = I_2^2 + I_3^2 - 2I_2I_3\cos{\phi} 
 $$ 
  
 $\cos{\phi}$ 에 대하여 식을 정리하면 다음과 같다.  
  
 $$ 
 \cos{\phi} = -\frac{I_1^2-I_2^2 - I_3^2 }{2I_2I_3} 
 $$ 
  
  
 코사인의 특성을 이용하면   $\cos{(180 - \phi)}= -\cos{\phi}$ 이고 $\theta = 180 - \phi$ 이므로 $\cos{(180 - \phi)}$ 를  $\cos{\theta}$ 로 치환한 뒤 $\cos{\phi}$에 대하여 정리하면 $\cos{\phi} = -\cos{\theta}$ 가 된다.  
  
  
 앞에서 구한 $\cos{\phi}$ 를 $-\cos{\theta}$로 치환한 뒤 $\cos{\theta}$에 대하여 정리 하면 역률을 $\cos{\theta}$ 를 다음과 같음을 알 수 있다.  
  
  
 $$ 
 \cos{\theta} = \frac{I_1^2-I_2^2 - I_3^2 }{2I_2I_3} 
 $$ 
  
 ### 유효전력 
  
 앞에서 우리는 유효전력을 구하기 위한 필요한 3가지 값을 측정 또는 계산 하였다.  
  
 * 부하에 인가되는 전압 
  
 $$ 
 V_{L} = R \times I_2
 $$ 
  
 * 부하에 흐르는 전류 
  
 $$ 
 I_L = I_3
 $$ 
  
 * 역률 
 $$ 
 \cos{\theta} = \frac{I_1^2-I_2^2 - I_3^2 }{2I_2I_3} 
 $$ 
  
  
 이제 위의 세 값을 모두 곱한 곱하면 유효전력을 구할 수 있다.  
  
 $$ 
 P = R \times I_2 \times I_3 \times \frac{I_1^2-I_2^2 - I_3^2 }{2I_2I_3}
 $$ 
  
 약분하여 정리하면 다음과 같은 식을 얻을 수 이다.  
  
 $$ 
 P = \frac{R}{2} \times (I_1^2-I_2^2 - I_3^2) 
 $$ 
  
 ##  결론 
  
 전류계 3개를 용하여 부하에서 소비되는 전력을 구하는 공식은 다음과 같다.  
  
 $$ 
 P = \frac{R}{2} \times (I_1^2-I_2^2 - I_3^2)
 $$ 
 