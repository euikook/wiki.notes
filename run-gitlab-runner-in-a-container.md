---
title: Run Gitlab Runner in a container
link: /run-gitlab-runner-in-a-container
description: 
status: publish
tags: [Linux, Gitlab, CI, CD, CI／CD, Docker, Container, Compose, docker-compose]
date: 2020-11-16 09:37:41 +0900
banner: /images/gitlab-ci-cd-banner.png
aliases:
    - /gollum/run-gitlab-runner-in-a-container
    - /gollum/run-gitlab-runner-in-a-container.md
---
# Run Gitlab Runner in a container

## Prerequisites
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

## Usages

### Clone Repository

```
git clone https://gitlab.com/euikook/gitlab-runner-compose.git
```

###  Configuration
* Replace *CI_SERVER_URL* value with your Gitlab server e.g. https://gitlab.com
* [Obtain a token](https://docs.gitlab.com/ee/ci/runners/) for a shared or specific Runner via GitLab’s interface and replace *REGISTRATION_TOKEN* value

```
tee .env << END
CI_SERVER_URL=https://gitlab.com/
REGISTRATION_TOKEN=zDsz34JuZf95NoBaQPX
END
```

### Registration and run gitlab-runner

```
docker-compose up -d
```

# References
* [https://docs.gitlab.com/ee/ci/runners/](https://docs.gitlab.com/ee/ci/runners/)
* [https://docs.gitlab.com/runner/install/docker.html](https://docs.gitlab.com/runner/install/docker.html)
* [https://dev.to/imichael/this-one-trick-gives-you-unlimited-ci-minutes-on-gitlab-e92](https://dev.to/imichael/this-one-trick-gives-you-unlimited-ci-minutes-on-gitlab-e92)
