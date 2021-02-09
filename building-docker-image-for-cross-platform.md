---
title: Building Docker Image for Cross Platform(ARM64, ARM)
link: /building-docker-image-for-cross-platform
description: 
status: publish
tags: [Linux, CI, CD, CI／CD, Docker, Container, Compose, docker-compose, Cross Platform, ARM,]
date: 2020-11-16 09:37:41 +0900
banner: /images/docker-banner.png
---
 
 # Building Docker Image for Cross Platform
arm64 머신과 x86 머신에서 동작해야 하는 프로젝트를 진행하게 되었다. 동일한 소스 트리를 유지하지 위해  하나의 아키텍처로 작업하는 경우 보다 더 많은 노력이 팔요하지만 프로젝트 진행 중 가장 귀찮(~~짜증나는~~)은 작업은 테스트를 위해 arm64과 x86 머신에서 이미지를 따로 빌드 해야 하는 것이었다.

개발 서버(PC)에서 ARM 이미지를 빌드 하는 방법을 찾던 중 qemu의 arm emulation 기능을 이용하여 x86 머신에서 arm용 Docker 이미지를 Cross Build 하는 방법을 찾아 공유한다.

## Install Docker

```
sudo apt update
sudo apt dist-upgrade
```

```
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
```

And add current user to docker group

```
sudo usermode -aG docker $USER
```


## Install `buildx` for multi-architecture image build

`DOCKER_CLI_EXPERIMENTAL` 옵션이 Enabled 되어 있어야 사용할 수 있다. 아래와 같이 환경변수를 설정해 주면 된다.

```
export DOCKER_CLI_EXPERIMENTAL=enabled
```

아니면 ~/.docker/config.json 파일에 아래와 같이 `"experimental": "enabled"`추가 하자.
```
{
	"auths": {
		"https://index.docker.io/v1/": {
			"auth": "******************"
		}
	},
	"HttpHeaders": {
		"User-Agent": "Docker-Client/19.03.12 (linux)"
	},
	"experimental": "enabled"
}
```

## Download a buildx binary release
다음 사이트에서 최신 바이너리를 다운 받아 `~/.docker/cli-plugin` 디렉터리에 넣는다.

```
mkdir -p ~/.docker/cli-plugin
curl https://github.com/docker/buildx/releases/download/v0.4.2/buildx-v0.4.2.linux-amd64 > ~/.docker/cli-plugin/docker-buildx
chmod +x ~/.docker/cli-plugin/docker-buildx
```


### Enable ARM Cross Build 

ARM을 활용하여 적당한 빌드 시스템을 구성하기가 어렵다. 라즈베리 파이(Raspberry Pi)등으로 빌드 머신을 만들 있지만 낮은 성능으로 인해 하루종일 이미지만 빌드 하는 체험을 할 수 있다. x86 시스템을 이용하여 Cross Build 하는 것이 더 빠른 경우가 더 많다. 

아래와 명령을 실행하여 ARM Emulation 기능을 Enable하자.

```
docker run --rm --privileged linuxkit/binfmt:v0.8
```

아래와 명령을 통해 기능을 확인한다.

```
cat /proc/sys/fs/binfmt_misc/qemu-aarch64
```

다음과 비슷한 결과가 나온다
```
enabled
interpreter /usr/bin/qemu-aarch64
flags: OCF
offset 0
magic 7f454c460201010000000000000000000200b7
mask ffffffffffffff00fffffffffffffffffeffff
```


## Create Multi-Architecture build instance

### Using QUEM Emulation
빌드 환경을 구성한다.

```
docker buildx create --name cross
docker buildx use cross
docker buildx inspect --bootstrap
```
```
Name:   cross
Driver: docker-container

Nodes:
Name:      cross-builder0
Endpoint:  unix:///var/run/docker.sock
Status:    running
Platforms: linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```

### Using Native Build Machine
성능 좋은 ARM용 빌드 머신이 있는 경우 해당 빌드 머신을 사용하면 된다. 

편의상 ARM용 빌드 머신을  `build-arm` 이라고 하자

~/.ssh/config 파일을 열어 다음과 같이 접속 정보를 추가 한다.

IP 주소인 `1.2.3.4` 와 Username `user`는 환경에 맞게 수정한다. 

```
Host build-arm 1.2.3.4
    Hostname 1.2.3.4
    User user
    Port 22
    SendEnv LANG LC_*
    IdentityFile ~/.ssh/build-arm
    ConnectTimeout 0
    HashKnownHosts yes
    GSSAPIAuthentication yes
    GSSAPIDelegateCredentials no
```

`ssh-keygen` 명령을 통해 ssh key를 생성한다.

```
ssk-keygen -t ras -b 4096 -f build-arm
```

Public Key를 `build-arm`으로 복사한다. 
```
cp build-arm.pub build-arm:.ssh/authorized_keys
```

Private 파일을 `~/.ssh` 디렉터리도 복사한다.
```
ssh build-arm ~/.ssh/build-arm
```

Passowrd 없이 접속 되는지 확인한다.

```
ssh build-arm
```

#### Create `buildx` instance
먼저 `build-arm` 머신에 대한 docker context를 생성한다.
```
docker context create build-arm --docker "host=ssh://build-arm"
```

빌드 머신`build-arm`을 `buildx` instance에 추가 한다.
```
docker buildx create --append --name cross-builder build-arm
```

## Build Docker images
이제 buildx 확장을 명령을 이용하여 Docker 이미지를 생성해 보자.


아래는 테스트에 사용될 Dockerfile 예제이다. 
```
FROM alpine:edge
LABEL maintainer="E.K. KIM euikook@gmail.com"

COPY apps /apps
WORKDIR  /apps
```

buildx를 이용하여 이미지를 빌드한다. 아래 예제는 `linux/arm64`,`linux/amd64` Architecture에 사용가능한 이미지를 생성하는 예이다. 적용 가능한 Platform 은 `docker buildx inspect` 명령으로 확인 하였을 때 `Platforms`에 나열되어있는  Platform만 가능하다.

```
docker buildx build --push --platform linux/arm64,linux/amd64 --tag euikook/multi-arch-test:latest .
```

위 buildx build 명령은 --push 옵션과 같이 사용해야 된다. 당연하게도 위 명령이 로컬 이미지를 생성하지는 않는다. 따라서 생성된 이미지를 테스트 하기 위해서는 docker pull 명령으로 이미지를 다운로드 받아야 한다.

docker pull euikook/multi-arch-test:latest
이게 이미지가 로컬 머신에 없으면 상관 없는데 docker build 나 docker-compose build명령으로 이미지를 생성한 다음 buildx 명령으로 이미지를 생성한 경우 docker pull 명령으로 이미지를 명시적으로 다운받지 않으면 이전에 생성했던 이미지가 실행되어 원하는 결과을 얻을 수 없다.

[여기](https://hub.docker.com/r/euikook/multi-arch-test/tags)를  방문하면 linux/amd64, linux/arm64 이미지를 확인 할 수 있다.



## References
* https://docs.docker.com/buildx/working-with-buildx/
* https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/

 