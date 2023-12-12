---
title: "Alpine Linux 配置"
date: 2022-12-28T16:27:00+08:00
# draft: true

# 标签
tags:
- alpine linux
# 专栏
series:
# 分类
categories:
---

## WindTerm 无法认证

WindTerm客户端，取消 “会话设置 -> SSH -> 验证 -> 尝试键盘交互认证” 可已正常连接。

## 终端配置和环境变量

在 /etc/profile.d 文件夹下，创建sh文件来实现。
```bash
# cli.sh
alias ll='ls -la --color=tty'
# ash.sh
# Alpine Linux
# BusyBox 不支持日期格式
# [HH:MM] path
# [user@hostname] 命令提示符
export PS1='\[\e[36;40m\][\A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\]  \\$ '
# keychain.sh
eval `keychain --eval ~/.ssh/github.com`
```

## 安装 OpenSSH Server
```bash
$ apk update
$ apk add openssh-server openssh
# 开放Root登录
$ echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# 设置开机启动
$ rc-update add sshd
# 删除开机启动服务
$ rc-update del sshd

$ rc-service sshd start
$ rc-service sshd restart
# 显示所有服务
# rc-status -a
```
- [Alpine安装SSH服务，并开启SSH远程登录](https://mayanpeng.cn/archives/248.html)