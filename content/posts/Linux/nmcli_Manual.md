---
title: "使用 nmcli 配置网络"
date: 2022-01-17T15:17:58+08:00
# draft: true
tags:
- Linux
- CLI
- nmcli
series:
categories:
---

**`脚本基于Centos 7`**

## 查看接口设备信息
```bash
# 简单接口状态
$ nmcli dev status
# 详细的接口信息
$ nmcli dev show
# 接口的详细信息
$ nmcli dev show <interface-name>
```

## 查看连接(connection)的信息
```bash
# 简单信息
$ nmcli con show
# 详细的连接信息
$ nmcli con show
# 某个连接的详细信息
$ nmcli con show <con-name>
```

## 创建连接
```bash
$ nmcli con add type <ethernet> con-name <static-vm100> ifname <eth0> ip4 <192.168.100.100/24> [gw4 <192.168.100.1>]
```

## 激活连接
```bash
$ nmcli con up <static-vm100>
$ nmcli con down <static-vm100>

$ nmcli dev connect <eth0>
$ nmcli dev disconnect <eth0>
```
> 建议使用 nmcli dev disconnect interface-name 命令，而不是 nmcli con down connection-name 命令，因为连接断开可将该接口放到“手动”模式，这样做用户让 NetworkManager 启动某个连接前，或发生外部事件（比如载波变化、休眠或睡眠）前，不会启动任何自动连接。

## 自动连接
```bash
# 查询和显示所有网络连接的自动连接属性的当前值
$ nmcli -f name,autoconnect connection
# 更改网络连接的属性值
$ nmcli con mod <eth1> connection.autoconnect yes
```

## 参考链接
- [CentOS 7 下网络管理之命令行工具nmcli](https://www.jianshu.com/p/5d5560e9e26a)
- [修改 NetworkManager 配置文件的自动连接属性](https://docs.rockylinux.org/zh/gemstones/nmcli/)