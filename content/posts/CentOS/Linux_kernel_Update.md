---
title: "Linux系统内核升级"
date: 2022-02-08T10:17:48+08:00
# draft: true
tags:
- Linux
- CentOS 7
- kernel
series:
- CLI
categories:
- 系统配置
---

**`脚本基于Centos 7`**

## 1、查看系统内核版本
```bash
$ uname -r
3.10.0-514.26.2.el7.x86_64
$ cat /etc/redhat-release 
CentOS Linux release 7.6.1810 (Core)
```

## 2、升级内核
导入elrepo的key，然后安装elrepo的yum源
```bash
$ rpm -import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
$ rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```
查看可用的内核相关包
```bash
$ yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
```
主分支ml(mainline)，稳定版(stable)，长期维护版lt(longterm)
安装内核
```bash
$ yum -y --enablerepo=elrepo-kernel install kernel-ml.x86_64 kernel-ml-devel.x86_64
```

## 3、修改grub
```bash
$ awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
CentOS Linux (5.2.11-1.el7.elrepo.x86_64) 7 (Core)
CentOS Linux (3.10.0-957.27.2.el7.x86_64) 7 (Core)
CentOS Linux (3.10.0-514.26.2.el7.x86_64) 7 (Core)
CentOS Linux (3.10.0-514.el7.x86_64) 7 (Core)
CentOS Linux (0-rescue-963c2c41b08343f7b063dddac6b2e486) 7 (Core)
# 新内核（5.2.11）在0的位置上

$ vim /etc/default/grub
#将 GRUB_DEFAULT=saved 改为 GRUB_DEFAULT=0

# 重建内核配置
$ grub2-mkconfig -o /boot/grub2/grub.cfg
```

## 4、重启系统
```bash
$ reboot

#查看内核版本
$ uname -r
5.2.11-1.el7.elrepo.x86_64
```