---
title: "Alpine Linux 配置"
date: 2022-12-28T16:27:00+08:00
# draft: true

# 标签
tags:
- alpine linux
- cli
- linux
# 专栏
series:
# 分类
categories:
---

## WindTerm 无法认证

WindTerm客户端，取消 “会话设置 -> SSH -> 验证 -> 尝试键盘交互认证” 可已正常连接。

## 安装 OpenSSH Server
```bash
$ apk update
$ apk add openssh-server openssh
```
```ini
; /etc/ssh/sshd_config
# 开放Root登录
- #PermitRootLogin prohibit-password
+ PermitRootLogin yes
# 解决ssh自动断开
- #ClientAliveInterval 0
- #ClientAliveCountMax 3
+ ClientAliveInterval 60
+ ClientAliveCountMax 3
```
```bash
$ rc-service sshd start

$ rc-service sshd restart
# 设置开机启动
$ rc-update add sshd
# 删除开机启动服务
$ rc-update del sshd
# 显示所有服务
# rc-status -a
```
- [Alpine安装SSH服务，并开启SSH远程登录](https://mayanpeng.cn/archives/248.html)

## 终端配置

在 /etc/profile.d 文件夹下，创建sh文件来实现。
```bash
# /etc/profile.d/30user.sh
+ alias ll='ls -la --color=tty'
# Alpine Linux BusyBox 不支持日期格式
# [HH:MM] path
# [user@hostname] 命令提示符
+ export PS1='\[\e[36;40m\][\A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '
# keychain
+ eval `keychain --eval ~/.ssh/github.com`
```
- [busybox：ash：PS1：支持的内部替换变量](https://www.cnblogs.com/jinzhenshui/p/16358242.html)

## 修改时区
```bash
# 查看当时时间
$ date -R
# 修改到 +8 时区
$ apk add tzdata
$ cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
$ echo "Asia/Shanghai" > /etc/timezone
$ apk del tzdata
```

## 修改主机名
```ini
; /etc/hostname
<hostname>
```
```bash
$ reboot
```