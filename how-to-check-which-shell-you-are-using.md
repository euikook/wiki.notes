---
title: 어떤 SHELL을 사용하고 있는지 확인해보자.
draft: false
banner: /images/echo-shell.png
tags: [SHELL, bash, zsh, shell script, source, source command, dot, dot command, BASH_SOURCE]
date: 2021-04-02 11:48:20 +0900
---


어러 쉘이 있다. sh(Bourne Shell)을 기반으로 하는 Bash(Bourne-again shell), zsh(Z shell) 등은 문법이 거의 똑같지만 완전히 같지는 않다. 
쉘스크립트를 만들어 실행 하는 경우 `#!` 지시자로 사용할 쉘을 지정할 수 있기 때문에 크게 문제가 없지만 `source` 명령이나 `dot`(`.`) 명령으로 현재 환경(Current Environment Context)에서 스크립트를 실행하는 경우 사용중인 쉘의 종류에 따라 문법이 달라 문제가 발생 할 수 있다. **주의해서 처리 하도록 하자.**


기본쉘을 Zsh 사용하기 시작하면서 겪은 문제다. 보통 리눅스에서 기본쉘은 Bash 이기 때문에 거의 모든 프로그램들이 Bash 위주로 구현되어 있기 때문에 발생 하는 문제이다. 

대부분 다음과 같은 문제이다. 

실행 스크립트의 파일 이름을 알고 싶을때 Bash에서는 `$BASH_SOURCE`를 사용한다. 하지만 이 변수는 *Bash* 에서만 지원됨으로 Zsh에서는 `$0` 변수를 사용해야 된다. Bash에서도 `$0`변수를 지원하지만 Bash에서 `$0` 변수를 사용하면 쉘의 정보((`bash`)가 표시된다. 


> 쉘스크립트에서 `$0` 는 실행파일의 이름을 나타내는 변수 이다. Bash에서 `$0` 변수는 쉘이 시작할 때만 초기화 되지만 `dot` 명령은 새로운 쉘을 시작하는 것이 아니라 현재 쉘의 컨텍스트에서 실행 하는 것이므로 쉘에서 `echo $0` 를 실행한것과 같은 결과(즉, `bash`)가 출력된다. 그런데 *Zsh* 에서는 `$0`가 스크립트 이름으로 세팅된다. 


> 구글링을 해보면 [*Zsh*에서 *Bash*의 `$BASH_SOURCE` 와 가장 가까운 결과를 내는것은 `${(%):-%x}` 라고 한다](https://stackoverflow.com/questions/9901210/bash-source0-equivalent-in-zsh#answer-28336473). 하지만 `$0`도 같은 결과는 내기 때문에 그냥 사용하기로 한다.

다음은 `./env` 파일의 내용이다.
```
echo \$BASH_SOURCE = $BASH_SOURCE
echo \$0 = $0
```

각 SHELL에서 실행 해 보자

```
. ./env
```

다음과 같은 출력을 얻을 수 있다.

`bash`

```
$BASH_SOURCE = ./env
$0 = bash
```

`zsh`

```
$BASH_SOURCE =
$0 = ./env
```

따라서 실행 되는 스크립트의 이름 알기 위해서는 다음과 같이 쉘에 따라 다른 방식을 정용하여야 한다.

```
SH_NAME=$(basename $(readlink /proc/$$/exe))

case ${SH_NAME} in
	"zsh") SELF=$(realpath $0) ;;
	"bash") SELF=$(realpath ${BASH_SOURCE[0]}) ;;
	*) echo "Unknown SHELL $SH_NAME" && exit 0 ;;
esac

echo $SELF
```

Bash 또는 Zsh 만 사용한다면 다음과 같이 사용해도 같은 결과를 얻을 수 있다.

```
SELF=$(realpath ${BASH_SOURCE[0]:-$0})
echo $SELF
```

아래와 같이 env 파일을 만들고 `dot command`로 실행해보자

```
SELF=${BASH_SOURCE[0]:-$_}
echo $(basename $SELF) is located at $(realpath $SELF)
```

`env` 파일 실행
```
. ./env
```

*Bash*, *Zsh* 둘다 같은 결과를 얻을 수 있다.
```
env is located at /home/euikook/src/env
```
 

## `$SHELL`
`/etc/password` 파일에 정의된 사용자에 할당된 SHELL 출력한다. 

```
echo $SHELL
```

### Cons
지정된 쉘 정보를 표시 하지만 현재 사용중인 SHELL 정보를 출력하지 않는다.

```
$ cat /etc/passwd | grep $USER
john:x:1000:1000::/home/john:/usr/bin/zsh
```

`cat` 명령으로 `/etc/passwd` 파일을 확인 결과 /usr/bin/zsh 가 쉘로 할당되어 있다. 

아래와 같이 `bash`로 쉘을 변경 후 `$SHELL` 과 `$0` 정보를 출력 해보자.

```
$ bash
$ echo echo User SHELL is $SHELL, Current SHELL is $0
User SHELL is /usr/bin/zsh, Current SHELL is bash
```

<!--more-->

## `$0`
쉘스크립트에서는 `$0`는 입력된 라인의 첫번째 단어를 나타낸지만 SHELL 상에서는 현재 SHELL의 이름을 표시한다.
```
echo $0
```
BASH 의 경우
```
bash
```
ZSH의 경우 
```
/usr/bin/zsh
```

### Cons
쉘스크립트에서는 사용할 수 없다. 

아래와 같은 스크립트를 만들고 실행해 보자. 

`print-shell.sh`
```
#!/usr/bin/env bash
echo $0
```

아래와 같이 스크립트의 첫번째 인자인 `./print-shell` 이 출력된다.
```
$ ./print-shell
./print-shell.sh
```

## `/proc/$$/exe`

현재 프로세서의 `PID`를 나타내는 `$$` 변수를 이용한 방법이다. 

리눅스에서는 각 프로세서의 정보가 `/proc/<pid>/` 디렉터리에 있으며 `/proc/<pid>/exe`는 원본 실행 파일의 심볼릭 링크를 나타낸다. 
따라서 쉘 스크립트 상에서 아래 명령을 실행 하면 현재 실행 중인 쉘의 정보를 확일 할 수 있다.
```
readlink /proc/$$/exe
```

### Cons
가장 안정적으로 SHELL 정보를 가져올 수 있지만 리눅스에서만 사용할 수 있다. 


## `ps` Command

`ps` 명령을 활용하는 방법이 있다. 



```
sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p
```


```
sh -c 'ps -p $$ -o ppid=' | xargs -I'{}' readlink -f '/proc/{}/exe'
```

## sh -c 'COMMAND' vs COMMAND

`sh -c 'COMMAND'`와 COMMAND의 차이는 주어진 명령을 수행하기 위해 프로세서가 분기 될 때 전자의 경우 별도의 SHELL 프로세서에서 분기 되는 반면 후자의 경우에는 메인 SHELL 스크립트에서 분기 되는 것이다. 

예를 들어 `ps -p $$` 명령을 가각 실행 해 보자.

`sh -c 'ps -p $$'` 의 결과
```
$ $ sh -c 'ps -p $$'
    PID TTY          TIME CMD
1710512 pts/2    00:00:00 ps
```

PID `1710512`에 대한 COMMAND가 `ps` 인것을 확인 할 수 있다. 

ps 명령을 실행하기 위해 새로운 프로세서를 생성 하고 생성된 프로세서에서 `ps $$` 명령을 수행 하여 `$$` 변수가 생성된 프로세서의 PID로 대치 된 것을 알 수 있다.

`ps -p $$`의 결과
```
$ ps -p $$
    PID TTY          TIME CMD
1710370 pts/2    00:00:00 bash
```

현재 자신의 PID `1709311`에 대한 COMMAND `bash` 인 것을 확인 할 수 있다. 

반면 `ps -p $$` 은 메인 쉘에서 분기 하여 실행 되었으며 ps 명령이 수행 되기 전에 `$$` 변수가 메인 SHELL의 PID로  대치 된 것을 알 수 있다.


## References
* [sh(1): GNU Bourne-Again SHell - Linux Man Page](https://linux.die.net/man/1/sh)
* [sh(1p) - Linux manual page](https://man7.org/linux/man-pages/man1/sh.1p.html)