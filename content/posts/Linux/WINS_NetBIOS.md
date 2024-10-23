---
title: "在 CentOS 上部署 NetBIOS"
date: 2024-10-23T13:04:27+08:00
# draft: true

# 标签
tags:
- wins
- netbios
- centos
- linux
# 专栏
# series:
# 分类
# categories:
---

**`基于 CentOS 7`**

让Linux系统与Windows系统之间，支持机器名访问，需要Linux安装NetBIOS。
而安装NetBIOS，不一定必须安装Samba，安装过程如下:

## 安装库
```bash
# 注意 这里并不会安装完整的samba
$ yum install samba-winbind
```

## 修改配置文件
```conf
# Nano /etc/nsswitch.conf
hosts:  files wins dns myhostname
```

## 验证安装
```bash
$ ll /etc/<lib|lib64>/libnss_winbind.so
```

## 配置生效
```bash
$ ldconfig
```

## 参考
- [How to Resolve NetBIOS Names From Linux | Baeldung on Linux](https://www.baeldung.com/linux/netbios-resolve-names)