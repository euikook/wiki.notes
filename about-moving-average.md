---
title: 이동평균에 대하여 (feat. Python)
tags: [Moving Average, MA, 이동평균, 단순이동평균, 누적이동평균, 가중이동평균, 지수이동평균, Python, Pandas,]
date: 2021-05-31 23:20:21
banner: /images/banners/bitcoin-price-btc-chart-md.jpg
draft: false
katex: true
---

이전에 [평균에 대한 글](/posts/average-and-average-filter)을 쓴 적이 있다. 그 다음 편으로 예정 되어 있던 이동 평균에 대한 알아보자.

## 이동평균

통계에서 이동평균은 전체 데이터 집합의 여러 하위 집합에 대한 일련의 평균을 만들어 데이터 요소를 분석하는데 사용되는 계산이다. 금융에서 이동평균은 분석에 일반적으로 사용되는 주식 차트 이다.

* 이동평균은 기술분석에서 일반적으로 사용되는 주식 지표이다.
* 주식의 이동 평균을 계산하는 이유는 지속적으로 업데이트되는 평균가적을 생성하여 지정된 기간동안의 가격 데이터를 평활화 하기 위해서이다.
* 단순 이동평균은 과거의 특정 일수 동안 주저진 가격 세트의 산술 평균이다. 예를들어 15, 30, 100일 또는 200일이 될 수 있다.
* 결과값이 지연되어 나타나는 경향이 있다.
* 이동평균의 기간이 길어질 수록 지연이 커진다.
* 최근값에 더 많은 가중치를 두려면 가중이동 평균이나 지수이동평균을 사용해야한다.

지난번 알아 보았던 [평균과 평균 필터](/posts/average-and-average-filter)는 전체 값중 중간 값을 알수 있기 때문에 유용하지만 전체 샘플의 수가 많으면 최근 값이 평균값에 미치는 영향이 작아 지기때문에 누적 데이터가 많아 질수록 현재의 변화 상태를 반영하지 문하는 문제가 있다.

이 포스트에서 사용된 Raw 데이터는 [Bitcoin data at 1-min intervals from select exchanges, Jan 2012 to March 2021](https://www.kaggle.com/mczielinski/bitcoin-historical-data)에서 다운 받은 데이터 중 최근 365일 데이터를 사용하였다.

<!--more-->

## 주식에서

주식 가격의 추이 분석에 사용된다. 보통 주식 가격의 변화는 매우 빠르고 자주 바뀌기 때에  단기간의 변화를 평활화 하여 가경의 변동 추이를 분석 하기 위해 사용된다. 단기적인 추세 분석을 위해 10일, 20일, 50일 이동평균을 사용하고 장기적인 추세 분석을 위해 100일 또는 200일 이동평균을 사용한다. 

## 공학에서

디지털 신호처리에서 잡음을 제거하고 데이터의 평활화하는데 사용된다. 저대역 필터(Low Pass Filter) 역할을 한다.

### 단순이동평균

단순하게 평균을 구하는 시점에서 이전 $N$ 샘플 이전 까지의 평균을 구하는 방법이다.

```python
all_frames = pd.read_csv('data.csv')
df = all_frames.tail(365)
price = df.Close
sma = price.rolling(N, min_periods=1).mean()
```

$$ 
SMA_n = \frac{p_{N-n+1} + p_{N-n+2} ... + p_n}{n}
$$

아래는 $N$ 이 15, 30, 60, 90, 120 일때의 단순 이동평균 그래프다.

![Simple Moving Average](/images/moving-average/sma.svg)

단순 이동평균은 평균을 계산하는데 사용되는 데이터의 가중치가 같다. 과거의 데이터가 극단적으로 높거나 낮을 경우 과거 데이터에 의한 현재 데이터의 외곡 현상이 나타날 수 있다. 즉, 최근 데이터와 같은 가중치를 가지기 때문에 평균선이 현재 데이터변화 추이를 제대로 반영하지 못한다는 단점이 있다.

### 누적이동평균

누적 이동평균은 우리가 알고 있는 일반적인 평균과 같다. 즉, 처음 측정 시점부터 현재 까지의 모든 데이터의 평군이다.

보통 특정 주식이나 제품의 가격에 대해 현재까지의 평균 거래 가격등을 구하는데 사용된다.

누적 이동평균은 평균을 계산하는데 사용되는 데이터에 대한 가중치가 같다. 

$$
CMA_n = \frac{x_1 + ... + x_n}{n}
$$

```python
all_frames = pd.read_csv('data.csv')
df = all_frames.tail(365)
price = df.Close
cma = price.expanding().mean()
```

![Cumulative Moving Average](/images/moving-average/cma.svg)

### 가중이동평균

단순 이동평군에서 모든 데이터에 같은 가중치를 사용함에서 오는 단점을 해결하기 위한 이동 평균이다. 보통 실생활에서는 과거의 데이터 보다 최신 데이터가 더 중요하기 때문에 $n$ 일 동안의 온도변화에 대한 가중이동평균을 구하기 다고 가정하면 최신 날짜인 $n$일의 가중치는 $n$  이고 그다음 최신 날따인 $n - 1$ 일의 온도에 대한 가중치는 $n - 1$ 이다. 가중치는 날짜가 지남에 따라 $1$씩 줄어 들어 최종적으로 $1$이 될때까지 줄어 든다.  $n$일 이전 온도 데이터는 가중이동평균의 계산 결과에 영향을 주지 않는다.

$$
WMA_M = \frac{np_M + (n-1)p_{M-1} + ... + 2p_{((M - n) + 2)} + p_{((M-n) + 1)} }{n + (n - 1) + ... + 2 + 1}
$$

$$
Total_{M+1} = Total_M + p_{M+1} - p_{M-n+1}
$$

```python
all_frames = pd.read_csv('data.csv')
df = all_frames.tail(365)
price = df.Close
sma = price.rolling(N).apply(lambda x: np.dot(x, w)/w.sum(), raw=True)
```

아래는 $N$ 이 15, 30, 60, 90, 120 일때의 가중이동평균 그래프다.

![Weighted Moving Average](/images/moving-average/wma.svg)

### 지수이동평균

가중이동평균의 단점이라고 할 수 있는 $n$ 개 이전의 데이터가 평균 계산 결과에 영향을 주지 않는 문제를 해결 하기 위해 산술적으로 감소하는 가중치가 아닌 지수적으로 감소하는 가중치를 적용한 것이다. 가중치는 기하급수적으로 감소하지만 결코 0이 도달 하지는 않는다.

$$
EMA_n = \alpha X_n + (1 - \alpha)EMA_{n-1}
$$

여기서 계수 $\alpha$ 를 평활계수 (smooth factor) 라고 부른다. $\alpha$ 가 커질수록 최근 샘플에 주어지는 가중치가 커진다. $\alpha$ 는 0과 1사이의 값을 가져야 한다. $\alpha$ 가 커지면 최근 데이터의 가중치가 커지고 이전 데이터의 가중치가 더 빠르게 줄어 든다.

$\alpha$ 값은 임의로 선택 가능 하지만 보통 다음 값을 사용한다.

$$
\alpha = \frac{2}{(N+1)}
$$

하지만 반드시 ${2}/{(N+1)}$ 를 사용해야 하는것은 아니다. 입력 값이나 원하는 결과값에 따라 조절 할 수 있다. 예를 들어 최근 값 보다는 이전 값에 더 많은 가중치를 두고 싶다면 $\alpha$ 값을 $0.00001$ 로 두고 계산 할 수도 있다.

```python
all_frames = pd.read_csv('data.csv')
df = all_frames.tail(365)
price = df.Close
sma = price.ewm(alpha=2/(N+1)).mean()
```

아래는 $N$ 이 15, 30, 60, 90, 120 일때의 지수이동평균 그래프다.

![Exponential Moving Average](/images/moving-average/ema.svg)

### 가중치 변화

다음 그래프는 $N$이 15일 때 각 이동 평균의 가중치 변화를 그래프로 나타낸 것이다.

![Weights for Moving Average](/images/moving-average/weight.svg)

지수 이동 평균의 평활 지수는 $\frac{2}{(N+1)}$ 로 설정 하였다. $N$이 15이기 때문에 $\frac{1}{8}$ 이 된다.

> 이 그래프를에서 $N = 15$ 임으로 중간 값인 $7$ 일때의 가중치를 보면 단순이동평균(SMA)의 가중치와 지수이동평균(EMA)의 가중치가 같다.

### 예제

2020년 3월 부터 2021년 3월 까지의 비트 코인 시세를 각 이동평균 계산법으로 계산하면 다음과 같은 그래프를 얻을 수 있다. ($N=15$)

![Moving Average](/images/moving-average/all.svg)

> 차트를 만드는데 사용된 소스코드는 [Python Moving Average Examples with Pandas](https://github.com/euikook/python-moving-average-examples)에서 확인할 수 있다.
