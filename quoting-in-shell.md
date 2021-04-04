---
title: 쉘에서의 큰따옴표와 작은따옴표(인용부호, Quoting) 그리고 백슬래쉬(Baskslash)
draft: false
banner: /images/quoting-in-shell.jpg
tags: [SHELL, bash, zsh, Quoting, Single Quotes, 작은따옴표, Double Quotes, 큰따옴표, Backslash, 백슬래쉬]
date: 2020-03-23 23:48:20 +0900
---

쉘에서 사용되는 세가지 인용법에 대하여 알아보자. 

## SHELL에서 *인용(Quoting)* 이란?

쉘에서 *인용(Quoting)* 은 특정 문자나 단어가 가지는 특별한 의미(또는 기능)를 제거 하는데 사용된다. 예를 들어 *빈칸(`white space`)* 은 쉘에서 인자를 구분하는데 쓰이지만 *Quoting* 된 *빈칸(`<whitespace>`)* 매개변수를 구분하는 기능이 무시된다. 

쉘에서 *Quoting* 메커니즘은 세가지가 있다. 
* 이스케이프 문자(Escape Character): `Hello\ World`
* 작은따옴표(Single Quotes, `'`): `'Hello World'`
* 큰따옴표(Double Quotes, `"`): `"Hello World"`

`Hello\ World`, `'Hello World'` `"Hello World"` 이 세가지 모두 하나의 매개변수로 취급 한다. 


쉘에서 아래 명령을 실행해 보자. 다음 명령은 매개변수의 갯수를 나타내는 변수 `$#` 를 출력한다. 

```
sh -c 'echo $#' Hello World
sh -c 'echo $#' Hello\ World
sh -c 'echo $#' 'Hello World'
sh -c 'echo $#' "Hello World"
```

결과를 보자.

```
$ sh -c 'echo $#' echo Hello World
1
$ sh -c 'echo $#' echo Hello\ World
0
$ sh -c 'echo $#' echo 'Hello World'
0
$ sh -c 'echo $#' echo "Hello World"
0
```

<!--more-->

### 백슬래쉬(Backslash, `\`)

`'`, 또는 `"`로 둘러 싸이지 않은 백슬래쉬(Backslash, `\`)는 이스케이프 문자이다. `<newline>`을 제외하고 백슬래쉬 다음에 오는 문자(Character)의 리터럴 값을 유지 한다. 앞에서도 설명 하였지만 *빈칸(`<whitespace>`)* 은 쉘에서 매개변수를 구분하는 구분자로 쓰이지만 백슬래쉬 다음에 위치 하면 원래의 **문자의 본래 의미인 빈칸이 된다.**  

`<newline>`의 경우는 조금 다르게 처리 되는데 `\<newline>` 쌍이 나타나면 `\<newline>`은 라인이 계속 되는것으로 처리 된다. (즉 입력 스트림에서 제거되어 무시된다.)

예를 들어 아래 명령을 실행 해 보자.

```
echo Hello \
World
```

`<newline>` 이 이스케이프문자인 `\`로 인해 이스케이프 되었다. 앞선 빈칸의 경우와 같이 `<newline>`의 리터럴 값을 유지 한다면 아래와 같이 두 라인으로 출력 되어야 한다. 
```
Hello 
World
```

하지만 결과 값은 아래와 같이 `<newline>` 무시되어 하나의 라인으로 출력되는것을 볼 수 있다. 

```
Hello World
```

### 작은따옴표(Single Quotes, `'`)

작은따옴표(`'`)로 묶인 문자열 속의 각 문자는 자신의 리터럴 값을 유지한다. 따라서 backslash로 이스케이프 하는 경우에라도 작은따옴표 사이에는 작은따옴표를 사용할 수 없다.

### 큰따옴표(Double Quotes, `"`)

큰따옴표로 묶인 문자열 속의 각 문자는 `$`, `` ` ``, `\`  를 제외하고 자신의 리터럴 값을 유지 한다. 

큰따옴표 안에 있는 `$ + 'STRING'` 은 매개변수로 치환된다. 


따라서 아래 두 명령은 완전 다른 결과를 나타낸다.

```
GREETING="Hello World" 
sh -c "echo $GREETING"
```

큰따옴표로 묶였기 때문에 `$GREETING`이 `Hello World`로 치환되어 새로운 SHELL로 `echo Hello World`가 전달된다. 따라서 명령의 결과로 `Hello World` 출력된다.

```
GREETING="Hello World" 
sh -c 'echo $GREETING'
```
작은따옴표로 묶였기 때문에 `$GREETING`이 치환되지 않고 *리터럴 값* 그대로 인자로 넘어 가 새로운 쉘 에서 `echo $GREETING` 명령이 실행 되지만 새로운 쉘에서는 `$GREETING` 변수가 정의 되어 있지 않으므로 빈라인이 출력된다.


## References
* [sh(1): GNU Bourne-Again SHell - Linux Man Page](https://linux.die.net/man/1/sh)
* [sh(1p) - Linux manual page](https://man7.org/linux/man-pages/man1/sh.1p.html)