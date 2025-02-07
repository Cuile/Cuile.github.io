---
title: "ProxmoxVE 配置 DHCP 网络"
date: 2025-02-07T09:44:39+08:00
# draft: true

# 标签
tags:
- ipv6
- proxmoxve
- DHCP
# 专栏
# series:
# 分类
# categories:
---

PVE 节点的网络配置，在 WebUI 里只能设置为静态地址，想设置DHCP的话需要使用以下方法。

## 方法一
```bash
$ cp /etc/network/interfaces /etc/network/interfaces.new
```
```ini
# /etc/network/interfaces.new
...
# IPv4
iface vmbr0 inet dhcp
        # address 192.168.1.66/24
        # gateway 192.168.1.1
        bridge-ports enp1s0
        bridge-stp off
        bridge-fd 0
# IPv6
iface vmbr0 inet6 dhcp
        request_prefix 1
```
在 PVE 的 WebUI 里 “系统 > 网络” 处，刷新后点击“应用配置”即可生效，等待几分钟后即可获取到IPv6地址。

## 方法二
直接修改 /etc/network/interfaces 文件也可以，修改完获取新地址。
```bash
$ systemctl restart networking
```
## 查看新地址
```bash
$ ip addr show vmbr0
```
- [PVE设置动态获取ip地址](https://blog.csdn.net/weixin_47054353/article/details/130452673)
- [Proxmox VE 使用IPv6](https://www.icn.ink/pve/57.html)