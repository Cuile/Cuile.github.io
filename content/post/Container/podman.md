---
title: "Podman的安装"
date: 2025-07-22T18:49:39+08:00
# draft: true

tags:
- linux
- podman
- container
# series:
# categories:
---

## 安装
```bash
# 安装 Podman
apt update \
&& apt install -y curl gpg gnupg2

# 查看 Debian版本
lsb_release -a

# Debian 13
# 添加 Kubic 项目的 Debian_Testing 软件源
echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_Testing/ /' | sudo tee /etc/apt/sources.list.d/kubic.list
# 下载并添加对应的 GPG 密钥
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/Debian_Testing/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kubic.gpg > /dev/null

# 更新软件包列表并安装 Podman
apt update \
&& apt install -y podman \
&& podman version 

# 安装 podman-compose
apt install -y pipx \
&& pipx ensurepath \
&& . ~/.bashrc \
&& pipx install podman-compose \
&& podman-compose version

# iptables必须安装，否则netavark无法运行
apt install -y iptables 
# 防火墙一定要加这条，否则容器之间的名称解析无法工作
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
```

## 配置国内镜像源
```toml
# nano /etc/containers/registries.conf
unqualified-search-registries = ["docker.io"]

[[registry]]
prefix = "docker.io"
location = "docker.io"
[[registry.mirror]]
location = "docker.1ms.run"
[[registry.mirror]]
location = "registry.cn-hangzhou.aliyuncs.com"

[[registry]]
prefix = "ghcr.io"
location = "ghcr.io"
[[registry.mirror]]
location = "ghcr.nju.edu.cn"
```

## 测试podman是否安装成功
```bash
podman run --rm hello-world
```
其实命令与Docker一致，非常方便好用。
- [Docker / Podman 安装与换源](https://wcbing.top/linux/containers/install/)
- [国内 Docker 服务状态 & 镜像加速监控](https://status.1panel.top/status/docker)

## 在CT虚拟机下安装

### 修改特权容器
```bash
nano /etc/pve/lxc/<CTID>.conf
```
- 删除或注释掉 unprivileged: 1 这一行。
- 确保没有 lxc.idmap 相关的UID/GID映射配置（如有则删除）。

> **CT虚拟机必须是特权容器，但创建CT虚拟机时，默认为非特权容器，要特别注意！！！**

> **CT虚拟机必须打开嵌套，要特别注意！！！**
