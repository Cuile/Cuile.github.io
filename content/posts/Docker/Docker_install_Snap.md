---
title: "使用 Snap 安装 Docker"
date: 2022-05-11T18:41:48+08:00
# draft: true
tags:
series:
- Snap
- Docker
categories:
- 系统配置
---


尝试使用 Ubuntu 的 Snap 后，发现真的非常方便。

看过Snap的介绍以后，发现Snap的沙盒理念非常先进，在存储基本不成问题背景下，会系统环境的影响更小。

而且docker-compose命令也会一起安装，更是方便。

## 1.安装 

```bash
$ sudo snap install docker
```

## 2.设置

```bash
# 设置开机启动
$ sudo snap start docker --enable
# 确认服务状态
$ sudo snap services docker
# 查看服务详情
$ service snap.docker.dockerd status
```
使用sudo安装后要注意以后调用时，都要使用sudo命令前缀。

## 3.其它

```bash
# 安装目录
/snap/docker/current         
# 服务启动配置文件
/etc/systemd/system/snap.docker.dockerd.service
# 配套 AppArmor 配置文件
/var/lib/snapd/apparmor/profiles/snap.docker.docker
/var/lib/snapd/apparmor/profiles/snap.docker.dockerd
# 默认 Unix Socket 文件路径
unix:///var/snap/docker/current/run/docker/libcontainerd/docker-containerd.sock
```

## 4.参考文献

[Docker 安装指南](https://www.moha.online/en/node/111#Snap%E5%AE%89%E8%A3%85)