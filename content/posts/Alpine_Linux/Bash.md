---
title: "Alpine Linux 安装 Bash"
date: 2023-01-03T20:08:42+08:00
# draft: true

# 标签
tags:
- linux
- bash
# 专栏
series:
- alpine linux
# 分类
categories:
---

Alpine Linux 原始安装的是 busybox，小巧精干，但毕竟与主流的 Bash 还是有区别，特别是与其它系统联动时会比较麻烦，所以还是安装 Bash，统一 Shell 环境，方便日后使用。

而且基本网上的安装教程都有问题，所以这里给出正确的安装步骤。

## 安装
```bash
$ apk add bash libuser
```

## 配置
```bash
$ touch /etc/login.defs
$ mkdir /etc/default
$ touch /etc/default/useradd
$ lchsh <root>
Changing shell for root.
Password: <root password>
New Shell [/bin/ash]: /bin/bash
Shell changed.
```

### 参考文档：
- [Working with Remote SSH in Alpine](https://www.reddit.com/r/vscode/comments/smw8tn/working_with_remote_ssh_in_alpine/)
- [Linux命令之 chsh -- 用来更换登录系统时使用的shell](https://blog.csdn.net/liaowenxiong/article/details/120494681)