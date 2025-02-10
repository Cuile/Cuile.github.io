---
title: "Alpine Linux 安装 Docker"
date: 2022-06-19T16:08:06+08:00
# draft: true
tags:
- linux
- Alpine linux
- Docker
series:
categories:
---

在 Alpine 上安装 Docker 真是一件让人感觉非常愉快的事情，因为过程非常简单。

## 修改 apk 源

```bash
$ nano /etc/apk/repositories
```

因为 docker 在社区的库里，所以要打开 community 的源。

```ini
#/media/cdrom/apks
http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.16/main
http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.16/community
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/community
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing

```

## 安装 docker

```bash
$ apk update
$ apk add docker docker-cli-compose
# 这里要特别注意，docker compose 的包名在 Alpine 里是 docker-cli-compose，不是 docker-compose-plugin。
# docker-compose 包是 compose 的独立安装包，官方已经不再支持这种安装方式。
...
$ docker -v
Docker version 20.10.16, build aa7e414fdcb23a66e8fabbef0a560ef1769eace5
$ docker compose version
Docker Compose version v2.12.2
```

## 配置仓库镜像
[CentOS 7 安装 Docker](../docker_install_centos/#7%E9%85%8D%E7%BD%AE%E4%BB%93%E5%BA%93%E9%95%9C%E5%83%8F)

## 启动 docker
```bash
# 引导时启动
$ rc-update add docker boot
# 启动服务
$ rc-service docker start
```

## 测试
```bash
$ docker run hello-world
```
