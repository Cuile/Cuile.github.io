---
title: "Linux 版本库管理"
date: 2022-02-08T10:28:50+08:00
# draft: true
tags:
- repo
series:
- Linux
- CentOS
- CLI
categories:
- 系统配置
---

**`脚本基于Centos 7`**

## 更换阿里云软件安装源

```bash
# 备份原镜像文件，以免出错后可以恢复。
$ mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup \
    && mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup

# 下载新的CentOS-Base.repo 到/etc/yum.repos.d/
$ wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && wget -O /etc/yum.repos.d/epel-testing.repo http://mirrors.aliyun.com/repo/epel-testing.repo

# 运行yum makecache生成缓存
$ yum clean all && yum makecache
```

## 查看已安装软件

```bash
$ yum list installed
```

## 升级所有包同时也升级软件和系统内核

```bash
$ yum -y update
```

## 只升级所有包，不升级软件和系统内核

```bash
$ yum -y upgrade
```

## 查看源是否生效

```bash
$ yum repolist
```

## 查询仓库

```bash
# 显示所有启动的仓库
$ yum repolist enabled
# 显示所有禁用的仓库
$ yum repolist disabled
# 显示所有仓库
$ yum repolist all
```

## 修改仓库

最常用的修改操作就是启动和停用, 可以使用以下命令实现:

```bash
$ yum-config-manager --enable repository…
$ yum-config-manager --disable repository…
```

##  参考文档

- [查RPM](https://crpm.cn/) <sup>找不到包的时候，可以在这上面查查，非常有帮助</sup>
- [阿里巴巴开源镜像站](https://developer.aliyun.com/mirror/)
    - [centos](https://developer.aliyun.com/mirror/centos)
    - [epel](https://developer.aliyun.com/mirror/epel)