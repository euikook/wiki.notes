---
title: Usages of SSH key pair
link: /usages-of-ssh-key-pair
description: 
status: publish
tags: [Linux, SSH, Key, Key pair]
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/random/800x400
aliases:
    - /gollum/usages-of-ssh-key-pair
    - /gollum/usages-of-ssh-key-pair.md
---

# Usages of SSH key pair

## Generate SSH key pair

`ssh-keygen`

```
ssh-keygen -t rsa -b 4096 -f test
```

* `test.pub`: Public Key
* `test`: Private Key


## Use key 

### Copy to remote system

Copy Public key to `$REMOTE_HOST`

```
ssh-copy-id $USER@$REMOTE_HOST -i test
```

or, if there is no public key in remote host

```
scp ~/.ssh/test.pub $USER@$REMOTE_HOST:.ssh/authorized_keys
```

### Login use Private Key
ssh $USER@$REMOTE_HOST -i .ssh/test


### ./ssh/config

Edit `~/.ssh/config` as following.

```
Host 1.2.3.4 test
    Hostname 1.2.3.4
    User username
    Port 22
    SendEnv LANG LC_*
    IdentityFile ~/.ssh/test
```

Connect remote system using `ssh` command
```
ssh test
```