---
title: "在CentOS中安装 Laravel 框架"
date: 2024-01-19T13:26:15+08:00
tags:
- php
- laravel
- docker
- centos
---

## 1、安装Composer镜像

```bash
$ docker pull composer:1.9.0
```

## 2、安装laravel

```bash
# 启动Composer镜像
$ docker run --rm \
                -it \
                -v ${PWD}:/app \
                composer:1.9.0 /bin/bash

# 创建composer.json文件
$ composer init -n

# 使用国内 Packagist镜像
$ composer config repo.packagist composer https://mirrors.aliyun.com/composer/

# 添加laravel包
$ composer require -vvv \
                    --prefer-dist \
                    --prefer-stable \
                    laravel/installer

# 看到以下输出，说明添加成功。
Writing lock file
Generating autoload files

# 在当前目录覆盖安装laravel
$ ./vendor/bin/laravel new

# 看到以下输出，说明安装成功。
Package manifest generated successfully.
Application ready! Build something amazing.

# 退出Composer镜像
$ exit  
```

将当前目录下的storage目录权限，设为757

```bash
$ chmod -R 757 storage/
```

## 3、安装laravel-admin扩展包


```bash
# 进入laravel安装目录

# 启动Composer镜像
$ docker run --rm \
                -it \
                -v ${PWD}:/app \
                composer:1.9.0 /bin/bash

# 使用国内 Packagist镜像
$ composer config repo.packagist composer https://mirrors.aliyun.com/composer/

# 添加扩展包
$ composer require -vvv \
                    --prefer-dist \
                    --prefer-stable \
                    --sort-packages \
                    encore/laravel-admin

# 看到以下输出，说明安装成功。
Package manifest generated successfully.

# 退出Composer镜像
$ exit  
```
