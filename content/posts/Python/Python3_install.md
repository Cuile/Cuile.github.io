---
title: "CentOS 7 安装 Python3.9.12"
date: 2022-05-06T13:11:27+08:00
# draft: true
tags:
- Python3
- pip3
- CentOS 7
---

## 1、卸载已安装的Python环境

```bash
# 查看已安装的信息
$ yum info python3
# 卸载已安装的程序
$ yum erase python3
# 删除所有残余文件
$ whereis python3|xargs rm -frv
查看现有的python
$ whereis python
```

## 2、yum安装依赖环境

```bash
$ yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
```

## 3、官网下载Python3.9.12

```bash
$ yum -y install wget
# 尽量使用国内镜像站点下载比较快
$ wget https://mirrors.huaweicloud.com/python/3.9.12/Python-3.9.12.tgz
```

## 4、创建安装目录

```bash
$ tar -zxvf Python-3.9.12.tgz -C ./
$ cd  Python-3.9.12
$ mkdir /usr/local/python3 
$ ./configure --prefix=/usr/local/python3.9.12
$ make && make install
```

## 5、创建软链接

```bash
$ ln -s /usr/local/python3.9.12/bin/python3 /usr/bin/python3
$ ln -s /usr/local/python3.9.12/bin/pip3 /usr/bin/pip3
```

## 6、测试

```bash
$ python3 -V
Python 3.9.12

$ pip3 -V
pip 22.0.4 from /usr/local/python3.9.12/lib/python3.9/site-packages/pip (python 3.9)
```

## 7、pip升级、换源

```bash
# pip升级
$ python3 -m pip install --upgrade pip
# pip换源
# 推荐使用清华的源，因为使用https协议
$ pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
