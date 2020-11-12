# Insync 3.x auto start with xvfb and systemctl

## Prerequisites
* insync
* xvfb

## Systemctl script

### xvfb

Create a file `/home/euikook/.config/systemd/user/xvfb.service`
```
[Unit]
Description=X Virtual Frame Buffer Service
After=network.target

[Service]
ExecStart=/usr/bin/Xvfb :99 -screen 0 1024x768x24

[Install]
WantedBy=default.target
```

### Insync

Create a file `/home/euikook/.config/systemd/user/insync.service`
```
[Unit]
Description=insync on start up
After=xvfb.service

[Service]
Type=forking
Environment="DISPLAY=:99"
ExecStart=/usr/bin/insync start

[Install]
WantedBy=default.target
```

### Enable unit file

```
systemctl --user enable xvfb.service
systemctl --user enable insync.service
```


### Enable Lingering
```
loginctl enable-linger ${USER}
loginctl show-user ${USER} | grep Linger
```

### Post reboot
```
systemctl --user status xvfb.service
systemctl --user status insync.service
ps ef |grep insync
```