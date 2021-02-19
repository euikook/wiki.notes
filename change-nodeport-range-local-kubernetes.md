---
title: Change NodePort range local kubernetes
link: /change-nodeport-range-local-kubernetes
description: 
status: publish
tags: [Linux, Docker, Kubernetes, k8s, nodeport]
created: 2018-01-29
date: 2020-11-16 09:37:41 +0900
banner: /images/k8s-banner.png
aliases:
    - /gollum/change-nodeport-range-local-kubernetes
    - /gollum/change-nodeport-range-local-kubernetes.md
---

#### Change NodePort range local kubernetes

Add following line to add following line to _/etc/kubernetes/manifests/kube-apiserver.yaml_
    
```bash
- --service-node-port-range=80-32767
```

## Examples
    
```bash
sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
```

```bash
- --advertise-address=172.168.2.11
- --service-cluster-ip-range=10.96.0.0/12
- --service-node-port-range=80-32767
- --client-ca-file=/etc/kubernetes/pki/ca.crt
```