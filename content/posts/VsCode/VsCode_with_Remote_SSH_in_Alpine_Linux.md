---
title: "VsCode_with_Remote_SSH_in_Alpine_Linux"
date: 2023-01-03T20:42:02+08:00
# draft: true

# 标签
tags:
-  alpine linux
- remote ssh
# 专栏
series:
- vscode
# 分类
categories:
- 系统配置
---

VsCode Remote SSH 默认是不支持 Alpine Linux 的，不过，对 Alpine Linux 进行一些改动，就可以实现，比较方便。

步骤如下：

## 安装

1. [安装 Bash](../Linux/Alpine_Linux_Bash.md)
2. 安装需要的包
```bash
$ apk del dropbear
$ apk add gcompat libstdc++6 openssh wget git
```

## Alpine 配置
```bash 
$ nano /etc/ssh/sshd-config
```
```config
AllowTcpForwarding yes
PermitTunnel       yes
```

## git 配置

1. VsCode 连接 Alpine Linux
2. F1 > "Preferences: Open Remote Settings (JSON) (SSH: <host name>)"
3. 添加下面的内容：
```json
{
	"git.path": "/usr/bin/git",
}
```

### 参考文档：
- [Alpine Linux and VS Code Remote SSH](https://johnsiu.com/blog/alpine-vscode/)
- [Working with Remote SSH in Alpine](https://www.reddit.com/r/vscode/comments/smw8tn/working_with_remote_ssh_in_alpine/)
- [ssh_config(5) — Linux manual page](https://man7.org/linux/man-pages/man5/ssh_config.5.html)