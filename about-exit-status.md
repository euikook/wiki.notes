---
title: Shell에서의 Exit Status에 대하여
draft: false
banner: /images/exit-banner.jpg
tags: [Exit Status, Exit Status, Shell, Programming]
date: 2021-04-01 10:09:28 +0900
---

*Exit Status*에 대하여 알아보자. 

요즘은 GUI를 많이 사용하지만 지금도DOS나 UNIX계열의 시스템에서는 쉘(SHELL)을 통해 프로그램을 실하고 프로그램의 출력을 통해 프로그램이 정상적으로 실행되었는지를 판단하한다.


> 전통적으로 UNIX 계열 프로그램은 *침묵은 금*이라는 유닉스의 설계 철학에 따라 `ls`와 같이 명시적으로 정보의 출력을 요구 하는 명령이 아닌경우 아무런 출력이 없으면 정상적으로 실행 된것이다.

> ***Speech is silver, but silence is gold.***


그렇다면 프로그램에서 다른 프로그램을 실행 하였을 때 자신이 실행한 프로그램이 정상적으로 수행되었는지 어떻게 판단 할까? 

정답을 말하면 모든 명령은 종료될 때 *Exit Status*를 반환하는데 (명시적으로 지정하지 않을 경우 기본값을 반환한다.) 프로그램은 이 *Exit Status*를 가지고 자신의 실행한 프로그램이 정상적으로 종료 되었는지 판단 할 수 있다. 

*Exit Status*는 O 에서 255 사이의 값을 가지고 쉘의 경우 125 이상의 값을 사용한다. 

<!--more-->

앞서도 설명 했듯이 *침묵은 금*이기 때문에 많은 프로그램이 아무런 문제 없이 정상 종료 되었다면 *Exit Status* `0`을 반환한다. 

> 사실 완전히 같은 의미는 아니지만 *침묵은 금*이라는 UNIX의 철학을 어느정도 따른다고 볼수 있다. 

쉔에 요청한 명령이 존재 하지 않는 경우 *Exit Status* 127을 반환한다. 명령이 존재 하지만 실행 가능하지 않은 경우 126을 반환한다.  명령이 `SIGINT`나 `SIGSEGV`와 같은 *Fatal Signal* $N$에  의해 종료 된 경우 *Exit Status*는 $128 + N$ 이 된다. 


그렇다며 이 0 ~ 125 까지의 *Exit Status*는 어떻게 정의 되는가? 많은 프로그램들이 *POSIX*에 정의된 [errno.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html)를 따른다. 


[errno.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html)에는 자주 발생하는 에러를 정의해 놓았다. 프로그램이 비정상 적으로 종료 될때 [errno.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html)를 참고 하여 반환값(*Exit Status*)을 결정 하도록 하자.


*C*나 *C++* 개열의 함수도 마찬가지다. 함수의 수행 상태를 정수값으로 반환하는 함수의 경우 반환값을 [errno.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html)를 참고 하여 반환 하도록 한다.

> 메모리 비교 함수인 *memcmp*와 문자열 비교함수인 *strcmp* 계열의 함수를 보자. *C*에서는 0 이 아닌 값이 참(*TRUE*) 이지만 위 함수들은 비교 대상이 일치 할때 `0`을 반환한다.


## Shell Command(쉘 명령)
*쉘 명령(Shell Command)* 은 *명령(Command)* 과 그에 따르는 공백 문자로 구분된 *인자(Argument)* 들로 구성된다. 

사실 쉘에서 사용되는 상수, 문자열과 몇몇 예약어를 제외한 모든 *특수 문자와 문자의 조합은* 쉘에 내장된 명령또는 일발적은 명령이다.

심지어 `test`를 대신해서 쓰이는 `[` 까지 Shell에 내장된 명령어이다. 


아래 명령을 실행 해보자
```
which [
```

BASH의 경우 다음과 같은 출력을 얻을 수 있다.
```
/usr/bin/[
```

ZSH의 경우 다음과 같은 결과를 얻을 수 있다. 
```
[: shell built-in command
```


## errno


유닉스 계열 시스템을 사용한다면 `errno` 명령으로 확인 할 수 있다. 

```
errno -l
```

아래는 위 명령의 출력중 일부를 나타낸 것이다.

```
EPERM 1 Operation not permitted
ENOENT 2 No such file or directory
ESRCH 3 No such process
EINTR 4 Interrupted system call
EIO 5 Input/output error
ENXIO 6 No such device or address
E2BIG 7 Argument list too long
ENOEXEC 8 Exec format error
EBADF 9 Bad file descriptor
ECHILD 10 No child processes
EAGAIN 11 Resource temporarily unavailable
ENOMEM 12 Cannot allocate memory
.
.
.
```

> `errno` 명령은 `moreutils`의 일부 이므로 없다면 패키지를 설치 한다.

### Debian 계열 (Debian, Ubunut, Mint...)
```
sudo apt install moreutils
```

### Arch Linux 계열 (ArchLinux, Manjaro...)
```
sudo pacman -S moreutils
```


### Redhat 계열 (Redhat, Fedora, Centos...)
```
sudo yum install moreutils
```

```
sudo dnf install moreutils
```


## 프로그래밍에서의 *Exit Status*, *Return Code*

아래와 같이 간단한 프로그램을 만든다고 가정해 보자. `main()` 함수에서 반환 하는 값이 *Exit Status* 가 되는데 앞서 설명 했듯이 0은 에러가 없는 상태를 나타내기 때문에 아래 예제에서는 `0`을  반환 하였다.  

```c
#include <stdio.h>

int main(int argc, char **argv)
{
    fprintf(stdout, "Hello!!");

    return 0;
}
```

하지만 프로그램 실행중 문제 가 발생하여 프로그램을 종료 해야 하는 경우 `0`을 반환 한하였다면 소스코드를 볼수 없는 프로그램 사용자들은 *Exit Status*가 `0`이기 때문에 프로램이 정상적으로 종료되었다고 착각 할 수 있다. 


따라서 프로그램이나 쉘에서 수행되는 스크립트를 을 작성하는 경우 등으로 함수를 작성할때 반환되는 값을 POSIX에 정의된 errno를 참고하도록 하자. 


> 리눅스에서 많이 사용되는 주요 프로그램들 대부분이 `errno`의 규칙을 따르지만 그렇지 않은 프로그램도 있다. 해당 프로그램의 매뉴얼을 읽어보자.([**RTFM**](https://en.wikipedia.org/wiki/RTFM))


## 쉘에서의 *Exit Status*

쉘에서 실행한 명령의 종료 상태는 `$?` 변수에 저장된다. 


아래 명령을 수행 해보자.

```
ls 
echo $?
```

화면에 `0`이 출력된다. ls 명령이 정상적으로 종료 된 것이다. 


그렇다면 아래와 같이 `ls` 명령 다음에 존재 하지 않는 파일이나 디렉터리의 이름을 넣어 보자.
```
ls asdfasdfasdf
echo $?
```

화면에 `2`가 출력된다. 

POSIX `errno.h`에는 errno `2` 는 `ENOENT`로 정의 되어 있으며 파일이나 디렉토리가 없을 경우 반환 하는 값니다.(`No such file or directory`)

### Lists

리스트라는 개념이 있다. 우리가 알고 있는 리스트와는 조금 다르다. 아래는 [BASH 메뉴얼](https://www.gnu.org/software/bash/manual/bash.html#Lists)에 있는 리스트에 대한 정의 이다. 

> A List is a sequence of one or more pipelines separated by one of the operators **`;`**, **`&`**, **`&&`**, or **`||`**‚ and optionally terminated by one of **`;`**, **`&`**, or **`<newline>`**.

리스트는 **`;`**, **`&`**, **`&&`**, 또는 **`||`** 연산자중 하나로 구분되고 선택적으로 **`;`**, **`&`**, 또는  **`<newline>`** 으로 종료되는 하나 이상의 *파이프라인* 시퀀스다. 

#### `&&` 연산자

Logical AND 연산과 같다. 

```
command-one && command-two
```

`command-one` 이 참일 경우에만 `command-two`가 실행된다. 


#### `||` 연산자

Logical OR 와 같다. 

```
command-one || command-two
```

`command-one` 이 거짓 일 경우에만 `command-two`가 실행된다. 



이 `&&`와 `||` 연산자를 활용하여  간단한 `if` `else`문과 같은 효과를 볼 수 있다. 


디렉터리가 존재 할 경우 디렉터리를 삭제

```
[ -d /home/test/aaa ] && rm -rf /home/test/aaa
```

디렉터리가 존재하지 않을 경우 디렉터리를 생성
```
[ -d /home/test/aaa ] || mkdir -p /home/test/aaa
```

파일이 존재 하고 실행 권한이 있는 경우 파일을 실행
```
[ -x /bin/errno ] && errno -l
```


파일이 존재 하지 않을 경우 파일 생성
```
[ -f /home/test/aaa ] || touch /home/test/aaa
```

`&&` 연산자 사용시 주의점

```
[ -d /home/test/aaa ] && rm -rf /home/test/aaa
```

위 명령은 `[ -d /home/test/aaa ]` 이 참일 경우  `rm -rf /home/test/aaa` 명령을 실행하라는 뜻이다. 

`/home/test/aaa` 디렉터리가 존재 하지 않을 경우 `[ -d /home/test/aaa ]` 명령이 거짓이 되어 `rm -rf /home/test/aaa`  명령이 실행 되지 않게 된다. 그리고 이 List의 *Exit Status*는 `[ -d /home/test/aaa ]`의 결과인 `1` 이 된다. 

Makefile 등에서 이 명령을 사용하였을 때 Exit 가 참이 아니기 때문에 다음 명령이 수행되지 않는다.


`/home/test/aaa` 가 디렉토리 일 경우 이 디렉토리를 삭제하고 빈 파일 `/home/test/aaa`를 생성하고자 아래와 같이 `Makefile`을 작성 했다면 

```makefile

all:
    [ -d /home/test/aaa ] && rm -rf /home/test/aaa
    touch /home/test/aaa
```

`[ -d /home/test/aaa ] && rm -rf /home/test/aaa`의 결과가 거짓이기 때문에 다음 명령인 
`touch /home/test/aaa` 수행 되지 않는다. 


명령 다음에 `||` 연산자와 `true` 명령을 추가 하자. 

> `true` 명령은 Exit Code `0`를 반환한다.


`Makefile`
```makefile

all:
    [ -d /home/test/aaa ] && rm -rf /home/test/aaa || true
    touch /home/test/aaa
```

