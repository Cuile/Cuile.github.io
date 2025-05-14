---
title: "虚拟主机安装 Laravel 框架"
date: 2024-01-19T13:18:15+08:00
tags:
- php
- docker
- laravel
---

因为阿里的弹性WEB托管，使用php 5.5.30版本，所以只能安装Laravel 5.2版本。

本教程使用WSL + docker环境安装，除完整的laravel环境外，不会在本地留下任何痕迹。

## 1、本地安装Composer镜像

```bash
$ docker pull composer:1.9.0
```

## 2、配置Composer镜像

```bash
# 启动Composer镜像
$ docker run --rm \
                -it \
                -v ${PWD}:/app \
                composer:1.9.0 /bin/bash

# 使用国内 Packagist镜像
$ composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

$ composer create-project -vvv \
                            --prefer-dist \
                            --no-scripts \
                            --keep-vcs \
                            laravel/laravel:5.2.31 \
                            YSME

# 看到以下输出，说明安装完成。

Writing lock file
Generating autoload files

# 退出Composer镜像
$ exit  

```

## 4、安装到虚拟主机

copy YSME目录下的全部内容，到虚拟主机的目录下即可。

## 5、测试

访问 http://你的域名/YSME/public/
如果显示 Laravel 5 字样，说明安装成功！
