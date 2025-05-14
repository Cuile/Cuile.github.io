---
title: "配置 CentOS 7 的 CT 容器"
date: 2024-01-31T21:37:49+08:00
# draft: true

tags:
- CT Container
- lxc
- centos 7
- linux
- proxmoxve
---
Proxmox VE 官方提供的 Centos 7 模板是有问题的无法正常使用，现在给出解决方案。

## 安装

安装完成后，容器可以启动，但无法关闭、网络无法使用、控制台无法使用，这些都是我们要解决的问题。

## 解决方法

1. ssh登录进入PVE主机
```bash 
# 查看 CT 容器列表
$ pct list
# 进入 CT 容器
$ pct enter <VMID>
```
2. 打开网络
```bash
# 启动网络，从DHCP拿IP地址
$ ifup eth0
```
3. 更新 yum 库
```bash
$ curl -o /etc/yum.repos.d/jsynacek-systemd-backports-for-centos-7-epel-7.repo https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/repo/epel-7/jsynacek-systemd-backports-for-centos-7-epel-7.repo
$ yum update
# 安装 sshd
$ yum install -y openssh-server
$ systemctl start sshd.service
$ systemctl enable sshd.service
```
4. 退出 CT 容器
```bash
$ exit
$ pct stop <VMID>
```
5. 重新启动 CT 容器，一切正常---
- [[SOLVED] - PVE 7 won't start CentOS 7 container | Proxmox Support Forum](https://forum.proxmox.com/threads/pve-7-wont-start-centos-7-container.97834/#post-425419)