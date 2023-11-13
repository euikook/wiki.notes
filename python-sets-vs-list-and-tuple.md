---
title: Python - Set 과 List 그리고 Tuple
link: /python-sets-vs-list-and-tuple
description: 
status: publish
tags: [Python, Set, List, Tuple]
date: 2019-10-21 22:34:34 +0900
lastmod: 2020-03-15 23:50:42 +0900
banner: /images/python-idea.jpg
---

## Set(집합) 이란?
Python 내장 데이터 타입이다. 

> A set object is an unordered collection of distinct hashable objects.

해시 가능한 반복가능 하고 변경 가능하며 중복요소가 없는 데이터 유형의 정렬되지 않은(순서가 지정되지 않은) 컬렉션이다. 

일반적으로 포함테스트(a in sets), *중복제거*, *교집합*, *합집합*, *차집합*, *대칭차*와 같은 수학적 계산에 사용된다. 

## List, Tuple과의 차이
*List*, *Tuple* 은 순서가 있는(ordered) 컬렉션이지만 *Set*은 순서가 없은 컬렉션이다. 


> *List* 와 *Tuple*의 차이는 가변성에 있다. List은 초기화 이후에 수정 수 있으나 *Tuple*은 초기화 이후에 수정할 수 없다. 


## 특징
임이의 값이 컬랙션에 포함되어 있는지 테스트 하는 경우 리스트에 비해 월등히 빠른 성능을 보여 준다.

> Hash로 관리 되기 때문이다. 

<!--more-->

``` python
fruits = {'Apple', 'Banana', 'Coconut', 'Durian'}

while True:
    fruit = input("Enter your preferred fruit name.? ")    
    if fruit in fruits:
        print(f"{fruit}s are in stock")

```

iteration 연산의 경우 리스트에 비하여 느리거나 비슷한 성능을 보인다.

```python
fruits = {'Apple', 'Banana', 'Coconut', 'Durian'}

for fruit in fruits:
    print(fruit)
```


## 초기화

빈 집합 초기화 하기 

```python
fruits = set([])
```

중괄호를 이용한 초기화도 기능한다. 

```python
fruits = {}
```


초기값을 가지는 초기화 

```python
fruits = set(['Apple', 'Banana', 'Coconut', 'Durian'])
```

중괄호를 이용한 초기화 역시 가능하다. 

```python
fruits = {'Apple', 'Banana', 'Coconut', 'Durian'}
```

## 요소 추가 및 삭제

### 요소 추가하기 `add()`  메서드를 사용한다. 
```
fruits.add('Elderberries')
```

### 요소 제거하기 

`remove()` 메서드를 사용한다. 

```
fruits.remove('Elderberries')
```

`discard()` 메서드를 사용할 수도 있다. 

```
fruits.discard('Elderberries')
```

`remove()` 메서드의 경우 해당 키가 없을 경우 `KeyError`예외가 발생하지만 `discard()` 메서드의 경우 집합에 해당 키가 없을 경우 무시된다.



## 변환

### List to Set

```
fruits = set(['Apple', 'Banana', 'Coconut', 'Durian'])
```

### Set to List

```
fruits = set({'Apple', 'Banana', 'Coconut', 'Durian'})
```

## 수학적 연산

### 교집합(`&`)

[![교집합 - Wikipedia](https://upload.wikimedia.org/wikipedia/commons/c/cb/SetIntersection.svg)](https://ko.wikipedia.org/wiki/%EA%B5%90%EC%A7%91%ED%95%A9)

```python
stock = {'Apple', 'Banana', 'Coconut', 'Durian'}
wants = {'Banana', 'Coconut', 'Figs'}

to_buying = stock & wants
```

`to_buying`변수는 다음과 같은 값을 가진다. 

```
{'Coconut', 'Banana'}
```

### 합집합(`|`)

[![합집합 - Wikipedia](https://upload.wikimedia.org/wikipedia/commons/3/32/SetUnion.svg)](https://ko.wikipedia.org/wiki/%ED%95%A9%EC%A7%91%ED%95%A9)

```python
stock = {'Apple', 'Banana', 'Coconut', 'Durian'}
wants = {'Banana', 'Coconut', 'Figs'}

all_fruits = stock | wants
```

`all_fruits`변수는 다음과 같은 값을 가진다. 

```
{'Figs', 'Coconut', 'Durian', 'Apple', 'Banana'}
```

### 차집합(`-`, `difference`)


[![차집합 - Wikipedia](https://upload.wikimedia.org/wikipedia/commons/6/6c/SetDifferenceB.svg)](https://ko.wikipedia.org/wiki/%EC%97%AC%EC%A7%91%ED%95%A9#%EC%B0%A8%EC%A7%91%ED%95%A9)


```python
stock = {'Apple', 'Banana', 'Coconut', 'Durian'}
wants = {'Banana', 'Coconut', 'Figs'}

remain_fruits = stock - wants
```

`remain_fruits`변수는 다음과 같은 값을 가진다. 

```
{'Apple', 'Durian'}
```


### 대칭차(`^`, `symmetric_difference`)

[![대칭차 - Wikipedia](https://upload.wikimedia.org/wikipedia/commons/f/f2/SetSymmetricDifference.svg)](https://ko.wikipedia.org/wiki/%EB%8C%80%EC%B9%AD%EC%B0%A8)

```python
stock = {'Apple', 'Banana', 'Coconut', 'Durian'}
wants = {'Banana', 'Coconut', 'Figs'}

differences = stock ^ wants
```

`differences`변수는 다음과 같은 값을 가진다. 

```
{'Figs', 'Durian', 'Apple'}
```

### Examples

```python
stock = {'Apple', 'Banana', 'Coconut', 'Durian'}
wants = {'Banana', 'Coconut', 'Figs'}

print(f"intersection: {stock & wants}") # 교집합
print(f"union: {stock | wants}") # 합집합
print(f"difference: {stock - wants}") # 차집합
print(f"symmetric difference: {stock ^ wants}") # 대칭차
```


```
intersection: {'Banana', 'Coconut'}
union: {'Banana', 'Apple', 'Durian', 'Coconut', 'Figs'}
difference: {'Apple', 'Durian'}
symmetric difference: {'Apple', 'Durian', 'Figs'}
```