---
title: "Django 开发简介"
date: 2022-05-10T16:30:13+08:00
# draft: true
tags:
series:
- Django
- Docker
- Python
categories:
- 编程
---

## 1 开发环境

开发环境还是建议使用 Docker 来搭建，方便快捷。
不过 Django 的官方镜像已经弃用了，官方建议新版本使用 Python 官方提供的镜像来构建。

```
Docker
  ┗ Python == 3.9.12-buster
      ┗ Django == 3.2.13 LTS
      ┗ django-simpleui==2022.11.30
```

可以参考[https://github.com/Cuile/Docker-to-Python/tree/master/Django]，提供了 Dockerfil、yml 文件，还提供全套使用命令。


## 2 创建项目

```bash
# 创建项目
$ django-admin startproject xxx

$ cd xxx

# 生成项目
$ python manage.py startapp websrc
# 运行项目测试
$ python manage.py runserver 0.0.0.0:80
# 创建表
$ python manage.py migrate
# 创建管理员
$ python manage.py createsuperuser
```

### 2.1 配置项

修改配置后，建议使用项目调试的方式启动，不要使用快捷命令，项目正常启动稳定运行后，再使用快捷命令。

```python
# settings.py

# 任意地址都可以访问 Django
ALLOWED_HOSTS = ['*'] 

# 添加 simpleui 模板，和创建的项目
INSTALLED_APPS = [
  'simpleui',
  '......',
  'websrc',
]

# 这个与多语种有关，在项目初始阶段不要修改，后续添加了多语种支持再修改，否则会导致无法启动。
# 具体参考(http://www.i18nguy.com/unicode/language-identifiers.html)，有个傻逼教程，上来就改成 zh-CN 果然导致项目无法正常启动。
# 正确的简体中文代码如下：
LANGUAGE_CODE = 'zh-Hans'

# 时区，上海就代表北京时间，这个不能写错，写错就启动不了
# 具体参考(https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)，这里是标准的，有个傻逼教程非给写成 Asia/Beijing 导致怎么都起不来，太TMD的二逼了。
# 正解的北京时间时区如下：
TIME_ZONE = 'Asia/Shanghai'

# 启动翻译，与上面的 LANGUAGE_CODE 设置相对应
USE_I18N = True
# 启动格式控制
USE_L10N = True
# 启动时区
USE_TZ = True
```
