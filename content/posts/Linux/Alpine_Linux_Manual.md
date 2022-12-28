---
title: "Alpine Linux 配置"
date: 2022-12-28T16:27:00+08:00
# draft: true

# 标签
tags:
- alpine linux
# 专栏
series:
- linux
# 分类
categories:
- 系统配置
---

## WindTerm 无法认证

WindTerm客户端，取消 “会话设置 -> SSH -> 验证 -> 尝试键盘交互认证” 可已正常连接。

## 终端配置和环境变量

在 /etc/profile.d 文件夹下，创建sh文件来实现。
```bash
# cli.sh
alias ll='ls -la --color=tty'
```
```bash
# keychain.sh
eval `keychain --eval ~/.ssh/github.com`
```