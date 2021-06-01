---
title: 평균과 평균필터(Feat. Python)
draft: false
tags: [Average, Average Filter, Mean, Recursive, Arithmetic, Algorithm, Arithmetic Mean, Batch Expression, 배치식, Recursive Expression, 재귀식]
date: 2020-11-18 23:29:45
lastmod: 2021-05-31 22:20:21
banner: /images/average-banner.jpg
aliases:
- /posts/average-filter
---

## 산술 평균

$n$개의 수 $x_1, x_2, ... x_n$ 가 있다. 이 수의 산술 평균은 $A_n$ 은 다음과 같이 정의 된다.  

$$ A_n = \frac{x_1 + x_2 + ... + x_n}{n}, A_0 = 0 \tag{1}$$

그냥 주어신 수의 합을 수의 개수로 나누면 된다. 이러한 식을 배치식이라고 한다. 고정된 데이터의 경우 배치식을 이용햐여 구하면 된다. 

```python
def avg_batch(v):
    return sum(v)/len(v)

if __name__ == '__main__:
    ages = [10, 12, 26, 30, 40, 33, 21, 34, 54, 3]
    print(f'Average using Batch Expression: {avg_batch(ages)}')
```

하지만 입력 데이터가 계속 실시간으로 계속 추가 된다면? 입력 데이터의수가 많아저셔 100만개 정도 된다면? 위 배치식으로 평균을 구하기 위해서는 입력된 모든 값을 메모리에 저장 하여야 하며 새로운 값이 입력 될때마다 모든 값의 평균을 다시 구해야 하기 때문에 비효율 적이다. 


직전 평균 값, 새로운 수, 데이터의 개수만 있으면 평균을 구할 수 있는 방법이 있는데 이를 이전 값(직전 평균)을 (재)사용한다는 의미에서 재귀식이라고 한다. (재귀식이라고 해서 재귀 함수를 사용하는것이 아니다.)


직전 평균 값을 이용하여 평균값을 구하기 위해 재귀식을 유도해 보자.

## 재귀식 유도 과정 #1
먼저 의식의 흐름대로 유도해 보자.

배치식인 수식 $(1)$의 우변의 분모 제거를 위해 양변에 $n$을 곱한다. 

$$ nA_n = x_1 + x_2 + ... + x_n $$

재귀 평균은 직전 평균값이 필요함으로 우변의 $x_1 + x_2 + ... + x_n$ 를 $x_1 + x_2 + ... x_{n-1} + x_n$ 으로 나눈 다음 

$$ nA_n = x_1 + x_2 + ... + x_{n-1} + x_n $$

각 양변에 $\frac{1}{n-1}$을 곱한다. 

$$ \frac{n}{n-1}A_n = \frac{x_{1} + x_{2} + ... + x_{n-1}}{n-1} + \frac{x_{n}}{n-1} $$


$\frac{x_{1} + x_{2} + ... + x_{n-1}}{n-1}$ 는 $n-1$ 까지의 평균(직전 평균 값)이므로 $A_{n-1}$ 로 치환한다. 


$$ \frac{n}{n-1}A_{n} = A_{n-1} + \frac{x_n}{n-1} $$

$A_n$을 유도하기 위해 양변에 $\frac{n-1}{n}$ 을 곱한다.

$$ A_n =  \frac{n-1}{n}\bar{A}\_{n-1} + \frac{x_n}{n}, A_0 = 0 \tag{2}$$

수식 $(2)$를 간략화 하기 위해 $\frac{n-1}{n}$ 를 $\alpha$로 치횐한 다음 

$$ \alpha = \frac{n-1}{n} = 1 - \frac{1}{n} $$

$\frac{1}{n}$에 대해 풀어보면 $\frac{1}{n}$는 $\alpha$에 대한 식으로 유도된다. 

$$ \frac{1}{n} = 1 - \alpha $$

수식 $(2)$의 $\frac{n-1}{n}$과 $\frac{1}{n}$을 $\alpha$에 대한 식으로 치환하면 다음과 같은 공식을 얻을 수 있다. 

$\alpha = \frac{n-1}{n}$ 일때,

$$ A_{n} = \alpha A\_{n-1} + {(1 - \alpha)x_n}, A_0 = 0 \tag{3}$$


수식 $(2)$를 코드로 옯겨 보자.

```python
def avg_recursive(a, v, n):
    return (n-1)/n*a + v/n

if __name__ == '__main__:
    ages = [10, 12, 26, 30, 40, 33, 21, 34, 54, 3]
    avg = 0
    for idx in range(len(ages)):
        avg = avg_recursive(avg, ages[idx], idx + 1)
    print(f'Average using Recursive Expression: {avg}')
```


## 재귀식 유도 과정 #2
이번에는 다른 접근 방법으로 유도해보자.

직전 평균값 $A_k$이 있다고 가정하자. $A_k$은 수식 $(1)$과 같이 $k$개의 수 $x_1, x_2, ... x_k$ 의  평균이다.

새로운 수 $x_{k+1}$ 이 추가된 평균 값 $A\_{k+1}$ 을 구해 보자. 

$$ A\_{k+1} = \frac{kA_k + x_{k+1}}{k+1}, A_0 = 0 \tag{4}$$ 

결과를 보기 이해 하기 쉽게 표현하기 위해 우변의 분자 분리 한다. 

같은 결과를 얻을 수 있다. 

$$A\_{k+1} = \frac{k}{k+1}A_k + \frac{x_{k+1}}{k + 1}, A\_0 = 0 \tag{5}$$


노테이션만 조금 다를뿐 같은 결과다.


수식 $(5)$에서의 $k+1$가  수식 $(2)$에서의 $n$ 임으로 다음 식이 설립한다.

$$ n = k + 1 $$

확인을 위해 수식 $(2)$ 의 $n$ 을 $k+1$로 치환해 보자.

$n = k + 1$ 일때, 

$$ A_n =  \frac{n-1}{n}\bar{A}\_{n-1} + \frac{x_n}{n} = A_{k+1} =  \frac{k}{k+1}A\_{k} + \frac{x\_{k + 1}}{k+1}, A_0 = 0$$


접근 방법에 따라 유도 과정이 엄청나게 차이나는 것을 알 수 있다.

> 설명을 위해 식이 늘어 났을 뿐 한 스탭 만에 식이 유도 되었다. 


수식 $(5)$를 코드로 옯겨 보자.

```python
def avg_recursive(a, v, n):
    return n/(n + 1)*a + v/(n+1)

if __name__ == '__main__:
    ages = [10, 12, 26, 30, 40, 33, 21, 34, 54, 3]
    avg = 0
    for idx in range(len(ages)):
        avg = avg_recursive(avg, ages[idx], idx)
    print(f'Average using Recursive Expression: {avg}')
```

수식 $(2)$를 통해 만들었던 코드와 같은 코드가 만들어 졌다. `avg_recursive(a, v, n)` 함수의 마지막 인자 `n`에  `n+1` 넘기냐, `n`을 넘기냐 는 차이 뿐이다.  앞서 만든 수식보다 지금 만근 코드가 더 직관적이므로 이 코드를 사용한다.


## Test

테스트를 위한 전체코드는 다음과 같다. 


```python
def avg_batch(v):
    return sum(v)/len(v)

def avg_recursive(a, v, n):
    return n/(n + 1)*a + v/(n+1)

if __name__ == '__main__':
    ages = [10, 12, 26, 30, 40, 33, 21, 34, 54, 3]

    print(f'Average using Batch Expression: {avg_batch(ages)}')

    avg = 0
    for idx in range(len(ages)):
        avg = avg_recursive(avg, ages[idx], idx)

    print(f'Average using Recursive Expression: {avg}')
```


실행하면 다음과 같이 같은 결과를 얻을 수 있다. 

```bash
Average using Batch Expression: 26.3
Average using Recursive Expression: 26.3
```

## Next Work

다음에는 다음을 포함하는 [이동평균(Moving Average)](/posts/about-moving-average)에 대해 알아 보자. 

* [단순이동평균 (Simple Moving Average, SMA)](/posts/about-moving-average#단순이동평균)
* [누적이동평균 (Cumulative moving average, CMA)](/posts/about-moving-average#누적이동평균)
* [가중이동평균 (Weighted Moving Average, WMA)](/posts/about-moving-average#가중이동평균)
* [지수이동평균 (Exponential Moving Average, EMA), 지수가중이동평균(Exponentially Weighted Moving Average, EWMA)](/posts/about-moving-average#지수이동평균)