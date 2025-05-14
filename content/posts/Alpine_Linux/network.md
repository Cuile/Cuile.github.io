---
title: "Alpine Linux 网络设置"
date: 2022-06-19T15:25:18+08:00
# draft: true
tags: 
- linux
- network
- Alpine linux
---

## 网卡静态地址
```bash
~# nano /etc/network/interfaces
```

```ini
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.10.16/24
    gateway 192.168.10.10
    hostname alpine
```

## 配置 DNS
```ini
# nano /etc/resolv.conf
nameserver 114.114.114.114
```

## 重启网络
```bash
~# service networking restart
```
