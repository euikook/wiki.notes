---
title: GPG(GnuPG) 사용하기
draft: false
tags: [GPG, Signing, PGP, OpenPGP, GnuPG, RSA, Cryptography, 공개키, 개인키]
banner: /images/many-locks.jpg
date: 2021-03-15 23:48:28 +0900
lastmod: 2021-03-16 04:50:04 +0900
---

OpenPGP의 GNU 구현인 GPG(GnuPG)와 그 사용법에 대하여 알아보자.

## GPG란?
GPG(GNU Privacy Cuard)는 GNU에서 제공하는 OpenPGP(RFC4880)의 오픈소스 구현이다. 

개인간, 장비간 또는 개인 - 장비간에 교환되는 메시지나 파일을 암호화여 기밀성을 보장하거나 디지털 서명을 통해 무결성을 식별할 수 있게 해주는 도구다. 

기본적으로 RSA와 같은 [공개 키 암호화 방식](/posts/what-is-public-key-cryptography/)을 사용하여 종단간 파일이나 메시지를 암호화 하거나 서명 하는 기능을 제공한다. 

GnuPG에 대한 자세한 내용은 [나무위키/GnuPG](https://namu.wiki/w/GnuPG) 또는 [위키피디아/GNU 프라이버시 가드](https://ko.wikipedia.org/wiki/GNU_%ED%94%84%EB%9D%BC%EC%9D%B4%EB%B2%84%EC%8B%9C_%EA%B0%80%EB%93%9C)를 참고 한다. 

PGP에 대한 내용은 [나무위키/PGP](https://namu.wiki/w/PGP) 또는 [위키피디아/PGP](https://ko.wikipedia.org/wiki/PGP_(%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4))를 참고 한다. 

이 문서에서는 GPG의 사용법에 대하여 설명 하도록 한다. 

공개 키 암호화 방식에 관한 내용은 [공개 키 암호화 방식이란?](/posts/what-is-public-key-cryptography/)을 참조한다. 


<!--more-->

## GPG 사용하기 

### Key Pair 생성

```console
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

`--edit-key` 옵션으로 생성된 키의 정보를 수정할 수 있다. 
```
gpg --edit-key john@example.com
```

위 명령을 수행 하면 `gpg>` 프롬프트가 뜬다. `?` 입력하면 입력 가능한 명령이 나온다. 

`adduid` 명령으로 `uid`를 추가 할 수 있다. 

편집이 완료 되었으면 `quit` 명령으로 프로그램을 종료 한다. 


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


## GPG 폐기 인증서(Revocation Certificate) 생성

Key Pair를 생성한 후 폐기 인증서를 만들어야 한다. 명시적으로 키를 폐기 하고자 할때 만들어도 되지만 개인 키가 손상되었거나 분실하였을 경우 폐기 인증서를 만들 수 없기 때문에 미리 만들어서 안전한 곳에 보관한다. 


> 폐기 인증서는 언제 만든어야 할까? 키 생성 후 바로 생성 하는 것이 좋은 방법이다. 폐기 인증서를 만든다고 키가 바로 폐기 되는것이 아니기 때문이다. 이렇게 만들어 놓은 폐기 인증서는 암호를 잊어 버리거나, 키를 분실한 경우 키를 안전하게 폐기 할 수 있는 방법을 제공한다. 


```
gpg --output john.revoke.asc --gen-revoke john@acme.com
```


아래는 폐기 인증서를 만든 전체 과정이다. 

```
gpg --output euikook.revoke.asc --gen-revoke john@acme.com

sec  rsa4096/B821C2E8600096BE 2021-03-16 John Doe (ACME Inc.) <john@acme.com>

Create a revocation certificate for this key? (y/N) y
Please select the reason for the revocation:
  0 = No reason specified
  1 = Key has been compromised
  2 = Key is superseded
  3 = Key is no longer used
  Q = Cancel
(Probably you want to select 1 here)
Your decision? 0
Enter an optional description; end it with an empty line:
> 
Reason for revocation: No reason specified
(No description given)
Is this okay? (y/N) y
ASCII armored output forced.
Revocation certificate created.

Please move it to a medium which you can hide away; if Mallory gets
access to this certificate he can use it to make your key unusable.
It is smart to print this certificate and store it away, just in case
your media become unreadable.  But have some caution:  The print system of
your machine might store the data and make it available to others!
```

폐기 인증서만 있다면 누구든지 공개키를 폐기할 수 있으므로 안전한 곳에 보관 하여야 한다. 

키를 폐기 하는 방법은 [키 폐기(Revocation) 하기](#키-폐기revocation-하기)를 참고한다. 

### 공개 키 내보내기

타인에게 공개할 공개 키를 공유 하기 위해서는 키를 내보야 한다. `--export` 옵션을 사용하여 키를 내보낸다. 
기본적으로 키를 바이너리 형식으로 내보내지만 이를 공유 할 때 불편할 수 있다. `--armor` 옵션을 사용하여 키를 ASCII형식으로 출력한다. 

```
gpg --export --armor --output john.pub john@acme.com
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

### 개인 키(비밀 키) 내보내기/가저오기
여러대의 머신에서 같은 개인키를 사용하고 싶거나 개인 키를 생성한 다음 백업 하고자 하는 경우 개인 키를 내보내야 한다.  

`--export-secret-key` 옵션을 이용하여 키를 내보내자. 

`--export-options export-backup`을 사용하여 키를 복원하는데 필요한 다른 정보도 같이 내보내자. 

```
gpg --output john.secret.gpg --armor \
--export-secret-key --export-options export-backup john@acme.com
```

다른 PC로 `john.secret.gpg` 파일을 복사 한후 `--import` 옵션으로 가저오자.

> 개인 키는 유출되면 치명적이므로 안전하게 보관하자.

```
gpg --import john.secret.gpg
```

개인 키는 유출되면 치명적이므로 가저오기 이후 바로 안전하게 삭제한다.


`shred` 명령을 사용하여 안전하게 삭제한다. 

```
shred -zvu -n  5 john.secret.gpg
```

아래는 예제 출력이다. 
```
shred: john.secret.gpg: pass 1/6 (random)...
shred: john.secret.gpg: pass 2/6 (000000)...
shred: john.secret.gpg: pass 3/6 (random)...
shred: john.secret.gpg: pass 4/6 (ffffff)...
shred: john.secret.gpg: pass 5/6 (random)...
shred: john.secret.gpg: pass 6/6 (000000)...
shred: john.secret.gpg: removing
shred: john.secret.gpg: renamed to 000000000000000
shred: 000000000000000: renamed to 00000000000000
shred: 00000000000000: renamed to 0000000000000
shred: 0000000000000: renamed to 000000000000
shred: 000000000000: renamed to 00000000000
shred: 00000000000: renamed to 0000000000
shred: 0000000000: renamed to 000000000
shred: 000000000: renamed to 00000000
shred: 00000000: renamed to 0000000
shred: 0000000: renamed to 000000
shred: 000000: renamed to 00000
shred: 00000: renamed to 0000
shred: 0000: renamed to 000
shred: 000: renamed to 00
shred: 00: renamed to 0
shred: john.secret.gpg: removed
```

또는 `wipe` 먕량을 사용한다. 

```
wipe -rfiv john.secret.gpg
```

아래는 예제 출력이다. 
```
wipe: destroy file `john.secret.gpg'? y
john.secret.gpg: 100%
```

`wipe` 명령이 없으면 설치 한다.


Debian 기반인 경우 
```
sudo apt-get install wipe 
```

Redhat 기반인 경우
```
sudo yum install wipe
```

ArchLinux 기반인 경우 
```
sudo pacman -S wipe
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

`doc.txt` 을 개인 키로 서명하고 암호화 한다. 서명에 사용될 키를 지정 해주지 않으면 기본 개인 키가 사용된다. 

> 개인 키가 없으면 에러가 발생한다. [Key Pair 생성](#Key-Pair-생성)를 참조 하여 키 쌍을 생성한다. 

```
gpg --encrypt --sign --output doc.txt.sign.gpg --armor --recipient john@acme.com doc.txt
```

* `--encrypt` 옵션을 이용하여 암호화 한다. `-e`로 축약할 수 있다. 
* `--sign` 옵션으로 signature를 생성한다. 자신의 개인 키로 서명을 한다. 복호화를 위해서는 서명에 사용한 개인 키에 대응되는 공개 키카 설치 되어야 한다. `-s`로 축약할 수 있다. 
* `--output` 옵션을 이용하여 암호화된 결과물이 저장될 파일의 이름을 지정한다. `-o`로 축약 할 수 있다. 
* `--armor` 옵션을 이용하여 ASCII 형식으로 내보낸다. `-a`로 축약할 수 있다. 
* `--recipient` 옵션으로 암호화에 사용될 공개 키를 지정한다. `-r`로 축약할 수 있다. 
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

서명후 암호화된 파일인 `doc.txt.sign.gpg`의 내용은 아래와 같다. (개인 키로)서명된 파일을 암호화 했기 때문에) 더 길다.

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


> 따라서 `--sign`옵션을 사용하면 개인키로 ~~*암호화(Encrypt)*~~ *서명(Signing)* 한 다음 *받는사람(Recipient)* 의 공개 키로 ~~한번 더~~ *암호화(Encryption)* 하는 것이다. 


> 참고 - [stackoverflow: how to encrypt a file using private key in gpg](https://stackoverflow.com/questions/14434343/how-to-encrypt-a-file-using-private-key-in-gpg/14434446)


`--list-packets` 옵션으로 암호회된 데이터의 순서를 보면 암호화가 먼저 되었는지 서명이 먼저 되었는지 확일 할 수 있다. 


머신에 `john@acme.com `의 개인 키와 공개키가 모두 있다면 아래와 같이 실행 해보자. 

```
echo 'this is plain text' | gpg -r john@acme.com --encrypt --sign   | gpg --list-packets
```


다음은 예제 출력이다. 
```
gpg: encrypted with 4096-bit RSA key, ID EC736BC8E36D823D, created 2021-03-17
      "John Doe (ACME Inc.) <john@acme.com>"
# off=0 ctb=85 tag=1 hlen=3 plen=524
:pubkey enc packet: version 3, algo 1, keyid EC736BC8E36D823D
	data: [4093 bits]
# off=527 ctb=d2 tag=18 hlen=2 plen=0 partial new-ctb
:encrypted data packet:
	length: unknown
	mdc_method: 2
# off=548 ctb=a3 tag=8 hlen=1 plen=0 indeterminate
:compressed packet: algo=2
# off=550 ctb=90 tag=4 hlen=2 plen=13
:onepass_sig packet: keyid 70278B7766602624
	version 3, sigclass 0x00, digest 10, pubkey 1, last=1
# off=565 ctb=cb tag=11 hlen=2 plen=25 new-ctb
:literal data packet:
	mode b (62), created 1615965739, name="",
	raw data: 19 bytes
# off=592 ctb=89 tag=2 hlen=3 plen=578
:signature packet: algo 1, keyid 70278B7766602624
	version 4, created 1615965739, md5len 0, sigclass 0x00
	digest algo 10, begin of digest 9e d9
	hashed subpkt 33 len 21 (issuer fpr v4 4D4E4059E7068A5C703C898E70278B7766602624)
	hashed subpkt 2 len 4 (sig created 2021-03-17)
	hashed subpkt 28 len 13 (signer's user ID)
	subpkt 16 len 8 (issuer key ID 70278B7766602624)
	data: [4095 bits]
```

가장 처음이 `gpg: encrypted with 4096-bit RSA key`시작 하는것으로 보아 서명된 파일이 암호화 되었다는 것을 알 수 있다. 

> 개인 키가 여러개여서 기본으로 지정된 개인 키가 아니라 특정 개인 키를 지정 하고 싶다면 `--local-user` 옵션으로 서명에 사용될 `USER-ID`나 개인 키의 `KEY-ID`를  지정할 수 있다. 

> 서명에 사용될 `USER-ID`를 지정하지 않으면 secret keyring에서(`--list-secret-keys` 옵션을 사용했을 때) 가정 먼저 나오는 `USER-ID`가 선택된다.


### 복호화 하기

```
gpg --decrypt --output doc.txt.dec doc.txt.gpg
```

```
gpg --decrypt --output doc.txt.sign.dec doc.txt.sign.gpg
```

* `--decrypt` 옵션을 이용하여 복호화 한다.  `-d`로 축약할 수 있다. 
* `-output` 옵션을 이용하여 복호화된 결과물이 저장될 파일의 이름을 지정한다. `-o`로 축약할 수 있다.
* `doc.txt.gpg` | `doc.txt.sign.gpg` 복호화할 암호화 된 파일을 지정한다. 

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


## 키 폐기(Revocation) 하기

키 서버에서 키를 삭제 하기 위해서는 [폐기 인증서(Revocation Certificate)](#gpg-폐기-인증서revocation-certificate-생성)를 먼저 만들어야 한다. 


키를 폐기 하더라도 폐기 전에 했던 서명들은 유효하다. 마찬가지로 폐기된 비밀키에 접근 가능하다면 폐기 전 수신했던 폐기된 공개키로 암호화 된 메시지도 복호화 할 수 있다. 

`--import` 옵션으로 폐기 인증서를 가저 온다. 

```
gpg --import john.revoke.asc 
```

```
gpg: key B821C2E8600096BE: "John Doe (ACME Inc.) <john@acme.com>" revocation certificate imported
gpg: Total number processed: 1
gpg:    new key revocations: 1
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   3  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 3u
gpg: next trustdb check due at 2023-03-16
```

정상적으로 폐기 되었다. 


`--list-keys` 와 `--list-secret-keys` 옵션으로 키가 정상적으로 폐기 되었는지 확인한다. 

```
gpg --list-keys
```

```
pub   rsa4096 2021-03-16 [SC] [revoked: 2021-03-16]
      EFD634321C5A23B17A74AB6DB821C2E8600096BE
uid           [ revoked] John Doe (ACME Inc.) <john@acme.com>

```

**`pub   rsa4096 2021-03-16 [SC] [revoked: 2021-03-16]`** 

```
gpg --list-secret-keys
```
```
sec   rsa4096 2021-03-16 [SC] [revoked: 2021-03-16]
      EFD634321C5A23B17A74AB6DB821C2E8600096BE
uid           [ revoked] John Doe (ACME Inc.) <john@acme.com>

```

**`uid           [ revoked] John Doe (ACME Inc.) <john@acme.com>`** 


이제 공개키가 폐기 되었다는 것을 다른 사람에게 알릴 필요가 있다. 패기 인증서를 공개키를 공유한 사람에게 전송한다. 

### 공개키 서버에 폐기된 공개 키 보내기


`--send-keys`  옵션으로 키가 폐기 되었다는 것을 알린다. 
```
gpg --send-keys --keyserver keys.openpgp.org EFD634321C5A23B17A74AB6DB821C2E8600096BE
```

폐기 후 키를 다시 [생성 하고](#key-pair-생성) 공개키를 [키서버에 올리자](#키서버에-올리기).


## 키서버에서 키 갱신 하기 

서명된 파일을 받았는데 폐기된 키를 가지고 있어 검증 할 수 없는 경우 보낸 사람에서 새로운 공개 키를 공유 받거나 키 서버에서 키를 갱신 하여야 한다. 

`--refresh-key` 옵션으로 키를 갱신한다. `--key-server` 옵션으로 키 서버를 지정할 수 있다.

```
gpg --refresh-keys --key-server keys.openpgp.org
```