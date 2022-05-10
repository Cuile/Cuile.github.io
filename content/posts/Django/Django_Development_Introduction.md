---
title: "Django 开发简介"
date: 2022-05-10T16:30:13+08:00
# draft: true
tags:
- Django
- Docker
---

## 开发环境

开发环境还是建议使用 Docker 来搭建，方便快捷。
不过 Django 的官方镜像已经弃用了，官方建议新版本使用 Python 官方提供的镜像来构建。

Django 的 LTS 版本是 3.2.13，Python 稳定版本镜像是 3.9.12-buster ，所以建议使用这两个版本来构建 Django 环境。

### 环境搭建

可以参考[https://github.com/Cuile/Docker-to-Python/tree/master/Django]，提供了 Dockerfil、yml 文件，还提供全套使用命令。

## 常用命令

```bash
# 创建项目
$ django-admin startproject xxx

$ cd xxx

# 生成项目
$ python manage.py startapp websrc
# 运行项目测试
$ python manage.py runserver 0.0.0.0:80
# 创建管理员
$ python manage.py createsuperuser
```