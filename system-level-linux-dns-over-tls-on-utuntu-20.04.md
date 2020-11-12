# System Level Linux DNS over TLS on Ubuntu 20.04

## Prerequisite
*  stubby
* dnsmasq


## Installation

### stubby
```
sudo apt install stubby
```

#### Start and endable stubby
```
sudo systemctl enable stubby
sudo systemctl start stubby
```

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

```
sudo apt install dnsmasq
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

`/etc/resolv./conf`
```
nameserver 127.0.0.1
```

### With `Network Manager`
```
[main]
dns=dnsmasq
```

### systemd-resolv
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIzNzIwNjQ0Ml19
-->