---
title: "使用 SSH 连接 Github"
date: 2022-06-21T19:20:04+08:00
# draft: true
tags:
- ssh
- keychain
- git
- github.com
series:
categories:

---

## 生成新的 SSH Key

```bash
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
...
Enter a file in which to save the key (/home/you/.ssh/algorithm): <key_name>
Enter passphrase (empty for no passphrase): [输入密码]
Enter same passphrase again: [再次输入密码]
```

## 将新的 SSH Key 添加到 Github

1. 将公钥文件的内容COPY出来

```bash
$ cat ~/.ssh/<私钥文件名>.pub
```

2. Github.com -> "Settings" -> "SSH and GPG keys" -> "New SSH key"

> Title : 为新密钥添加描述性标签
>
> Key : 粘贴COPY的公钥内容

3. "Add SSH key"

## 使用 SSH 连接到 Github

1. 测试连接
```bash
# 设置访问权限
$ chmod 600 <key_name> <key_name>.pub

$ ssh -T -p 443 git@ssh.github.com
...
Are you sure you want to continue connecting (yes/no)? <yes>
...
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

2. ssh config
```ini
; ~/.ssh/config

Host github.com
  Hostname ssh.github.com
  Port 443
  IdentityFile ~/.ssh/cuile.key
  User git
```

3. 连接测试
```bash
$ ssh -T git@github.com
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

## 自动验证

如果找不到软件，[直接下载安装](https://crpm.cn/keychain-2-8-5-1-el7-noarch-rpm/) 或 更换软件源 [Linux 版本库管理](../linux/Linux_repo_Manual.md)
```bash
# 安装keychain
$ yum install -y keychain
# or
$ apk add keychain

# ~/.bash_profile or ~/.bashrc
+ eval `keychain --eval ~/.ssh/github.com.key`
```

- [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/cn/github-ae@latest/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Funtoo Keychain Project](https://www.funtoo.org/Funtoo:Keychain)
