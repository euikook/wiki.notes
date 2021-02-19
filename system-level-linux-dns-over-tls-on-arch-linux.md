---
title: System Level Linux DNS over TLS on Arch Linux
link: /system-level-linux-dns-over-tls-on-arch-linux
description: 
status: publish
tags: [Linux, Arch, DNSSEC, DNS, TLS, DNS-over-TLS]
date: 2020-11-12 12:37:16 +0900
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/0Yiy0XajJHQ
aliases:
    - /gollum/system-level-linux-dns-over-tls-on-arch-linux
    - /gollum/system-level-linux-dns-over-tls-on-arch-linux.md
---

# System Level Linux DNS over TLS on Arch Linux

## Prerequisite
*  stubby
* dnsmasq


## Installation

### stubby
```
sudo pacmas -S stubby
```
#### Start and endable stubby
```
sudo systemctl enable stubby
sudo systemctl start stubby
```

<!--more-->

#### Configuration

Open and edit `/etc/stubby/stubby.yml`

```
listen_addresses:
  - 127.0.0.1@53000
  - 0::1@53000
```
```
upstream_recursive_servers:
  - address_data: 9.9.9.9
    tls_auth_name: "dns.quad9.net"
  - address_data: 9.9.9.10
    tls_auth_name: "dns.quad9.net"
  - address_data: 1.1.1.1
    tls_auth_name: "cloudflare-dns.com"
  - address_data: 1.0.0.1
    tls_auth_name: "cloudflare-dns.com"
```

### dnsmasq

#### Arch Linux based distribution

```
sudo pacmas -S dnsmasq
```
#### Start and endable stubby
```
sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
```

#### Configurations

Open and edit `/etc/dnsmasq.conf`
```
no-resolv
proxy-dnssec
server=::1#53000
server=127.0.0.1#53000
listen-address=::1,127.0.0.1
```

## Use dnsmasq as default DNS 

### Common Usages

Open and edit `/etc/resolv./conf`
```
nameserver 127.0.0.1
```

### With `NetworkManager`
```
[main]
dns=dnsmasq
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0NTg0MzgyNDddfQ==
-->