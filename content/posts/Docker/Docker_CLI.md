---
title: "Docker使用命令"
date: 2022-01-13T22:20:52+08:00
# draft: true
tags: 
- CLI
series:
- Docker
categories:
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

## 查看输出
```bash
$ docker compose -f <yml file> logs [-f] [service name]
# or
$ docker logs [-f] [container id]
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

## 导入导出镜像
```bash
# 导入
$ docker load -i <image>.tar
# 导出
$ docker save -o <image>.tar <image_name:label>
```