---
title: "PVE CT虚拟机环境下Podman的安装"
date: 2025-07-22T18:49:39+08:00
# draft: true

tags:
- linux
- podman
- container
# series:
# categories:
---

## 修改CT虚拟机

### 修改特权容器
```bash
nano /etc/pve/lxc/<CTID>.conf
```
- 删除或注释掉 unprivileged: 1 这一行。
- 确保没有 lxc.idmap 相关的UID/GID映射配置（如有则删除）。

## 安装
```bash
apt update
# 安装 Podman
apt install -y podman pipx iptables # iptables必须安装，否则netavark无法运行
# 安装 podman-compose
apt install pipx \
    && pipx install podman-compose \
    && echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc \
    && . ~/.bashrc

# 验证安装
podman version ; podman-compose version
# 防火墙一定要加这条，否则容器之间的名称解析无法工作
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
```

## 配置
```bash
# 配置国内镜像源
sed -E -i.bak \
    -e 's/^# (unqualified-search-registries = ).+$/\1["docker.io"]/' \
    -e 's/^# (\[\[registry\]\])$/\1/' \
    -e 's/^# (prefix = ).+"$/\1"docker.io"/' \
    -e '0,\/^# (location = ).+"$/s//\1"docker.1ms.run"/' \
    -e '0,\/^# (\[\[registry.mirror\]\])$/s//\1/' \
    -e '0,\/^# (location = ).*"$/s//\1"registry.cn-hangzhou.aliyuncs.com"/' \
    /etc/containers/registries.conf
```
```toml
# nano /etc/containers/registries.conf
unqualified-search-registries = ["docker.io"]

[[registry]]
prefix = "docker.io"
location = "docker.1ms.run"

[[registry.mirror]]
location = "registry.cn-hangzhou.aliyuncs.com"  # 可选备用
```
其实命令与Docker一致，非常方便好用。
- [Docker / Podman 安装与换源](https://wcbing.top/linux/containers/install/)
- [国内 Docker 服务状态 & 镜像加速监控](https://status.1panel.top/status/docker)