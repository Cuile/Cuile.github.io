---
title: "Docker使用命令"
date: 2022-01-13T22:20:52+08:00
# draft: true
tags: 
- CLI
- Docker
series:
categories:
- 系统配置
---

## 镜像列表
```bash
$ docker image ls -a
# or
$ docker images
```

## 容器列表
```bash
$ docker container ls -a
# or
$ docker ps
```

## 删除冗余镜像
```bash
$ docker system prune
```

## 创建桥接网络
```bash
$ docker network create [name]
```

## Docker快捷命令
```bash
$ echo "alias d-ll='docker image ls -a; echo; docker container ls -a'" >> ~/.bashrc \
    && echo "alias d-ps='docker ps'" >> ~/.bashrc \
    && echo "alias d-clean='docker system prune -f'" >> ~/.bashrc \
    && echo "alias d-rm='_a(){ docker image rm $1; echo; docker container rm $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-exec='_a(){ docker exec -it $1 /bin/bash; }; _a'" >> ~/.bashrc \
    && echo "alias d-stop='_a(){ docker container stop $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-kill='_a(){ docker container kill $1; }; _a'" >> ~/.bashrc
    
$ source ~/.bashrc
```