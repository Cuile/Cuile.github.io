---
title: "(CentOS 7 | Rocky 9) 安装 Docker"
date: 2022-05-06T11:05:23+08:00
# draft: true
tags: 
- linux
- CentOS
- rocky
- Docker
series:
categories:
---

其实网上相关的文章已经非常多了，所以这篇文章的作用只是记录和明确一条确定可行的操作路径，为以后的操作节省时间，毕竟像我一样大部分人都不是专业的系统管理员，能够快速解决问题就可以了，并不想做过多的专业研究与探索。

本操作手册是官方手册与网上手册的结合版本，集两家之所长，亲自操作可用。

## 1. 系统准备
```bash
# 查看系统版本
$ cat /etc/redhat-release
> CentOS Linux release 7.6.1810 (Core) // CentOs 7 以上版本

# 查看系统内核版本
$ uname -r
> 4.10.4-1.el7.elrepo.x86_64 // 内核版本要>3.10

# 卸载旧版本
$ yum remove docker \
            docker-client \
            docker-client-latest \
            docker-common \
            docker-latest \
            docker-latest-logrotate \
            docker-logrotate \
            docker-selinux \
            docker-engine-selinux \
            docker-engine

# 安装依赖包
$ yum install -y yum-utils \
                device-mapper-persistent-data \
                lvm2
```

## 2. 添加 Docker 软件源
```bash
# 如果系统已切换到阿里云镜像源地址，可跳过此步。
# 阿里云镜像自带docker源
$ yum-config-manager \
    --add-repo \
    https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo

# 使用官方源
$ yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

$ yum makecache fast
# CentOS 8 or Rocky 9 使用timer替换fast
$ yum makecache timer
```

## 3. 安装Docker
```bash
# 如果在 Rocky 9 系统上，会提示containerd.io版本过低，或下载失败，需要独立安装containerd.io
# 可以重试几次
$ yum install -y docker-ce docker-ce-cli containerd.io
```

## 4. 配置 Docker
```json
// /etc/docker/daemon.json
{
  // 添加官方仓库镜像地址
  "registry-mirrors": ["https://registry.docker-cn.com"],
  // 关闭docker iptables配置
  "iptables": false
}
```
- [Docker/DockerHub 国内镜像源/加速列表（长期维护）](https://xuanyuan.me/blog/archives/1154?from=tencent)

其实使用中仓库镜像的速度并不理想，还是设置代理更加实用
- [如何优雅的给 Docker 配置网络代理](https://cloud.tencent.com/developer/article/1806455)

## 5. 启动 Docker
```bash
# 设为开机启动
$ systemctl enable docker.service
# 启动服务
$ systemctl start docker.service
```

## 6. 测试安装结果
```bash
$ docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete
Digest: sha256:6540fc08ee6e6b7b63468dc3317e3303aae178cb8a45ed3123180328bcc1d20f
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

若能正常输出以上信息，则说明安装成功。

## 7. 安装 docker compose
官方推荐使用插件方式安装
```bash
$ yum install -y docker-compose-plugin

$ docker compose version
Docker Compose version v2.5.0
```
