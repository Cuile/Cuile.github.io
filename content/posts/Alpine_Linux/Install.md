---
title: "虚拟机安装 Alpine Linux 3.16"
date: 2022-06-19T11:46:55+08:00
# draft: true
tags:
- linux
- Alpine linux
- proxmoxve
- vm
- qmue\kvm
series:
categories:
---

特点：
1. 小巧：基于musl libc 和 busybox，和 busybox一样小巧，最小的Docker镜像只有5MB。
2. 安全：面向安全的轻量发行版
3. 简单：提供APK包管理工具，软件的搜索、安装、删除、升级都非常方便。
4. 适合容器使用：由于小巧、功能完备，非常适合作为容器的基础镜像。

不同版本：
- STANDARD：最小的可启动镜像，需要网络才能安装。带有Intel, AMD等CPU的微代码。
- VIRTUAL：与STANDARD类似，但更小，更适合虚拟系统使用。
- EXTENDED：包括最常用的软件包。适用于路由器和服务器。从RAM运行。扩展版本，带有更多软件包。
- XEN：内置XEN Hypervisor支持。
- NETBOOT：netboot的内核、initramfs和modloop。
- RASPBERRY PI：带有树莓派内核的版本。
- GENERIC ARM：带有ARM内核，带有uboot加载器。
- MINI ROOT FILESYSTEM：最小系统版本，仅包含内核，只用于构建Docker镜像。

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
```
### 3.1. 自动安装
```bash
# 准备应答文件
```
- [Answer Files](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html#_answer_files)

## 4. 命令重启电脑
```bash
home:~# reboot
```

## 5. 关闭防火墙
```bash
home:~# rc-service iptables stop
home:~# rc-update del iptables
```