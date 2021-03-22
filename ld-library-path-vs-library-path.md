---
titie: LD_LIBRARY_PATH vs LIBRARY_PATH
draft: false
date: 2021-03-21 23:23:35 +0900
tags: [gcc, LD_LIBRARY_PATH, LIBRARY_PATH]
banner: /images/cmake-build.png
---

## `LD_LIBRARY_PATH` vs `LIBRARY_PATH`

외부 C 라이브러리를 사용하는 패키지를 Python 패키지를 설치 하려고 하는데 검색할 C 라이브러리 위치를 지정하려고 무심코 `LD_LIBRARY_PATH` 변수에 지정했는데 컴파일이 계속 실패 한다. 

```
/usr/bin/ld: cannot find -ltest
```

삽질을 좀 하다가 생각해보니 LD_LIBRARY_PATH는 실행 타임에서 사용되고 실제 컴파일 시에는 -L 옵션을 했다는 것이 생각 난다. 


다음과 같이 `-L` 옵션으로 검색할 디렉터리를 지정할 수 있다.  `-l` 옵션으로는  라이브러리를 지정한다. 

```
gcc -o test.o -L/path/to/custom/lib -ltest
```

빌드 설정파일을 변경하면 되지만 직접 관리하는 소스가 아닌경우 업데이트 시 매번 같은 작업을 해주어야 하기 때문에 환경 변수로 라이브러리 경로를 설정 하는 방법이 있으면 좋을 것 같다. [GCC manual](https://man7.org/linux/man-pages/man1/gcc.1.html) 페이지를 읽어 보니 컴파일 타임에 라이브러리(링커 파일)검색 할 때는 `LIBRARY_PATH` 변수를 설정해 주면 된다. `-L` 옵션으로 지정한 디렉터리가 우선시 된다. 


<!--more-->

### `LD_LIBRARY_PATH`

`LD_LIBRARY_PATH`는 프로그램 실행 타임에 동적 링커가 라이브러리를 조회 할때  사용된다. 


> A list of directories in which to search for ELF libraries at execution time.  The items in the list are separated by either colons or semicolons, and there is no support for escaping either separator.  A zero-length directory name indicates the current working directory.

### LIBRARY_PATH

컴파일 타임에서 라이브러랴(링커 파일) 검색 하기 위해 사용된다. 

> The value of LIBRARY_PATH is a colon-separated list of directories, much like PATH . When configured as a native compiler, GCC tries the directories thus specified when searching for special linker files, if it can't find them using GCC_EXEC_PREFIX . Linking using GCC also uses these directories when searching for ordinary libraries for the -l option (but directories specified with -L come first).
