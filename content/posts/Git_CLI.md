---
title: "Git 命令行"
date: 2022-05-16T14:32:27+08:00
# draft: true
tags:
- git
---

## 拉取代码

```bash
$ git pull
```

## 切换分支

```bash
$ git branch -a
$ git checkout <branch name>
```

## 打标签

```bash
# 查看现有的标签
$ git tag

# 给最新的提交打标签
$ git tag 1.0

# 推送所有标签
$ git push --tags
```

## 克隆项目

```bash
# 使用ssh需要设置publickey比较麻烦
$ git clone https://xxxx@bitbucket.org/xxxx/xxxx.git
```

## 导出项目

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
