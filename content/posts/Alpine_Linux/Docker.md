---
title: "Alpine Linux 安装 Docker"
date: 2022-06-19T16:08:06+08:00
# draft: true
tags:
- Alpine linux
series:
- Docker
- linux
categories:
- 系统配置
---

在 Alpine 上安装 Docker 真是一件让人感觉非常愉快的事情，因为过程非常简单。

## 修改 apk 源

```bash
~# nano /etc/apk/repositories
```

因为 docker 在社区的库里，所以要打开 community 的源。

```conf
#/media/cdrom/apks
http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.16/main
http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.16/community
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/community
#http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing

```

```bash
~# apk update

```

## 安装 docker

```bash
~# apk add docker docker-cli-compose
# 这里要特别注意，docker compose 的包名在 Alpine 里是 docker-cli-compose，不是 docker-compose-plugin。
# docker-compose 包是 compose 的独立安装包，官方已经不再支持这种安装方式。
...
~# docker -v
Docker version 20.10.16, build aa7e414fdcb23a66e8fabbef0a560ef1769eace5
~# docker compose version
Docker Compose version v2.12.2
```

## 启动 docker

```bash
# 引导时启动
~# rc-update add docker boot
# 启动服务
~# service docker start
```

## 测试

```bash
~# docker run hello-world
```
