---
title: "OpenWRT DNS设置"
date: 2022-02-07T13:17:39+08:00
# draft: true
tags: 
- DNS
series:
- OpenWRT
categories:
- 配置
---

## 1. 使用自定义域名访问WEB管理界面

- `网络`-`DHCP/DNS`-`常规设置`-`DNS转发`：/openwrt.lan/192.168.xxx.xxx
- `网络`-`DHCP/DNS`-`常规设置`-`重绑定保护`：不勾选
- `/etc/config/uhttpd`-`option redirect_https`：'1' *不强制跳转https*