---
title: "Git 命令行"
date: 2022-05-16T14:32:27+08:00
# draft: true
tags:
- git
- CLI
series:
categories:
- 系统配置
---

## 1、拉取

```bash
$ git pull
```

### 1.1、删除本地文件后，从远端重新拉取最新版本

git提示： up-to-date. 但未从远端得到文件

```bash
# 1 查看本地分支是否发生变化
$ git branch -a

# 2 如本地库处于另一个分支中，需将本地分支重置回原分支
$ git checkout <branch name>
$ git reset --hard

# 3 如本地分支没有变化，则强行 pull 覆盖本地文件
$ git fetch --all
$ git reset --hard origin/<branch name>
$ git pull
```

## 2、推送
```bash
# 查看本地项目状态
$ git status -s
# 添加文件 | 添加目录 | 添加所有内容
$ git add < file | dir | . >
# 删除 add 的文件
$ git rm [-r] --cached <file | .>
# 提交变化
$ git commit -m [message]
# 推送到远程库
$ git push
# or
$ git push <远程主机名> <本地分支名>:<远程分支名>
```

### 2.1、推送新项目到github

先在githubh上创建好项目

```bash
$ git init
$ git add .
$ git status -s
$ git config --global user.name "Your Name"
$ git config --global user.email you@example.com
$ git commit --amend --reset-author
$ git commit -m "first commit"
$ git remote add origin git@github.com:Youname/repo_name.git
$ git push -u origin master
```

## 3、分支

```bash
$ git branch -a
```

### 切换分支

```bash
$ git checkout <branch name>
```

### 拉取远程分支

```bash
$ git fetch origin <branch>
$ git checkout -b <branch> origin/<branch>
$ git pull origin <branch>
```

### 更新远程分支列表

```bash
# 如果你的 remote branch 不是在 origin 下，把 origin 换成你的名字
# --prune 删除远程已经删除的分支
$ git remote update origin --prune
```

---

## 4、标签

```bash
# 查看现有的标签
$ git tag

# 给最新的提交打标签
$ git tag 1.0

# 推送所有标签
$ git push --tags
```

---

## 5、项目

### 克隆

```bash
$ git clone https://xxxx@bitbucket.org/xxxx/xxxx.git
# or 
$ git clone git@github.com:xxxxx/xxxxx.git
# 克隆指定分支，到指定目录
$ git clone -b <branch> <repo> <path>
```

### 导出

```bash
$ git archive --format zip -0 \
                --output output.zip \
                --remote git@github.com:Cuile/NMP.git \
                master \
                ./

# 使用zip格式，不压缩
--format zip -0
# 输出的文件名
--output output.zip
# 远程项目地址
--remote git@github.com:Cuile/NMP.git
# 分支名
master
# 输出到当前目录
./
```

---

## 6、代理

### 设置代理

```bash
$ git config --global http.proxy http://[username:passwrod@]<ip or URL>:port 
$ git config --global https.proxy http://[username:passwrod@]<ip or URL>:port

# 只代理github.com
$ git config --global http.https://github.com.proxy http://[username:passwrod@]<ip or URL>:port
$ git config --global https.https://github.com.proxy http://[username:passwrod@]<ip or URL>:port
```

### 查看代理

```bash
$ git config --global --get http.proxy
$ git config --global --get https.proxy

$ git config --global --get http.https://github.com.proxy
$ git config --global --get https.https://github.com.proxy
```

### 取消代理

```bash
$ git config --global --unset http.proxy
$ git config --global --unset https.proxy

$ git config --global --unset http.https://github.com.proxy
$ git config --global --unset https.https://github.com.proxy
```
