---
title: "Tmux 命令"
date: 2024-02-21T16:08:32+08:00
# draft: true

tags:
- cli
- tmux
- linux
---

## Tmux命令
```bash
## Session
# 开启新会话
tmux
# 开启新会话并命名
tmux new -s my_session
# 重命名会话
tmux rename-session -t 0 <new-name>
# 显示所有会话
tmux ls
tmux list-sessions
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
# 断开会话，在后台运行
tmux detach

## Window
# 显示会话的窗口
tmux list-windows -t <session-name>

## Pane
# 显示会话窗口的面板
tmux list-panes -t <session-name>:<window-index>
# 修改会话窗口面板标题
tmux select-pane -T "new-title" -t <session-name>:<window-index>.<pane-index>
# 移动面板到窗口
tmux move-pane -t <session-name>:<window-index>
# 交换面板内容
tmux swap-pane -s <source-pane-index> -t <target-pane-index>
# 所有面板水平排列
tmux select-layout even-horizontal
# 所有面板垂直排列
tmux select-layout even-vertical
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

## 快捷键操作
Prefix = Ctrl + b

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

### 会话操作

| 操作      | 快捷键       | 命令    | 备注  |
| :---:     | :---:        | :---   | :--- |
| 命令模式   | Prefix , : |        | 参考 [Tmux命令] 章节，去掉命令的"tmux"前缀，基本可以直接使用 <br> 参考 [脚本操作] 章节 |
| 跳转会话   | Prefix , s |        |     |
| 重命名会话 | Prefix , $ |        |     |
| 断开会话   | Prefix , d | detach |     |
| 翻屏模式   | Prefix , [ |        | PgUp, PgDn 实现上下翻页（mac可以用 fn + ↑ ↓实现上下翻页）<br> q 退出翻屏模式 |

### 窗口操作

| 操作                     | 快捷键            | 备注  |
| :---:                    | :---:            | :---: |
| 在当前会话添加一个窗口     | Prefix , c     |       |
| 在当前会话的多个窗口中选择 | Prefix , w     |       |
| 关闭当前会话的当前窗口     | Prefix , x     |       |
| 关闭当前会话的所有窗口     | Prefix , !     |       |
| 切换窗口顺序              | Prefix , 数字键 |       |
| 窗口导航                  | Prefix , < n \| p > |       |

### 面板操作
| 操作                       | 快捷键                  | 备注  |
| :---:                      | :---:                  | :---: |
| 展示面板编号                | Prefix , q            |       |
| 将当前窗口分成左右两份       | Prefix , %            |       |
| 将当前窗口分成上下两份       | Prefix ，"            |       |
| 光标在不同的窗口中跳转       | Prefix , < ↑ \| ↓ \| ← \| → >      |       |
| 调节光标所在窗口的大小       | 按住 Prefix , < ↑ \| ↓ \| ← \| → > |       |
| 水平排列改为垂直排列         | 按住 Prefix , -       |       |
| 垂直排列改为水平排列         | 按住 Prefix , \       |       |
| 针旋转面板	              | Prefix , Ctrl + o       | 所有面板位置顺时针轮换
| 逆时针旋转面板	          | Prefix , Alt + o        | 所有面板位置逆时针轮换
| 交换当前面板与上一个活动面板 | Prefix , {            | 与左侧/上方面板交换
| 交换当前面板与下一个活动面板 | Prefix , }            | 与右侧/下方面板交换
| 当前面板改为水平分割	       | Prefix , Space        | 切换当前窗格的布局方向
| 切换预设布局	              | Prefix , Alt + [1~5]  |	循环切换 5 种预设布局
| 关闭当前面板                | Prefix , x            |

## 脚本操作

### Tmux格式
```bash
tmux new-session -s "${MY_SESSION}" -d \; \
    split-window -v \; \
    split-window -v -t 0 \; \
    split-window -v -t 2 \; \
    split-window -h -t 3 \; \
    select-layout 'e1ef,267x50,0,0[267x9,0,0,0,267x9,0,10,2,267x9,0,20,1,267x20,0,30{153x20,0,30,3,113x20,154,30,4}]' \; \
    select-pane -T "1step" -t 0 \; \
    select-pane -T "2step" -t 1 \; \
    select-pane -T "check" -t 2 \; \
    select-pane -T "submit" -t 3 \; \
    select-pane -T "check submitable" -t 4 \; \
    send-keys -t 0 "${ACTIVATE}${COMMAND_1STEP}" Enter \; \
    send-keys -t 1 "${ACTIVATE}${COMMAND_2STEP}" Enter \; \
    send-keys -t 2 "${ACTIVATE}${COMMAND_CHECK}" Enter \; \
    send-keys -t 3 "${ACTIVATE}${COMMAND_SUBMIT}" Enter \; \
    send-keys -t 4 "${ACTIVATE}${COMMAND_OTHER}" Enter \; \
    attach-session -t "${MY_SESSION}"
```

### Shell格式
```bash
# 在后台创建新的会话
tmux new-session -s "${MY_SESSION}" -d
# 在会话中创建窗口
# tmux new-window -t "${MY_SESSION}" -n "main"
# 在窗口中创建面板
tmux split-window -v -t "${MY_SESSION}"
tmux split-window -v -t "${MY_SESSION}":0.0
tmux split-window -v -t "${MY_SESSION}":0.2
tmux split-window -h -t "${MY_SESSION}":0.3
# 调整面板大小
# tmux resize-pane -t "${MY_SESSION}":0.0 -y 9
# tmux resize-pane -t "${MY_SESSION}":0.1 -y 9
# tmux resize-pane -t "${MY_SESSION}":0.2 -y 9
# 使用select-layout更方便
tmux select-layout -t "${MY_SESSION}" '9a1d,267x50,0,0[267x9,0,0,17,267x9,0,10,19,267x9,0,20,18,267x20,0,30{134x20,0,30,20,132x20,135,30,21}]'
# 给面板命名
tmux select-pane -T "1step" -t "${MY_SESSION}":0.0
tmux select-pane -T "2step" -t "${MY_SESSION}":0.1
tmux select-pane -T "check" -t "${MY_SESSION}":0.2
tmux select-pane -T "submit" -t "${MY_SESSION}":0.3
# 面板执行命令
tmux send-keys -t "${MY_SESSION}":0.0 "${ACTIVATE}${COMMAND_1STEP}" Enter
tmux send-keys -t "${MY_SESSION}":0.1 "${ACTIVATE}${COMMAND_2STEP}" Enter
tmux send-keys -t "${MY_SESSION}":0.2 "${ACTIVATE}${COMMAND_CHECK}" Enter
tmux send-keys -t "${MY_SESSION}":0.3 "${ACTIVATE}${COMMAND_SUBMIT}" Enter
tmux send-keys -t "${MY_SESSION}":0.4 "${ACTIVATE}${COMMAND_OTHER}" Enter
# 连接会话
tmux attach-session -t "${MY_SESSION}"
```

## 参考文档
- [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
- [tmux(1) - OpenBSD manual pages](http://man.openbsd.org/OpenBSD-current/man1/tmux.1)