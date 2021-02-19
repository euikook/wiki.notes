---
title: git fetch all branches and push it to another remote
link: /gpg-error-on-ubuntu
author: euikook
description: 
status: publish
tags: [Linux, Ubuntu, GPG, ERROR]
created: 2020-11-12
date: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/random/800x400
aliases:
    - /gollum/gpg-error-on-ubuntu
    - /gollum/gpg-error-on-ubuntu.md
---

# Fix GPG Error on Ubuntu
```
$ sudo apt update
...
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: https://packages.gitlab.com/gitlab/gitlab-ee/ubuntu bionic InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 3F01618A51312F3F
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: https://packages.gitlab.com/runner/gitlab-runner/ubuntu bionic InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 3F01618A51312F3F
W: Failed to fetch https://packages.gitlab.com/gitlab/gitlab-ee/ubuntu/dists/bionic/InRelease  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 3F01618A51312F3F
W: Failed to fetch https://packages.gitlab.com/runner/gitlab-runner/ubuntu/dists/bionic/InRelease  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 3F01618A51312F3F
W: Some index files failed to download. They have been ignored, or old ones used instead.
euikook@argentum:/etc/apt/sources.list.d$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3F01618A51312F3F
Executing: /tmp/apt-key-gpghome.SpBMyBEzT0/gpg.1.sh --keyserver keyserver.ubuntu.com --recv-keys 3F01618A51312F3F

```

## Import GPG key from key server
```
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3F01618A51312F3F
Executing: /tmp/apt-key-gpghome.SpBMyBEzT0/gpg.1.sh --keyserver keyserver.ubuntu.com --recv-keys 3F01618A51312F3F
gpg: key 3F01618A51312F3F: public key "GitLab B.V. (package repository signing key) <packages@gitlab.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```

```
$ sudo apt update
Hit:3 https://download.docker.com/linux/ubuntu bionic InRelease                                                                                                                                                                   
Hit:5 http://ppa.launchpad.net/certbot/certbot/ubuntu bionic InRelease                                                                            
Hit:6 http://archive.ubuntu.com/ubuntu bionic InRelease                                                                                
Hit:1 http://mirror.kakao.com/ubuntu bionic InRelease                                                                                  
Get:2 http://mirror.kakao.com/ubuntu bionic-security InRelease [88.7 kB]        
Get:4 http://mirror.kakao.com/ubuntu bionic-updates InRelease [88.7 kB]                                                                                             
Get:7 https://packages.gitlab.com/gitlab/gitlab-ee/ubuntu bionic InRelease [23.3 kB]                                                               
Get:8 https://packages.gitlab.com/runner/gitlab-runner/ubuntu bionic InRelease [23.4 kB]
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjA0MzM4MDY2Nl19
-->