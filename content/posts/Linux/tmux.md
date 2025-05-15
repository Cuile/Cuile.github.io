---
title: "Tmux 命令"
date: 2024-02-21T16:08:32+08:00
# draft: true

tags:
- cli
- tmux
- linux
---

## 使用命令
```bash
# 开启新会话
tmux
# 开启新会话并命名
tmux new -s my_session
# 重命名会话
tmux rename-session -t 0 <new-name>

# 显示所有会话
tmux ls
# 显示会话的窗口
tmux list-window -t <session-name>
# 显示会话窗口的栅格
tmux list-pane -t <session-name>:<window-index>

# 使用会话编号接入
tmux attach -t 0
# 使用会话名称接入
tmux attach -t <session-name>
tmux a -t name #简写

# 切换会话
tmux switch -t 0
tmux switch -t <session-name>

# 关闭会话
tmux kill-session -t 0
tmux kill-session -t <session-name>
# 关闭会话窗口
tmux kill-window -t <session-name>:<window-index>
# 修改会话窗口栅格标题
tmux select-pane -T "new-title" -t <session-name>:<window-index>.<pane-index>
```

## 配置文件
```ini
; ~/.tmux.conf
# 启用鼠标支持
set -g mouse on
# 显示状态栏信息（会话名、窗口索引、时间等）
set -g status-right '#[fg=green]#H #[fg=blue]%d %b %R'
# 在窗格边框显示窗格索引和当前命令
set -g pane-border-format "#{pane_index} #{pane_title}"
# 将窗格边框状态信息显示在顶部
set -g pane-border-status top
```
```bash
tmux source-file ~/.tmux.conf
```

## 会话快捷键

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

**选择需要跳转的会话**
> Ctrl + b s

**重命名当前会话**
> Ctrl + b $

**断开当前会话**
> Ctrl + b d

**进入tmux翻屏模式**
> Ctrl + b [  
>进入翻屏模式后PgUp PgDn 实现上下翻页（mac可以用fn + ↑ ↓实现上下翻页）
>
>q 退出翻屏模式

## 窗口快捷键
**在当前会话中多加一个窗口**
> Ctrl + b c

**在一个会话中的多个窗口中作出选择**
> Ctrl + b w

**关闭当前会话中的当前窗口**
> Ctrl + b x

**关闭一个会话中所有窗口**
> Ctrl + b !

**将当前窗口分成左右两分**
> Ctrl + b %

**将当前窗口分成上下两分**
> Ctrl + b "

**让光标在不同的窗口中跳转**
> Ctrl + b 方向键

**调节光标所在窗口的大小**
> 按住 Ctrl + b 不放，同时按住方向键

## 参考文档
- [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
- [tmux(1) - OpenBSD manual pages](http://man.openbsd.org/OpenBSD-current/man1/tmux.1)