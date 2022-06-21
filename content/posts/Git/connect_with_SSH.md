---
title: "使用 SSH 连接 Github"
date: 2022-06-21T19:20:04+08:00
# draft: true
tags:
- git
- ssh
- keychain
---

## 生成新的 SSH Key

```bash
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
...
Enter a file in which to save the key (/home/you/.ssh/algorithm): <密钥文件名>
Enter passphrase (empty for no passphrase): [输入密码]
Enter same passphrase again: [再次输入密码]
```

## 将新的 SSH Key 添加到 Github

1. 将公钥文件的内容COPY出来

```bash
$ cat ~/.ssh/github.com.key.pub
```

2. Github.com -> "Settings" -> "SSH and GPG keys" -> "New SSH key"

> Title : 为新密钥添加描述性标签
>
> Key : 粘贴COPY的公钥内容

3. "Add SSH key"

## 使用 SSH 连接到 Github

1. 安装keychain

```bash
$ yum install -y keychain
# or
$ apk add keychain
```

2. 使用 SSH key

```bash
$ eval `keychain --eval ~/.ssh/github.com.key`
```

3. 测试连接

```bash
$ ssh -T git@github.com
...
Are you sure you want to continue connecting (yes/no)? <yes>
...
Hi username! You've successfully authenticated, but GitHub does not
provide shell access.
```

## 自动验证

在 ~/.bash_profile 或 ~/.bashrc 文件内添加，在每次登录的时候，自动添加密钥

```bash
eval `keychain --eval ~/.ssh/github.com.key`
```
