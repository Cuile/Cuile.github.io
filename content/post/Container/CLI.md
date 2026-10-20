---
title: "docker | podman 命令"
date: 2022-01-13T22:20:52+08:00
# draft: true
tags: 
- CLI
- docker
- podman
- container
---

## Image 列表
```bash
[docker | podman] image ls -a
# or
[docker | podman] images
```

## Container 列表
```bash
[docker | podman] container ls -a
# or
[docker | podman] ps
```

## 查看输出
```bash
[docker | podman] compose -f <yaml_file> logs [-f] [service name]
# or
[docker | podman] logs [-f] [container id]
```

## 验证配置文件
```bash
[docker | podman] compose -f <yaml_file> config
```

## 删除冗余 Image 
```bash
echo 'y'  |  [docker | podman] system prune
```

## 导入/导出 Image
```bash
# 导出
[docker | podman] save -o <image>.tar <image_name:label  |  image_id>
# 导入
# 使用image_id导出的Image ，导入时也没有名字
[docker | podman] load -i <image>.tar
```

## 导入/导出 Volume
```bash
# 导出数据
podman volume export <volume_name> | gzip > /tmp/<volume_name>_backup.tar.gz

scp /tmp/<volume_name>_backup.tar user@hostname:/tmp/
# 或使用 rsync
rsync -avz /tmp/<volume_name>_backup.tar user@hostname:/tmp/

# 创建目标卷
podman volume create <volume_name>
# 导入数据
gunzip -c /tmp/<volume_name>_backup.tar.gz | podman volume import <volume_name> -
```

## 不启动 Image ，查看 Image 内的文件
```bash
# 创建临时容器
[docker | podman] conatiner create --name <container_name> <image_name>
# 从容器复制文件到宿主机
[docker | podman] conatiner cp <container_name>:<file_path> <dest_path>
# 清理临时窗口
[docker | podman] container rm <container_name>
```

## 创建桥接网络
```bash
[docker | podman] network create [name]
```

## [docker | podman]快捷命令
```bash
echo "alias d-ll='[docker | podman] image ls -a; echo; [docker | podman] container ls -a'" >> ~/.bashrc \
    && echo "alias d-ps='[docker | podman] ps'" >> ~/.bashrc \
    && echo "alias d-clean='[docker | podman] system prune -f'" >> ~/.bashrc \
    && echo "alias d-rm='_a(){ [docker | podman] image rm $1; echo; [docker | podman] container rm $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-exec='_a(){ [docker | podman] exec -it $1 /bin/bash; }; _a'" >> ~/.bashrc \
    && echo "alias d-stop='_a(){ [docker | podman] container stop $1; }; _a'" >> ~/.bashrc \
    && echo "alias d-kill='_a(){ [docker | podman] container kill $1; }; _a'" >> ~/.bashrc
    
source ~/.bashrc
```