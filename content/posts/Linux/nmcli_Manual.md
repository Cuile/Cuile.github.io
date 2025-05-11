---
title: "使用 nmcli 配置网络"
date: 2022-01-17T15:17:58+08:00
# draft: true
tags:
- CLI
- nmcli
- network
series:
- Linux
categories:
---

**`基于Centos 7`**

## 查看设备信息
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
$ nmcli conn show
# 详细的连接信息
$ nmcli conn show
# 某个连接的详细信息
$ nmcli conn show <conn-name>
```
## 创建连接
```bash
nmcli conn add type <ethernet> con-name <conn-name> ifname <dev-name> ip4 <192.168.100.100/24> [gw4 <192.168.100.1>]
```
## 修改配置
### 静态IP改动态IP
```bash
nmcli conn mod <conn-name> /
    ipv4.method auto /
    ipv4.address "" /
    ipv4.gateway "" /
    ipv4.dns ""
```
### 修改DNS
```bash
$ nmcli conn mod <conn-name> ipv4.dns "1.2.4.8"
```
### 设置自动连接
```bash
# 查询和显示所有网络连接的自动连接属性的当前值
$ nmcli -f name,autoconnect connection
# 更改网络连接的属性值
$ nmcli conn mod <conn-name> connection.autoconnect yes
```
### 配置生效
```bash
nmcli conn up <conn-name>
```

## 激活连接
```bash
$ nmcli conn up <conn-name>
$ nmcli conn down <conn-name>

$ nmcli dev connect <dev-name>
$ nmcli dev disconnect <dev-name>
```
> 建议使用 nmcli dev disconnect interface-name 命令，而不是 nmcli con down connection-name 命令，因为连接断开可将该接口放到“手动”模式，这样做用户让 NetworkManager 启动某个连接前，或发生外部事件（比如载波变化、休眠或睡眠）前，不会启动任何自动连接。

## 参考链接
- [nmcli 使用方法](https://blog.csdn.net/juxua_xatu/article/details/128983190)
- [在Linux系统上使用nmcli命令配置各种网络（有线、无线、vlan、vxlan、路由、网桥等）](https://blog.csdn.net/m0_74367891/article/details/138671057)
- [CentOS 7 下网络管理之命令行工具nmcli](https://www.jianshu.com/p/5d5560e9e26a)
- [修改 NetworkManager 配置文件的自动连接属性](https://docs.rockylinux.org/zh/gemstones/nmcli/)
- [在 Ubuntu/Debian 上安装和使用 NetworkManager (NMCLI)](https://cn.linux-console.net/?p=22364)