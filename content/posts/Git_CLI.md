---
title: "Git 命令行"
date: 2022-05-16T14:32:27+08:00
# draft: true
tags:
- git
---

## 拉取

```bash
$ git pull
```

### 删除本地文件后，从远端重新拉取最新版本

git提示： up-to-date. 但未从远端得到文件

1. 查看本地分支是否发生变化
```bash
$ git branch -a
```

2. 如本地库处于另一个分支中，需将本地分支熏置回原分支

```bash
$ git checkout *****
$ git reset --hard
```

3. 如本地分支没有变化，则强行 pull 覆盖本地文件

```bash
$ git fetch --all
$ git reset --hard origin/*****
$ git pull
```

## 分支

```bash
$ git branch -a
```

### 切换分支

```bash
$ git checkout <branch>
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

## 标签

```bash
# 查看现有的标签
$ git tag

# 给最新的提交打标签
$ git tag 1.0

# 推送所有标签
$ git push --tags
```

## 项目

### 克隆

```bash
# 使用ssh需要设置publickey比较麻烦
$ git clone https://xxxx@bitbucket.org/xxxx/xxxx.git
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

