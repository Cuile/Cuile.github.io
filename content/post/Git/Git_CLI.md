---
title: "Git 命令行"
date: 2022-05-16T14:32:27+08:00
# draft: true
tags:
- CLI
- git
---

## 0、基础设置

```bash
# 查看代理
git config --global --get http.proxy
git config --global --get https.proxy
# 设置代理
git config --global http.proxy http://[username:passwrod@]ip or URL:port 
git config --global https.proxy http://[username:passwrod@]ip or URL:port
# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy

# 只代理github.com
git config --global --get http.https://github.com.proxy
git config --global --get https.https://github.com.proxy
git config --global http.https://github.com.proxy http://[username:passwrod@]ip or URL:port
git config --global https.https://github.com.proxy http://[username:passwrod@]ip or URL:port
git config --global --unset http.https://github.com.proxy
git config --global --unset https.https://github.com.proxy
# push设置
git config --global push.default simple
```
- [【Git】git push.default 简析 - 简书](https://www.jianshu.com/p/b7ba3d954eb0)
- [Git忽略文件.gitignore详解](https://blog.csdn.net/ThinkWon/article/details/101447866)---

## 1、仓库

### 1.1 克隆仓库
```bash
git clone https://xxxx@bitbucket.org/xxxx/xxxx.git
# or 
git clone git@github.com:xxxxx/xxxxx.git
# 克隆指定分支，到指定目录
git clone -b branch-name repo path

git config user.name "Your Name"
git config user.email you@example.com
```

### 1.2 推送新内容到github
先在githubh上创建好项目
```bash
git init
git add .
git status -s
git config user.name "Your Name"
git config user.email you@example.com
git commit --amend --reset-author
git commit -m "first commit"
git remote add origin git@github.com:Youname/repo_name.git
git push -u origin master
```

### 1.3 导出仓库
```bash
git archive --format zip -0 \                         # 使用zip格式，不压缩
              --output output.zip \                     # 输出的文件名
              --remote git@github.com:Cuile/NMP.git \   # 远程项目地址
              master \                                  # 分支名
              ./                                        # 输出到当前目录
```

### 1.4 修改仓库URL
```bash
# 查看当前的仓库URL
git remote -v

# 修改ssh url
git remote set-url origin git@github.com:用户名/仓库名.git
```

## 2、分支

### 2.1 本地分支操作
```bash
# 拉取
git fetch origin branch-name
git pull origin branch-name

# 强制覆盖本地分支
git fetch --all
git reset --hard origin/branch-name
git pull

# 查看分支
git branch -a

# 创建分支
# 只创建一个分支
git branch branch-name
# 创建一个分支并切换到该分支
git checkout -b branch-name

# 切换分支
git checkout branch-name

# 删除分支
git branch -d branch-name

# 发布本地分支
git push 远程主机名 本地分支名:远程分支名

# 合并分支
# 将 a 分支合并到 b 分支
git checkout b
git merge a
git push

# 推送
# 查看本地项目状态
git status -s
# 添加文件 | 添加目录 | 添加所有内容
git add  file | dir | . 
# 删除 add 的文件
git rm [-r] --cached file | .
# 提交已修改的文件，但不提交未跟踪的文件
git commit -m "message" --untracked-files=no
# 提交已删除的文件
git commit -m "message" -a
# 推送到远程库
git push
```

### 2.2 远程分支操作
```bash
# 查看远程仓库地址
git remote -v

# 更新远程分支列表
# 如果你的 remote branch 不是在 origin 下，把 origin 换成你的名字
# --prune 删除远程已经删除的分支
git remote update origin --prune
```

### 2.3 删除本地文件后，从远端重新拉取最新版本
git提示： up-to-date. 但未从远端得到文件
```bash
# 1 查看本地分支是否发生变化
git branch -a

# 2 如本地库处于另一个分支中，需将本地分支重置回原分支
git checkout branch-name
git reset --hard

# 3 如本地分支没有变化，则强行 pull 覆盖本地文件
git fetch --all
git reset --hard origin/branch-name
git pull
```

### 2.4 在本地修改分支名称
```bash
# 查看本地分支
git branch -a
# 切换到要重命名的分支
git checkout branch-name
# 重命名分支
git branch -m new-branch-name
# 上传新分支
git push origin -u new-branch-name
# 删除原分支
git push origin --delete old-branch-name
```

### 2.5 更改本地分支对应的远程分支
```bash
# 拉取远程最新分支信息
git fetch origin
# 重命名本地分支
git branch -m old-branch-name new-branch-name
# 设置新的远程分支
git branch -u origin/new-branch-name
# or
git branch --set-upstream-to=origin/new-branch-name old-branch-name
# 验证配置结果
git branch -vv
# 删除旧的远程跟踪分支
git branch -dr origin/old-branch-name
```---

## 3、标签

```bash
# 查看现有的标签
git tag

# 给最新的提交打标签
git tag 1.0

# 推送所有标签
git push --tags
```---
