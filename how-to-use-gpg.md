---
title: GPG 사용하기
draft: false
tags: [GPG, Signing, PGP, OpenPGP, GnuPG, RSA, Cryptography, 공개키, 개인키]
banner: /images/many-locks.jpg
date: 2021-03-15 23:48:28 +0900
---


# GPG란 ?
GPG(GNU Privacy Cuard)는 GNU에서 제공하는 OpenPGP(RFC4880)의 오픈소스 구현이다. 

개인간, 머신간, 개인 - 머신간에 메시지나 파일을 암호화 하거나 파일이나 메시지에 서명을 추가 하여 변조 유무를 식별할 수 있게 해주는 도구이다. 

기본적으로 RSA와 같은 공개 키 암호화 방식을 사용하여 종단간 파일이나 메시지를 암호화 하거나 서명 하는 기능을 제공하는 것이다. 

GnuPG에 대한 자세한 내용은 [나무위키/GnuPG](https://namu.wiki/w/GnuPG) 또는 [위키피디아/GNU 프라이버시 가드](https://ko.wikipedia.org/wiki/GNU_%ED%94%84%EB%9D%BC%EC%9D%B4%EB%B2%84%EC%8B%9C_%EA%B0%80%EB%93%9C)를 참고 한다. 

PGP에 대한 내용은 [나무위키/PGP](https://namu.wiki/w/PGP) 또는 [위키피디아/PGP](https://ko.wikipedia.org/wiki/PGP_(%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4))를 참고 한다. 

이 문서에서는 GPG의 사용법에 대하여 설명 하도록 한다. 

공개 키 암호화 방식에 관한 내용은 [공개 키 암호화 방식이란?](/posts/what-is-public-key-cryptography/)을 참조한다. 


<!--more-->

## GPG 사용하기 

### Key Pair 생성

```
gpg --full-gen-key
```

* Please select what kind of key you want: `1`
* What keysize do you want? `4096`
* Key is valid for? `2y` 
* Is this correct? (y/N) `y`
* Real name: `John Doe`
* Email address: `john@acme.com`
* Comment: N/A
* Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? `O`


추가 정보
* `Real Name`은 개인, 회사 또는 제품의 이름으로 설정한다. 
* `Email address`는 키의 관리자의 이메일 주를 입력 한다. 
* `Comment`는 선택 적이며 회사, 부서, 키의 용도 또는 버전을 입력 하도록 한다. 

> 정보 확인 후 개인 키를 보호할 목적으로 `passphrase`(암호)를 입력하라는 프롬프트가 뜬다. 암호를 입력하고(또는 입력하지 않고) `OK`를 선택한다. Gnome과 같은 GUI를 사용하고 있다면 GUI 팝업이 뜰 수 있다. 

> 암호를 입력 하지 않으면 입호 입력을 권하는 경고 메시지가 뜬다. 암호 없이 키를 생성 하려면 `Yes, protection is not nedded`를 선택한다. 

> 경우에 따라서 암호 없기 키를 만들 수 없는 경우가 있다. 적당한 암호를 입력 하여 키를 생성하자 나중에 키에서 암호를 제거할 수 있다. 


아래는 키 생성에 대한 전체 예제이다. 

```
$ gpg --full-gen-key
```

```
gpg (GnuPG) 2.2.27; Copyright (C) 2021 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Thu 16 Mar 2023 11:12:08 AM KST
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: John Doe
Email address: john@acme.com
Comment: ACME Inc.
You selected this USER-ID:
    "John Doe (ACME Inc.) <john@acme.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: key B821C2E8600096BE marked as ultimately trusted
gpg: revocation certificate stored as '/home/euikook/.gnupg/openpgp-revocs.d/EFD634321C5A23B17A74AB6DB821C2E8600096BE.rev'
public and secret key created and signed.

pub   rsa4096 2021-03-16 [SC] [expires: 2023-03-16]
      EFD634321C5A23B17A74AB6DB821C2E8600096BE
uid                      John Doe (ACME Inc.) <john@acme.com>
sub   rsa4096 2021-03-16 [E] [expires: 2023-03-16]
```

### 키 확인 하기

```
gpg --list-key
```

```
gpg --list-keys
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   2  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 2u
gpg: next trustdb check due at 2023-03-16
/home/euikook/.gnupg/pubring.kbx
--------------------------------
pub   rsa4096 2021-03-16 [SC] [expires: 2023-03-16]
      EFD634321C5A23B17A74AB6DB821C2E8600096BE
uid           [ultimate] John Doe (ACME Inc.) <john@acme.com>
sub   rsa4096 2021-03-16 [E] [expires: 2023-03-16]

```


### Key에 서명하기

```
gpg --sign-key john@acme.com
```

### GPG 키 편집

```
gpg --edit-key john@example.com
```

`Yes, protection is not nedded`


### 개인 키에서 암호 변경/제거하기

```
gpg --list-keys
```

```
/home/john/.gnupg/pubring.kbx
--------------------------------
pub   rsa3072 2021-03-16 [SC]
      AA1AC070A86C0523A867C0261D3E87647AD3517E
uid           [ultimate] John Doe <john@example.com>
sub   rsa3072 2021-03-16 [E]
```


```
gpg --edit-key AA1AC070A86C0523A867C0261D3E87647AD3517E
```

`gpg>` 프롬프트가 뜨면 `passwd`를 입력하여 비밀번호를 변경한다. 


기존 비밀번호를 입력 하고 새로운 비밀번호를 입력한다. 암호를 제거 하려면 암호를 입력 하지 않고 `OK`를 선택한다. 

> 암호를 입력 하지 않으면 입호 입력을 권하는 경고 메시지가 뜬다. 암호 없이 키를 생성 하려면 `Yes, protection is not nedded`를 선택한다. 



### 공개 키 내보내기

타인에게 공개할 공개 키를 공유 하기 위해서는 키를 내보야 한다. `--export` 옵션을 사용하여 키를 내보낸다. 
기본적으로 키를 바이너리 형식으로 내보내지만 이를 공유 할 때 불편할 수 있다. `--armor` 옵션을 사용하여 키를 ASCII형식으로 출력한다. 

```
pg --export --armor --output john.pub john@acme.com
```

다른 사람들이 공개 키를 검증 하는 것을 허용 하려면 공개 키의 지문(fingerprint)도 같이 공유 한다. 

```
gpg --fingerprint john@acme.com
```

### 다른 사람의 공개 키 가져오기

공유 받은 공개 키를 가져온다. 

```
gpg --import john.pub
```

출력되는 정보와 가져오기한 키의 정보가 맞는지 확인한다. 

```
gpg: key B821C2E8600096BE: 1 signature not checked due to a missing key
gpg: key B821C2E8600096BE: public key "John Doe (ACME Inc.) <john@acme.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg: no ultimately trusted keys found
```

`--list-keys` 옵션으로 확인하자. 
```
gpg --list-keys
```

```
/home/jane/.gnupg/pubring.kbx
--------------------------------
pub   rsa4096 2021-03-16 [SC] [expires: 2023-03-16]
      EFD634321C5A23B17A74AB6DB821C2E8600096BE
uid           [ unknown] John Doe (ACME Inc.) <john@acme.com>
sub   rsa4096 2021-03-16 [E] [expires: 2023-03-16]
```

### 암호화 하기

암호화 할 파일을 생성한다. 

```
echo "This is plan text" > doc.txt
```

`doc.txt` 을 암호화 한다. 
```
gpg --encrypt --output doc.txt.gpg --armor --recipient john@acme.com doc.txt
```

`doc.txt` 을 암호화하고 개인 키로 서명한다. 서명에 사용될 키를 지정 해주지 않으면 기본 개인 키가 사용된다. 

> 개인 키가 없으면 에러가 발생한다. [Key Pair 생성](#Key-Pair-생성)를 참조 하여 키 쌍을 생성한다. 

```
gpg --encrypt --sign --output doc.txt.sign.gpg --armor --recipient john@acme.com doc.txt
```

* `--encrypt` 옵션을 이용하여 암호화 한다. `-e` 옵션으로 축약 할 수 있다. 
* `--sign` 옵션으로 signature를 생성한다. 자신의 개인 키로 서명을 한다. 복호화를 위해서는 서명에 사용한 개인 키에 대응되는 공개 키카 설치 되어야 한다. 
* `--output` 옵션을 이용하여 암호화된 결과물이 저장될 파일의 이름을 지정한다.
* `--armor` 옵션을 이용하여 ASCII 형식으로 내보낸다.
* `--recipient` 옵션으로 암호화에 사용될 공개 키를 지정한다. 
* `doc.txt` 암호화 하고자 하는 파일을 지정한다.


평문인 `doc.txt` 파일은 다음과 같다. 
```
This is plan text
```

암호화 된 파일인 `doc.txt.gpg`의 내용은 아래와 같다. 

```
-----BEGIN PGP MESSAGE-----

hQIMA21mHEvqjR9LARAAnqRsoDWnEvpMGzaLxW9Jp5ytSW6V8uimJo0TboUh5Ur6
PuNRAyQS3Dvll2CmIXg9i7yNjd4ameCm1eQSfL7b/D5yJcTrfRJX6D8clgFs2QIb
oqz3SGhzgx+bdAtY4yvO89+yhNHEFBQZHSE9tlh6lS4zXuZE745HWk+sECBKA1pm
Xz6XpvN7NUtF655lmvNlSE/fQ3yxptq6c5KHC29cJmc2VpHBuPs/42qt/rxWjTUd
FbWY1+IbroJq8VkEbPR9G/sHmaRyu+YhS0bud6orkJfeP0dMgexJBAxf8abXShIl
5xBcGW2NvoSSTqP6GoJXOnzcc+XXAhosun83uFdwx7Uv+qmqn4iN6HSeAujnsqCG
c+ZCKBPHCOig2qWBsj3CH3CLL7gjANuoJgS2W92KYmaUcbsDX5hZiIdmNEWjgQbV
eDW1TifqlVVLVo/r2h/cawHsYqLwhH+tJeziIqyROQaYYdrDc+SWyUd//eIQQfDn
QGJrAaf+qKvSW8h6GGmv4LztIYPqxpF2+zwu06lQIHg7VWUOhAZO00yxAlwh/scV
6sZjuXgWb5aJTmpVVexAaW6VJsGt92Uij5pVajmEkrgnBK2kvaBbl4ykRJ9w6FTv
BVgTS+tQFr1KS0NAaL7hV/VrPvgceR1bo62p9E7MqgPICTu7dvOBst9z/M15t9vS
UgGQsLcBmr73MIkaXFsEt1kOEm6iY/BSOvcp2FC5U7FD6yyyMLNaeKX9wnP1sA8M
phFmKzRpw7UG5lh3fesRE/z0ZboCxjSHEmbDMW7hnEo8fn0=
=3TXR
-----END PGP MESSAGE-----
```

암호화 후 서명된 파일인 `doc.txt.sign.gpg`의 내용은 아래와 같다. 서명이 포함되어 있어(개인키로 한번 더 암호화 되었기 때문에) 더 길다.

```
-----BEGIN PGP MESSAGE-----

hQIMA21mHEvqjR9LAQ/+Kn9oWh+Bcq4LOU3jAA2rgE0R4+i8yzTR6oh+VmjFkzbQ
ja1frjoqGoIEqnMiYGP13tDvg1LpAceX9JFB0OnihRTTjzrsqCK9WqbrZoXVn6UG
Dz4CbRjG+fe9+pNMS9rdkgRMLF0UBMSrhDWBcQwR5B8C9nvm1f8h/CTNfFM/4hvW
OewlXpMhylwrfXLY9Bf7cxBzWMpnC+Gxbukp1ORHKUsN46b/4SRZ7NzFbKP+TNWb
dOBe98j3dTPbhavPj/JlFcB/gfFdNmpIhLIiDKGJeZJrpQA8R/mekhgM9/mXrxhU
HUnKbUCqeGFE1foiizhAbs6PpksW5YoEQv/wjXJxE/YLNjgOrL+7JLif1+8jBhLO
lzc/wW4tpaIuc3aJZIqGUYJzgzlDnCihMb8jD9kWzdweUQAN0HTnP/PC9kAnQ98v
uHyORW53Ie/fhrGTSAObspkXqQ+1b5jgcLlk9LmK6tlyOMWvFHxjDeP0WrjPCWaA
zpQlNUmnn3SlWNXQEkKo53FqJkcDPujxW//nsiPreCuj995o+UeE9k0UPXsLCob+
RpA54rX3aTCRVKjF6H2yoXr8HWaL7MfDI8amA4aDRDnSWdNnr0DAplbn5dZJTLPj
vdxagGS759tEPZalrduP0R0lVyw3Ds6E4J9+hVstqlFnxbOroiGEZqzx1v7ArxvS
6QFtKoV5dLR9B9lr6ykoTgYQ79qB1h2OT9Y33IhfvyliGve49mCW3ScXBZxXGlmp
7om0xpWVymxbL6ReWUeBKlVGoOK/GexVFHUTyCTiO4XVMV+ueS+VP4cfWvXe7cGv
lyRvuE+s+hiz1Apv9xZ/mv/Z13kRWi55JDfYmxEBs8dI1I9albvXPSnZW3wjfRkZ
DpUj7hi2YAp8zYHFmrhPLRlVOZZPcNYjiQASY+DkKkxIPXoUrMvz6SboZzHhnLv2
wtVEAFBXza2uVSmD+Eflj6X3LWjUAMFke2UGzaXzbYhJXK/pu0UMCLwKfd9SI8hi
3DdmdG1OtqDPsXYF90zdI1IljyRvBWJZg27LGqieQB7xWFiZ5FKz9fYgmU3BTPRW
wN6S2DUbu1NjUjGtJN65KoRKbPs/k5RCHxbUAJkgS7vveWpy8zXFDngkvbIlldf/
sGNWdDPIh/Kb+2NUOKW4x/HfBW1J5J24mIjN+y2e1TXWdzN8Yn6wggxoM9i5rU9i
MrVPtXBHxFcxgBKGZRYf5L3a8zgwP72CcNkE7u09jktSOXz92tq+IgYwb/vYJJdV
fnZQ7WeUYN/LwkD7WG9bDhIzOd4G+hf6YpFz7ApZedO3QQCq6OOchZwwvNEUFTBx
8MeP+XT7fUOlSpUK2I89GyPKMXvNTuTPcpWJrHM54iX2nKl2tf43fCJM7HYxTP9C
SPpviIMr0EOPl/Ff5LM7PvYiiMWoQR6ZikxmS7ESMQEkvAGc3k9mGXBzJh+VexFX
DbCzidT/sbbAHY8N3aP66SH5c8OounCZip+5w08+c/r09JmDlWdM0qnlpdGPE9FT
A1MitGPxdZXk5+ihKyVuul5IlaJ8PcMAkZcodsyIbfe59BrwM5XHCoHP4CeBQg==
=KSvJ
-----END PGP MESSAGE-----
```

## *암호화(Encryption)* 와  *서명(Signing)*

*암호화(Encryption)* 와  *서명(Signing)* 에 대한 정리를 하고 넘어갈 필요가 있다. 

 GPG(GnuPG)에서는 *암호화(Encryption)* 와 *서명(Signing)* 이라는 두가지 용어를 사용하는 데 *암호화* 는 공개 키를 이용하여 암호화 하는 방법이고, *서명(Signing)* 은 개인 키를 이용하여 암호화 하는 방식이다.

> 암호화(暗號化) 또는 엔크립션(Encryption)은 특별한 지식을 소유한 사람들을 제외하고는 누구든지 읽어볼 수 없도록 알고리즘을 이용하여 정보(평문을 가리킴)를 전달하는 과정이다. (출처 - [위키피디아](https://ko.wikipedia.org/wiki/%EC%95%94%ED%98%B8%ED%99%94))

공개 키를 이용하여 암호화 하였을 경우 암호화에 사용된 (공개 키에 대응되는) 개인 키를 가진 사람만이 정보를 열람 할 수 있다. 개인 키를 소유한 사람만 정보를 열람 할 수 있으므로 *암호화(Encryption)* 한다.  

> 서명(署名, signature) 또는 사인(영어: sign)은 누군가의 이름, 가명, 또는 누군가가 문서에 기록했다는 증거, 자기 동일성을 위한 표시를 하기위해 쓴 것을 말한다. (출저 - [위키피디아](https://ko.wikipedia.org/wiki/%EC%84%9C%EB%AA%85))

그에 반해 개인 키를 이용하여 암호화는 공개 키를 가진 모든 사람(공개 키가 키 서버에 공개 되어 있다면 잠재적으로 누구든지)이 해당 정보를 열람 할 수 있으므로 *암호화(Encryption)* 의 정의와는 맞지 않는다. 개인 키를 통하여 암호화된 정보가 (개인 키에 대응되는) 공개 키로 복호화 된다는 것은 해당 정보의 출처가 (이 정보에 *서명(Signing)* 한 개인 키에 대응되는) 공개 키를 공개한 사람 이라는 것과 - 개인 키는 정보에 서명한 사람만 소유하고 있기 때문이다. - 데이터가 (작성자가 서명한 이후)변조 되않았다는 것을 증명한다. 따라서 개인 키로 암호화 하는 것을 *서명(Signing)* 이라고 한다. 


> 따라서 `--sign`옵션을 사용하면 *받는사람(Recipient)* 의 공개 키로 *암호화(Encryption)* 한 다음  암호화된 정보를  자신의 개인 키로 ~~*다시한번 암호화(Encryption)*~~ *서명(Signing)* 하는 것이다. 


> 참고 - [stackoverflow: how to encrypt a file using private key in gpg](https://stackoverflow.com/questions/14434343/how-to-encrypt-a-file-using-private-key-in-gpg/14434446)

### 복호화 하기

```
gpg --decrypt --output doc.txt.dec doc.txt.gpg
```

```
gpg --decrypt --output doc.txt.sign.dec doc.txt.sign.gpg
```

* `--decrypt` 옵션을 이용하여 복호화 한다. 
* `-output` 옵션을 이용하여 복호화된 결과물이 저장될 파일의 이름을 지정한다.
* `doc.txt.gpg` 복호화할 암호화 된 파일을 지정한다. 

> 서명이된 암호화 파일의 경우 서명한 사람의 공개 키가 설치 되어 있어야 정상적으로 복호화가 된다. 

복호화 제대로 되었는지 확인한다. 결과는 아래와 같다. 

```
This is plan text
```


## 공개 키 서버 사용하기 

이메일 주소를 기반으로 공개 키를 등록하고 받게 해주는 공개 키 서버가 있다. 

아래는 대표적인 키 서버 목록이다. 

* [PGP Global Dictionay](https://keyserver.pgp.com)
* [MIT Key Server](https://pgp.mit.edu)
* [OpenPGP Key Server](https://keys.openpgp.org)
* [Ubuntu Server](https://keyserver.ubuntu.com)


예제에서는 [OpenPGP Key Server](https://keys.openpgp.org)를 사용한다. 

### 키서버에 올리기

```
gpg --send-keys --keyserver keys.openpgp.org EFD634321C5A23B17A74AB6DB821C2E8600096BE
```

> 키를 등록하면 키 생성 시 입력한 메일 주소로 확인 메일이 온다. 설명에 따라 인증을 수행한다. 

### 키서버에서 공개 키 가저오기

```
gpg --keyserver pgp.mit.edu --search-keys john@acme.com
```

아래는 키를 받는 예제이다.

```
gpg --keyserver keys.openpgp.org --search-keys john@acme.com
```

위 명령을 수행하면 `john@acme.com` 와 관련된 공개 키 리스트가 나오고 키를 선택 하라는 프롬프트가 뜬다. 


```
Keys 1-1 of 1 for "euikook@gmail.com".  Enter number(s), N)ext, or Q)uit >
```
내려받고 싶은 키의 번호를 입력하면 키를 내려받아 키 저장소에 추가된다. 

아래는 euikook@gmail.com 으로 키를 검색하여 내려 받는 예제이다. 

```
$ gpg --keyserver keys.openpgp.org --search-keys euikook@gmail.com
gpg: data source: http://keys.openpgp.org:11371
(1)	euikook <euikook@gmail.com>
	  4096 bit RSA key 6FE1162F829A61EE, created: 2021-03-16
Keys 1-1 of 1 for "euikook@gmail.com".  Enter number(s), N)ext, or Q)uit > 1
gpg: key 6FE1162F829A61EE: public key "euikook <euikook@gmail.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```