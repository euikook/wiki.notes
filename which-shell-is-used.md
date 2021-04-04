---
title: 어떤 SHELL을 사용하고 있는지 확인해보자.
draft: true
banner: /images/echo-shell.png
tags: [SHELL, bash, zsh, Find Shell]
date: 2021-04-02 11:48:20 +0900
---

## `$SHELL`
`/etc/password` 파일에 정의된 사용자에 할당된 SHELL 출력한다. 

```
echo $SHELL
```

하지만 현재 실행 중인 SHELL 정보를 출력하지 않는다.

```
$ cat /etc/passwd | grep $USER
euikook:x:1000:1000::/home/euikook:/usr/bin/zsh
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
Cons: 쉘스크립트에서는 사용할 수 없다. 

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