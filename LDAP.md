---
title: HOWTO install LDAP Server
link: /LDAP
description: 
status: publish
tags: [Linux, LDAP]
date: 2020-10-21
lastmod: 2020-11-16 09:37:41 +0900
banner: https://source.unsplash.com/random/800x400
aliases:
    - /gollum/LDAP
    - /gollum/LDAP.md
---

# HOWTO install LDAP Server

본 포스트는 OpenLDAP을 사용하고자 하는 분들에게 도움을 주고자 작성 되었습니다.

## Prerequisite

패키지 리스트를 최신으로 업데이트한다.
```bash
sudo apt-get update
```

<!--more-->

### Important notes

```bash
# Configure vim as default editor
sudo apt-get install -y vim
sudo update-alternatives --set editor /usr/bin/vim.basic
```

LDAP에 사요할 Domain Name을 `/etc/hosts` 파일에 추가한다.
```bash
sudo editor /etc/hosts
```

다음과 같이 추가한다.
```
127.0.1.1 ldap.harues.com ldap ldap.harues.com
```


OpenLDAP 과 관련 유틸리티를 설치한다.

```bash
sudo apt-get install slapd ldap-utils -y
```

This will prompt a setup window so we need to populate it with the correct credentials.

When asked for administrator password use `************`.
Repeat the password to confirm it.

We will use the advantage of slapd setup to fully configure LDAP instead of filling in the details by hand in a text file:

```bash
sudo dpkg-reconfigure slapd
```
Answer the following questions:

You will be asked to omit OpenLDAP server configuration: `No`
Under DNS domain name fill in: `harues.com`
Under organization name fill in: `Harues Inc.`
Under administrator password fill in: `************`
Repeat password: `************`
Database backend to use, select: `HDB`
Do you want database to be removed when slapd is purged: `Yes`
Move old database, choose: `Yes`
Allow LDAPv2 protocol, choose: `No`

** If at any point you get the error: **

```
ldap_bind: Invalid credentials (49)
```

configure slapd again.

Next, add index to make lookup easier, create a file index.ldif

```bash
editor index.ldif
```

and populate with the following:

```
dn: olcDatabase={1}hdb,cn=config
changetype: modify
add: olcDbIndex
olcDbIndex: uid eq,pres,sub
```

and add it to ldap database:

```bash
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f index.ldif
```

This should produce the following output:

```
modifying entry "olcDatabase={1}hdb,cn=config"
```
If this is not the case recheck your steps and try again.

You can verify that all is working:

```bash
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={1}hdb)' olcDbIndex
```
This should produce the following output:

```
dn: olcDatabase={1}hdb,cn=config
olcDbIndex: objectClass eq
olcDbIndex: uid eq,pres,sub
```
If this is not the case recheck your steps and try again.

Next step is to create an ldap user. 
Create `base.ldif` 

```bash
editor base.ldif
```

and populate with:

```
dn: ou=Users,dc=harues,dc=com
objectClass: organizationalUnit
ou: Users

dn: ou=Groups,dc=harues,dc=com
objectClass: organizationalUnit
ou: Groups

dn: cn=miners,ou=Groups,dc=harues,dc=com
objectClass: posixGroup
cn: miners
gidNumber: 5000

dn: uid=euikook,ou=Users,dc=harues,dc=com
objectClass: organizationalPerson
objectClass: person
objectClass: top
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: euikook
sn: KIM
givenName: E.K.
cn: E.K. KIM
displayName: E.K. KIM
uidNumber: 10000
gidNumber: 10000
userPassword: test
gecos: E.K. KIM
loginShell: /bin/bash
homeDirectory: /home/euikook
mail: euikook@harues.com
telephoneNumber: 000-000-0000
st: NY
manager: uid=euikook,ou=Users,dc=harues,dc=com
shadowExpire: -1
shadowFlag: 0
shadowWarning: 7
shadowMin: 8
shadowMax: 999999
shadowLastChange: 10877
title: System Administrator
```

Add the user to the LDAP database:

```bash
ldapadd -x -D cn=admin,dc=gitlab,dc=dev -w gitlabldap -f base.ldif
```

This should produce the following output:

```
adding new entry "ou=Users,dc=harues,dc=com"

adding new entry "uid=euikook,ou=Users,dc=harues,dc=com"
```
If this is not the case recheck your steps and try again.

To confirm that the user is in LDAP, use:

```bash
ldapsearch -x -LLL -b dc=harues,dc=com 'uid=euikook' uid uidNumber displayName mail
```
and that should produce the output that looks like:

```
dn: uid=euikook,ou=Users,dc=harues,dc=com
uid: euikook
displayName: E.K. KIM
uidNumber: 10000
```
This would complete setting up the OpenLDAP server. Only thing that is left to do is to give the correct details to GitLab.
Under `gitlab.yml` there is a LDAP section that should look like this:

```
  ## LDAP settings
  ldap:
    enabled: true
    host: 'ldap.harues.com'
    base: 'dc=harues,dc=com'
    port: 389
    uid: 'uid'
    method: 'plain' # "ssl" or "plain"
    bind_dn: 'dc=harues,dc=com'
    password: 'gitlabldap'
```

Navigate to `gitlab` source directory and start the GitLab instance with:

```
bundle exec foreman start
```

If you now navigate to `http://192.168.3.14:3000/` and fill in the sign in page under the LDAP section with:

`username`: euikook
`password`: test

you will be authenticated with OpenLDAP server and logged into GitLab.

#### Logging

Activity logging for slapd is indispensible when implementing an OpenLDAP-based solution yet it must be manually enabled after software installation. Otherwise, only rudimentary messages will appear in the logs. Logging, like any other slapd configuration, is enabled via the slapd-config database.

OpenLDAP comes with multiple logging subsystems (levels) with each one containing the lower one (additive). A good level to try is stats. The slapd-config man page has more to say on the different subsystems.

Create the file logging.ldif with the following contents:
```
dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: stats
```
Implement the change:
```
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif
```
This will produce a significant amount of logging and you will want to throttle back to a less verbose level once your system is in production. While in this verbose mode your host's syslog engine (rsyslog) may have a hard time keeping up and may drop messages:

rsyslogd-2177: imuxsock lost 228 messages from pid 2547 due to rate-limiting
You may consider a change to rsyslog's configuration. In /etc/rsyslog.conf, put:
```
# Disable rate limiting
# (default is 200 messages in 5 seconds; below we make the 5 become 0)
$SystemLogRateLimitInterval 0
```

And then restart the rsyslog daemon:
```
sudo service rsyslog restart
```

#### LDAP TLS

When authenticating to an OpenLDAP server it is best to do so using an encrypted session. This can be accomplished using Transport Layer Security (TLS).

Here, we will be our own Certificate Authority and then create and sign our LDAP server certificate as that CA. Since slapd is compiled using the gnutls library, we will use the certtool utility to complete these tasks.

Install the gnutls-bin and ssl-cert packages:
```
sudo apt-get install gnutls-bin ssl-cert
```

Create a private key for the Certificate Authority:
```
sudo sh -c "certtool --generate-privkey > /etc/ssl/private/cakey.pem"
```

Create the template/file /etc/ssl/ca.info to define the CA:
```
cn = Netvision Telecom Inc.
ca
cert_signing_key
```

Create the self-signed CA certificate:
```
sudo certtool --generate-self-signed \
--load-privkey /etc/ssl/private/cakey.pem \ 
--template /etc/ssl/ca.info \
--outfile /etc/ssl/certs/cacert.pem
```

Make a private key for the server:
```
sudo certtool --generate-privkey \
--bits 1024 \
--outfile /etc/ssl/private/ldap_slapd_key.pem
```

Replace ldap in the filename with your server's hostname. Naming the certificate and key for the host and service that will be using them will help keep things clear.

Create the /etc/ssl/ldap.info info file containing:
```
organization = Example Company
cn = ldap01.example.com
tls_www_server
encryption_key
signing_key
expiration_days = 3650
```

The above certificate is good for 10 years. Adjust accordingly.

Create the server's certificate:
```
sudo certtool --generate-certificate \
--load-privkey /etc/ssl/private/ldap_slapd_key.pem \
--load-ca-certificate /etc/ssl/certs/cacert.pem \
--load-ca-privkey /etc/ssl/private/cakey.pem \
--template /etc/ssl/ldap01.info \
--outfile /etc/ssl/certs/ldap_slapd_cert.pem
```

Create the file certinfo.ldif with the following contents (adjust accordingly, our example assumes we created certs using https://www.cacert.org):
```
dn: cn=config
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ssl/certs/cacert.pem
-
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ssl/certs/ldap_slapd_cert.pem
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ssl/private/ldap_slapd_key.pem
```

Use the ldapmodify command to tell slapd about our TLS work via the slapd-config database:
```
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f /etc/ssl/certinfo.ldif
```

Tighten up ownership and permissions:
```
sudo adduser openldap ssl-cert
sudo chgrp ssl-cert /etc/ssl/private/ldap_slapd_key.pem
sudo chmod g+r /etc/ssl/private/ldap_slapd_key.pem
sudo chmod o-r /etc/ssl/private/ldap_slapd_key.pem
```

Restart OpenLDAP:
```
sudo service slapd restart
```

Check your host's logs (/var/log/syslog) to see if the server has started properly.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMjMzNTA5MjZdfQ==
-->