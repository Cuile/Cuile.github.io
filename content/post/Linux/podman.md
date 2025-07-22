---
title: "PVE CT虚拟机环境下Podman的安装"
date: 2025-07-22T18:49:39+08:00
# draft: true

tags:
- linux
- podman
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
### 修改sshd设置
```bash
nano /etc/ssh/sshd_config
```
- PermitRootLogin 设置为 yes 或 prohibit-password（允许密钥登录）。
- PubkeyAuthentication 设置为 yes。
- PasswordAuthentication 设置为 no（推荐禁用密码登录以提高安全性）。
### 修复SSH密钥权限
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R root:root ~/.ssh
```

## 安装
```bash
# 安装 Podman
apt install -y podman slirp4netns fuse-overlayfs
# 验证安装
podman --version

# 安装 podman-compose
python3 -m venv <path>
. <path>/bin/activate
python -m pip install podman-compose -y
```

## 运行
```bash
# 配置国内镜像源
nano /etc/containers/registries.conf
```
```toml
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