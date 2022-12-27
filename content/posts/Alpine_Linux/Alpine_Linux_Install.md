---
title: "Alpine Linux 3.16 安装"
date: 2022-06-19T11:46:55+08:00
# draft: true
tags:
- Alpine linux
series:
- linux
categories:
- 系统配置
---

## 1. 准备系统

Alpine 有许多版本，其中 VIRTUAL 是专门针对虚拟环境优化过的，所以主要使用这个版本来安装。

[https://www.alpinelinux.org/downloads/](https://www.alpinelinux.org/downloads/)

## 2. 登录

```bash
...
# 使用启动盘启动后，直接使用 root 登录系统
localhost login: root
```

## 3. 安装

```bash
...
localhost:~# setup-alpine

# 选择键盘布局
# 这里两个都选 cn 或都不选
...
Select keyboard layout: [none] cn
...
Select variant (or 'abort'): cn

# 设置主机名
...
Enter system hostname (fully qualified form, e.g. 'foo.example.org') [localhost] home

# 设置网络
...
Which one do you want to initialize? (or '?' or 'done') [eth0] eth0

Ip address for eth0? (or 'dhcp', 'none', '?') [dhcp] dhcp
Do you want to do any manual network configuration? (y/n) [n] n
# or 手动输入IP地址
Ip address for eth0? (or 'dhcp', 'none', '?') [dhcp] 192.168.10.16/24
Gateway? (or 'none') [none] 192.168.10.10
Do you want to do any manual network configuration? (y/n) [n] n
DNS domain name? (e.g 'bar.com') 
DNS nameserver(s)? 114.114.114.114

# 设置密码
...
New password: 
...
Retype password:

# 设置时区
# PRC 代理中国，也可以输入 Asia/，再输入 Shanghai
...
Which timezone are you in? ('?' for list) [UTC] PRC

# 设备代理
...
HTTP/FTP proxy URL? (e.g. 'http://proxy:8080', or 'none') [none] none

# 设置更新源
# f 是自动测试并选择最快的源，建议使用
...
Enter mirror number (1-74) or URL to add (or r/f/e/done) [1] f

# 
Setup a user? (enter a lower-case loginname, or 'no') [no] no

# 设置ssh服务
Which ssh server? ('openssh', 'dropbear', or 'none') [openssh] openssh
# 这里一定要输入 yes 
# 许多教程都说 Alpine 默认没有远程登录，都上手动修改，其实是可以在安装时就设备好的
Allow root ssh login? ('?' for help) [prohibit-password] yes
Enter ssh key or URL for root (or 'none') [none] none

# 设置磁盘
...
Which disk(s) would you like to use? (or '?' for help or 'none') [none] sda
...
How would you like to use it? ('sys', 'data', 'crypt', 'lvm' or '?' for help) [?] sys
...
WARNING: Erase the aboue disk(s) and continue? (y/n) [n] y
...
Installation is complete. Please reboot.
# 到这里安装全部完成

# 2.13 reboot命令重启电脑
home:~# reboot
```
