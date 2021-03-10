---
title: Keep persistent SSH session using autossh and cron
link: /keep-ssh-session-using-autossh-and-cron
description: 
status: publish
tags: [Linux, SSH, autossh, cron, persistent, LocalForward, RemoteForward, Tunneling]
date: 2019-02-13
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/-X5FNFdq7Uw
aliases:
    - /keep-persistent-ssh-session-using-autossh-and-cron
    - /keep-persistent-ssh-session-using-autossh-and-cron.md
    - /gollum/keep-persistent-ssh-session-using-autossh-and-cron
    - /gollum/keep-persistent-ssh-session-using-autossh-and-cron.md
---

# Keep persistent SSH session using autossh and cron

## Background Knowledge

### SSH Tunneling

 * Local Port Forwarding: used to forward a port from the client machine to the server machine.
 * Remote Port Forwarding:


#### Local Port Forwarding

```
ssh -L [bind_addr:]port:target_addr:target_port user@server
```
* bind_addr
* port
* target_addr
* target_port
* user
* server

#### Remote Port Forwarding
```
ssh -R [bind_addr:]port:target_addr:target_port user@server
```
* bind_addr
* port
* target_addr
* target_port
* user
* server

<!--more-->

Please see [http://dirk-loss.de/ssh-port-forwarding.pdf](http://dirk-loss.de/ssh-port-forwarding.pdf)

<!--more-->

## Prerequisites

* autossh

```
sudo apt-get install autossh
```

## Server Side

### Add User for SSH tunneling
```
sudo adduser --system --shell /bin/false --gecos "Auto SSH" --disabled-password --home=/home/autossh autossh
```


### Generate SSH key
```
sudo -u autossh ssh-keygen -t rsa -b 4096 -f ~/.ssh/autossh
```

### Copy public key to ~/.ssh/authorized_keys
```
sudo -u autossh cp ~/.ssh/autossh.pub ~/.ssh/authorized_keys
```

### Append Follwing Configuration to /etc/ssh/sshd_config
{{< gist euikook c1379f45f645fec1457f521851eea099 "sshd_config" >}}

if did you want *Local Port Forwarding* please set *GatewayPorts* to *yes*.

```
Match User autossh
   ...
   GatewayPorts no
   ...
```

### Restart SSH daemon
```
sudo systemctl restart ssh
```

## Client Side

### Copy SSH private key to client host

```
scp 1.2.3.4/.ssh/autossh ~/.ssh/autossh
```

### Install autossh
```
sudo apt install autossh
```

### Add SSH Client Configurations

Append following config to ~/.ssh/config

Replace 1.2.3.4 to real IP or hostname

#### for Local Forwarding

*only allowed if **GatewayPort=yes** (default: no) in server configuration.*

{{< gist euikook c1379f45f645fec1457f521851eea099 "local.fwd.ssh.config" >}}

```
LocalForward 2222 localhost:22
```

#### for Remote Forwarding

{{< gist euikook c1379f45f645fec1457f521851eea099 "remote.fwd.ssh.config" >}}

```
RemoteForward** 2222 localhost:22
```


### Test SSH connection

```
autossh -M 0 -f -N autossh
```

### Verify SSH Connection
Check listen port in your system.

#### for Local Port Forward (in Server)
```
netstat -lnt
```

#### for Remote Port Forward (in Client)
```
netstat -lnt
```

```
ps aux |grep autossh
```

### Copy autossh-bot to ~/bin
```
mkdir -p ~/bin
cp ./bin/auto-ssh-bot ~/bin
```


### Register cron job
```
crontab -e
```

Schedule cron job to every 5 minutes


```
0/5 * * * * ~/bin/auto-ssh-bot
```
