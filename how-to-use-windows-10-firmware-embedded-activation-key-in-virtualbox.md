---
title: Virtualbox에서 Windows 10 Firmware Embedded Activation Key 사용하기
date: 2021-04-06 14:35:59 +0900
draft: true
---

리눅스를 기본 OS로 사용하고 있다. 간단한 문서 작업은 리눅스상에서고 할수 있지만 MS Word나 PowerPoint를 사용해야 하는 경우 어쩔 처럼 Windows를 사용햐야 되는일이 생긴다. 

Windows가 필요한 작업을 할때면 VirtualBox에 설치 해 놓은 Widnows를 사용한다. 

정품 인증을 위해서 회사의 볼륨라이센스를 이용하는게 아니라면 라이센스를 구매 해야 하는데 그 비용이 만만치 않다.

필자의 경우 사용하는 Laptop에 OEM으로 딸려온 Windows 키가 있어 활용하는 방법을 찾아 보았다. 


요즘에는 Activation Key가 예전 처럼 Laptop 뒤에 스티커로 붙어 있는 것이 아니라 펌웨어에 내장되어 있다. 


먼저 펌웨어에 내장되어 있는 Activation Key를 확인 해 본다. 

Retrieve Firmware Embedded Activation Key

```
sudo tail -c +56 /sys/firmware/acpi/tables/MSDM
```

<!--more-->

위 명령을 실행 하였을 때 다음과 같은 에러가 발생하면 펌웨어에 내장된 Activation Key가 없는 것이다. 새로운 키를 구매 하여야 한다. 

```
tail: cannot open '/sys/firmware/acpi/tables/MSDM' for reading: No such file or directory
```

```
sudo cat /sys/firmware/acpi/tables/MSDM > ~/VirtualBox\ VMs/<vm-name>/msdm.bin

VBoxManage setextradata <vm-name> \
               "VBoxInternal/Devices/acpi/0/Config/CustomTable" \
               ~/VirtualBox\ VMs/win10/msdm.bin
```

## References

* [Answer for "Install Windows 10 from an unbooted OEM drive into Virtualbox?"](https://superuser.com/a/1329935)