---
title: Development Environment per Project
link: /development-environment-per-project
description: 
status: draft
tags: [Linux, Arch, Arch Linux, devel, Development, Environment, Environment Variables]
---

# Development environment per project

## Motivation


## Development environments installed in project directory

`/home/$USER/test-project/.env`

### Example of environment file

```bash
TOP_DIR=$(dirname $(realpath $_))
. ${TOP_DIR}/venv/bin/activate
export LD_LIBRARY_PATH=${VIRTUAL_ENV}/lib
cd ${TOP_DIR}
```


### Append alias to shell 

`~/.aliases`
```
alias test-project-env=". ~/working/test-project/.env"
```

`~/.bashrc` or `~/.zshrc`

```
. ~/.aliases
```

Appply alias without restart shell
```
source ~/.aliases
```

onto `test-project` environment
```
test-project-env
```


## Using Docker 


### Create Docker image for development

```bash
docker build -t test-project-dev-env:latest .
```

### Run docker image for testing
```bash
docker run --rm -it  -v $(pwd):/apps test-project-devel bash
```