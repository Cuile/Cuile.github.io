---
title: "docker|podman 命令"
date: 2022-01-13T22:20:52+08:00
# draft: true
tags: 
- CLI
- docker
- podman
- container
---

## 镜像列表
```bash
[docker|podman] image ls -a
# or
[docker|podman] images
```

## 容器列表
```bash
[docker|podman] container ls -a
# or
[docker|podman] ps
```

## 查看输出
```bash
[docker|podman] compose -f <yaml_file> logs [-f] [service name]
# or
[docker|podman] logs [-f] [container id]
```

## 验证配置文件
```bash
[docker|podman] compose -f <yaml_file> config
```

## 删除冗余镜像
```bash
echo 'y' | [docker|podman] system prune
```

## 导入导出镜像
```bash
# 导入
[docker|podman] load -i <image>.tar
# 导出
[docker|podman] save -o <image>.tar <image_name:label>
```

## 不启动镜像，查看镜像内的文件
```bash
# 创建临时容器
[docker|podman] conatiner create --name <container_name> <image_name>
# 从容器复制文件到宿主机
[docker|podman] conatiner cp <container_name>:<file_path> <dest_path>
# 清理临时窗口
[docker|podman] container rm <container_name>
```

## 创建桥接网络
```bash
[docker|podman] network create [name]
```

## [docker|podman]快捷命令
```bash
echo "alias d-ll='[docker|podman] image ls -a; echo; [docker|podman] container ls -a'" >> ~/.bashrc \
    && echo "alias d-ps='[docker|podman] ps'" >> ~/.bashrc \
    && echo "alias d-clean='[docker|podman] system prune -f'" >> ~/.bashrc \
    && echo "alias d-rm='_a(){ [docker|podman] image rm $1; echo; [docker|podman] container rm $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-exec='_a(){ [docker|podman] exec -it $1 /bin/bash; }; _a'" >> ~/.bashrc \
    && echo "alias d-stop='_a(){ [docker|podman] container stop $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-kill='_a(){ [docker|podman] container kill $1; }; _a'" >> ~/.bashrc
    
source ~/.bashrc
```