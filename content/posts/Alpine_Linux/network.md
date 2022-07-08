---
title: "Alpine Linux 网络设置"
date: 2022-06-19T15:25:18+08:00
# draft: true
tags: 
- network
series:
- Alpine linux
categories:
- 系统配置
---

## 网卡静态地址

```Bash
~# nano /etc/network/interfaces
```

```conf
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.10.16/24
    gateway 192.168.10.10
    hostname alpine
```

## DNS 地址

```Bash
~# nano /etc/resolv.conf
```

```conf
nameserver 114.114.114.114
```

## 重启网络

```Bash
~# service networking restart
```
