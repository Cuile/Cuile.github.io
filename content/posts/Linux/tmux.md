---
title: "Tmux 命令"
date: 2024-02-21T16:08:32+08:00
# draft: true

# 标签
tags:
- linux
- cli
- tmux
# 专栏
# series:
# 分类
# categories:
---

## 使用命令
```bash
# 开启新session
$ tmux
# 开启新session并命名
$ tmux new -s my_session
# 重命名会话
$ tmux rename-session -t 0 <new-name>

# 显示所有session
$ tmux ls

# 使用session编号接入
$ tmux attach -t 0
# 使用session名称接入
$ tmux attach -t <session-name>
$ tmux a -t name #简写

# 使用session编号切换
$ tmux switch -t 0
# 使用session名称切换
$ tmux switch -t <session-name>

# 使用session编号kill
$ tmux kill-session -t 0
# 使用session名称kill
$ tmux kill-session -t <session-name>
```

## session快捷键

需要提醒大家的是，所有的快捷键都是ctrl + b，按完松开，再去按下一个功能键！，不是一下子全按上。

**选择需要跳转的session**
>Ctrl + b s

**重命名当前session**
>Ctrl + b $

**断开当前session**
>Ctrl + b d

**进入tmux翻屏模式**
>Ctrl + b [  
>进入翻屏模式后PgUp PgDn 实现上下翻页（mac可以用fn + ↑ ↓实现上下翻页）
>
>q 退出翻屏模式

## window快捷键
**在当前session中多加一个window**
>Ctrl + b c

**在一个session中的多个window中作出选择**
>Ctrl + b w

**关闭当前session中的当前window**
>Ctrl + b x

**关闭一个session中所有window**
>Ctrl + b !

**将当前window分成左右两分**
>Ctrl + b %

**将当前window分成上下两分**
>Ctrl + b "

**让光标在不同的window中跳转**
>Ctrl + b 方向键

**调节光标所在窗口的大小**
>按住 Ctrl + b 不放，同时按住方向键

- [$ tmux使用指南：比screen好用n倍！ - 知乎](https://zhuanlan.zhihu.com/p/386085431)