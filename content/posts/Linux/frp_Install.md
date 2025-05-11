---
title: "frp安装配置"
date: 2022-12-28T17:15:15+08:00
# draft: true
tags: 
- frp
- proxy
series:
- linux
categories:
---

## 1. 使用手册

看完这3篇足以把服务建起来，非常方便

- [官方文档](https://github.com/fatedier/frp/blob/master/README_zh.md)
- [教程1](https://www.appinn.com/frp/)
- [教程2](https://meta.appinn.net/t/frp/11319/13)


## 2. 服务端安装配置

可直接使用 Docker 的配置进行

## 3. 客户端下载、 安装、运行

原本也想使用Docker镜像，但发现kvm之间通过Docker通信好像有问题，所幸在宿主机上可以直接使用release文件。
【*注意：每次添加新的客户端，要同步更新服务端的端口配置*】

### 3.1. 下载

[官网下载地址](https://github.com/fatedier/frp/releases)【*注意：s, c两端使用的版本号要相同*】
```bash 
$ cd ~
# 下载安装软件
$ yum install wget tar git
# 下载 frp
$ wget -c https://github.com/fatedier/frp/releases/download/v0.34.3/frp_0.34.3_linux_amd64.tar.gz
$ tar -axvf frp_0.34.3_linux_amd64.tar.gz
$ rm -rf frp_0.34.3_linux_amd64.tar.gz
# 下载 frp 配置
$ git clone https://github.com/Cuile/frp.git
```

### 3.2. 安装

```bash
# 此处只能使用硬链接，使用软链接会导致无法启动服务
# 安装配置文件
$ mkdir /etc/frp
$ ln -b ~/frp/conf/frpc-pve.ini /etc/frp/frpc.ini
# 安装运行文件
$ ln -b ~/frp_0.34.3_linux_amd64/frpc /usr/bin/frpc
# 安装服务
$ ln -b ~/frp_0.34.3_linux_amd64/systemd/frpc.service /lib/systemd/system/frpc.service
```

### 3.3. 运行

```bash
$ systemctl enable frpc.service           ##设定指定服务开机开启
$ systemctl disable frpc.service          ##设定指定服务开机关闭

$ systemctl start frpc.service
$ systemctl stop frpc.service
$ systemctl restart frpc.service

$ systemctl status frpc.service
$ systemctl list-units | grep frpc
```

### 3.4. 更新
通过 git 更新 frpc 的配置后，要重新链接配置文件
```bash
$ bash ~/frp/CentOS/restart.frpc.service.sh
```