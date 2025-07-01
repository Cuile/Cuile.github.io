---
title: "使用 SSH 连接 Github"
date: 2022-06-21T19:20:04+08:00
# draft: true
tags:
- ssh
- keychain
- github
- git
---

## 生成新的 SSH Key

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
...
Enter a file in which to save the key (/home/you/.ssh/algorithm): <key_name>
Enter passphrase (empty for no passphrase): [输入密码]
Enter same passphrase again: [再次输入密码]
```

## 将新的 SSH Key 添加到 Github

1. 将公钥文件的内容COPY出来
```bash
cat ~/.ssh/<key_name>.pub
```

2. Github.com -> "Settings" -> "SSH and GPG keys" -> "New SSH key"
> Title : 为新密钥添加描述性标签
> Key : 粘贴COPY的公钥内容

3. "Add SSH key"

## 使用 SSH 连接到 Github
1. ssh config
```bash
cd ~/.ssh
# 设置访问权限
chmod 600 <key_name>
# 生成SSH配置文件
cat > config << EOF
Host github.com
  Hostname ssh.github.com
  Port 443
  IdentityFile ~/.ssh/<key_name>
  UpdateHostKeys yes
  Compression yes
  User git
EOF
```
- [Improving Git protocol security on GitHub - The GitHub Blog](https://github.blog/2021-09-01-improving-git-protocol-security-github/#standard-git-client)

2. 连接测试
```bash
ssh -T git@github.com
...
Are you sure you want to continue connecting (yes/no)? <yes>
...
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

## 自动验证

如果找不到软件，[直接下载安装](https://crpm.cn/keychain-2-8-5-1-el7-noarch-rpm/) 或 更换软件源 [Linux 版本库管理](../linux/Linux_repo_Manual.md)
```bash
# debian
apt install -y keychain
# centos
yum install -y keychain
# alpine linux
apk add keychain

# debian or centos in ~/.bashrc or ~/.bash_profile
# alpine linux in /etc/profile.d/30user.sh
echo "eval `keychain --eval ~/.ssh/<key_name>`" >> ~/.bashrc
...
 * Adding 1 ssh key(s): /home/<username>/.ssh/<key_name>
 * ssh-add: Identities added: /home/<username>/.ssh/<key_name>
```

- [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/cn/github-ae@latest/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Funtoo Keychain Project](https://www.funtoo.org/Funtoo:Keychain)
