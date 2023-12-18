---
title: "Systemd 系统工具命令指南"
date: 2022-12-27T17:29:08+08:00
# draft: true

# 标签
tags:
- Systemd
- CLI
# 专栏
series:
- Linux
# 分类
categories:
- 系统配置
---

## systemctl命令
```bash
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
- [拾遗：systemctl --user]https://www.cnblogs.com/hadex/p/6571278.html)
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)
- [Systemd 定时器教程](https://www.ruanyifeng.com/blog/2018/03/systemd-timer.html)

## 设置主机名
```bash
$ _hostname_=XXXX
$ hostnamectl --static set-hostname ${_hostname_}
$ hostnamectl --transient set-hostname ${_hostname_}
$ hostnamectl --pretty set-hostname ${_hostname_}
```
参考文档
- [hostnamectl 参考](https://blog.csdn.net/tantexian/article/details/45958275)

## 修改服务器时区
```bash
$ timedatectl set-timezone Asia/Shanghai
```
参考文档
- [timedatectl 参考](https://www.jianshu.com/p/5e8e22bf135d)