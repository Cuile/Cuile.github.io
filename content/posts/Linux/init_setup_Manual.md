---
title: "Linux 系统初始化配置"
date: 2022-01-17T11:07:07+08:00
# draft: true
tags: 
- linux
- CLI
- bash
- ssh
- top
series:
categories:
---

**`脚本基于Centos 7`**
记录系统初始化应操作的一系统步骤

## 1. 修改命令提示符
```bash
# ~/.bash_profile

# [HH:MM user@hostname path] 命令提示符
export PS1="[\A \u@\H \w]\\$ "

# [yyyy-mm-dd HH:MM] path
# [user@hostname] 命令提示符
export PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '
```
- [命令提示符设置参考](https://www.linuxidc.com/Linux/2017-10/147438.htm)

## 2. 远程公私钥登录
```bash
# 生成公钥、私钥
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
...
Enter a file in which to save the key (/home/you/.ssh/algorithm): <key_name>
Enter passphrase (empty for no passphrase): [输入密码]
Enter same passphrase again: [再次输入密码]
# 设置访问权限
$ chmod 600 <key_name> <key_name>.pub
# 将公钥追加到 authorized_keys 文件，可追加多个公钥
$ cat <key.pub> >> authorized_keys
# 私钥在 SSH 登录时使用
```

## 3. 修改时区
- [Systemd 系统工具命令指南](content/posts/Linux/Systmed.md#修改服务器时区)

## 网络端口操作
```bash
# 查看端口占用
# 查看所有端口占用情况
$ netstat -tlunp
# 查看指定端口占用情况
$ netstat -tlunp | grep <port>
```

## 查看系统版本
```bash
$ lsb_release -a
$ cat /etc/redhat-release
$ cat /etc/issue
```

## 系统进程操作
```bash
# 定位高CPU占用
$ ps H -eo user,pid,ppid,tid,time,%cpu,cmd --sort=%cpu
# 可视化显示CPU的使用状况的工具
$ yum install -y htop
$ htop
# 查看进程的启动目录
$ ls -l /proc/<PID>/cwd
```
- [查看CPU和内存使用情况](https://www.cnblogs.com/xd502djj/archive/2011/03/01/1968041.html)
- [查看运行进程的启动目录](https://blog.csdn.net/CHEndorid/article/details/105775330)

## 磁盘操作
```bash
# 修改硬盘挂载目录
# 卸载硬盘
$ umount -v /mnt/raid1-2disk-500G
# 修改挂载目录
$ mv /mnt/raid1-2disk-500G /mnt/raid1-250G-2disk
# 修改/etc/fstab文件里的挂载目录
$ nano /etc/fstab
# 重装挂载
$ mount -av /dev/md127 /mnt/raid1-250G-2disk
```
- [查询并筛选 磁盘空间 统计 排序](https://blog.csdn.net/u013030100/article/details/79564378)

## 修改密码
```bash
$ passwd <username>
```