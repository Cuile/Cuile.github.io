---
title: "Linux系统命令"
date: 2022-01-17T11:07:07+08:00
# draft: true
tags: 
- Linux
- Centos 7
- bash
---

**`脚本基于Centos 7`**

## 系统进程操作

- [查看CPU和内存使用情况](https://www.cnblogs.com/xd502djj/archive/2011/03/01/1968041.html)

```bash
# 定位高CPU占用
$ ps H -eo user,pid,ppid,tid,time,%cpu,cmd --sort=%cpu
# 可视化显示CPU的使用状况的工具
$ yum install -y htop
$ htop
```

## 磁盘操作

- [查询并筛选 磁盘空间 统计 排序](https://blog.csdn.net/u013030100/article/details/79564378)

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
## 网络端口操作

```bash
# 查看端口占用
# 查看所有端口占用情况
$ netstat -tlunp
# 查看指定端口占用情况
$ netstat -tlunp | grep <port>
```
## 文件操作

- [文件截取](https://blog.csdn.net/kangaroo_07/article/details/43733891)

## 系统设置操作

```bash
# systemctl命令
systemctl list-units            ##列出当前系统服务的状态
systemctl list-unit-files       ##列出服务的开机状态
systemctl status sshd           ##查看指定服务的状态
systemctl stop sshd             ##关闭指定服务
systemctl start sshd            ##开启指定服务
systemctl restart sshd          ##从新启动服务
systemctl enable sshd           ##设定指定服务开机开启
systemctl disable sshd          ##设定指定服务开机关闭
systemctl reload sshd           ##使指定服务从新加载配置
systemctl list-dependencies sshd    ##查看指定服务的倚赖关系
systemctl mask  sshd            ##冻结指定服务
systemctl unmask sshd           ##启用服务
systemctl set-default multi-user.target ##开机不开启图形
systemctl set-default graphical.target  ##开机启动图形
```

```bash
# /etc/hosts
# sed 参考 http://man.linuxde.net/sed
        #  https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html
$ sed ......
```

```bash
# SSH连接不自动断开
$ sed -i 's|^#\(ClientAliveInterval\) 0$|\1 60|g' /etc/ssh/sshd_config
$ sed -i 's|^#\(ClientAliveCountMax\) 3$|\1 5|g' /etc/ssh/sshd_config
$ systemctl restart sshd
```

```bash
# 设置主机名
$ _hostname_=XXXX
$ hostnamectl --static set-hostname ${_hostname_}
$ hostnamectl --transient set-hostname ${_hostname_}
$ hostnamectl --pretty set-hostname ${_hostname_}
```
- [hostnamectl 参考](https://blog.csdn.net/tantexian/article/details/45958275)

```bash
# 修改命令提示符
$ echo 'export PS1="[\A \u@\H \w]\\$ "' >> /etc/bashrc
# 让配置生效
$ source /etc/bashrc
```
- [命令提示符设置参考](https://www.linuxidc.com/Linux/2017-10/147438.htm)

```bash
# 修改服务器时区
$ timedatectl set-timezone Asia/Shanghai
```
- [timedatectl 参考](https://www.jianshu.com/p/5e8e22bf135d)

```bash
# 查看系统版本
$ lsb_release -a
$ cat /etc/redhat-release
$ cat /etc/issue
```

```bash
# 修改密码
$ passwd <user_name>
```

