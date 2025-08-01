---
title: "Tmux 命令"
date: 2024-02-21T16:08:32+08:00
# draft: true

tags:
- cli
- tmux
- linux
---

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

| 操作          | 快捷键      | 命令                                                     | 备注  |
| :---:         | :---:      | :---                                                     | :--- |
| 启动会话      |            | tmux new -s <session_name>                               |
| 进入会话      |            | tmux <attach \| a> -t <session_name \| session_index>    |
| 退出会话      | Prefix , d | detach                                                   |     
| 关闭会话      |            | tmux kill-session -t <session_name \| session_index>     |
| **命令模式** | Prefix , : |                                                          | 参考 [Tmux命令] 章节，去掉命令的"tmux"前缀，基本可以直接使用 <br> 参考 [脚本操作] 章节 
| 会话列表      |            | list-session                                             |
| 跳转会话      | Prefix , s | switch -t <session_name \| session_index>                |     
| 重命名会话    | Prefix , $ | rename-session -t <old_name \| session_index> <new_name> |     
| 翻屏模式      | Prefix , [ |                                                          | PgUp, PgDn 实现上下翻页（mac可以用 fn + ↑ ↓实现上下翻页）<br> q 退出翻屏模式 

### 窗口操作

| 操作                     | 快捷键               | 命令                                                         | 备注  |
| :---:                    | :---:               | :---                                                         | :---: |
| 窗口列表                 |                     | list-window [-t <session_name>]                               |
| 在当前会话添加一个窗口     | Prefix , c          |                                                              |
| 在当前会话的多个窗口中选择 | Prefix , w          |                                                               |
| 关闭当前会话的当前窗口    | Prefix , x          |                                                               |
| 关闭当前会话的所有窗口    | Prefix , !          |                                                               |
| 关闭会话窗口             |                     | kill-window -t <session_name \| session_index>:<window-index> |
| 切换窗口顺序             | Prefix , 数字键      |                                                               |
| 窗口导航                 | Prefix , < n \| p > |                                                               |

### 面板操作
| 操作                      | 快捷键                              | 命令                                                                     | 备注  |
| :---:                     | :---:                              | :---                                                                     |:---: |
| 面板列表                   |                                    | list-panes -t <session_name \| session_index>:<window-index>             |
| 修改面板标题               |                                    | select-pane -T "new-title" -t <session-name>:<window-index>.<pane-index> |
| 展示面板编号               | Prefix , q                         |                                                                          |
| 面板移动到窗口             |                                    | move-pane -t <session-name>:<window-index>                               |
| 将当前窗口分成左右两份      | Prefix , %                         |                                                                          |
| 将当前窗口分成上下两份      | Prefix ，"                         |                                                                          |
| 水平排列改为垂直排列        | 按住 Prefix , -                    |                                                                          |
| 垂直排列改为水平排列        | 按住 Prefix , \                    |                                                                          |
| 所有面板水平排列            |                                   | select-layout even-horizontal                                            |
| 所有面板垂直排列            |                                   | select-layout even-verticalc                                             |
| 所有面板位置顺时针轮换      | Prefix , Ctrl + o                  |                                                                          |
| 所有面板位置逆时针轮换      | Prefix , Alt + o                   |                                                                          |
| 当前面板与左侧/上方面板交换 | Prefix , {                         |                                                                          |
| 当前面板与右侧/下方面板交换 | Prefix , }                         |                                                                          |
| 交换面板                   |                                    | swap-pane -s <source-pane-index> -t <target-pane-index>                 |
| 切换当前面板的布局方向      | Prefix , Space                     |                                                                         | 
| 循环切换 5 种预设布局       | Prefix , Alt + [1~5]               |                                                                         | 
| 关闭当前面板               | Prefix , x                         |                                                                         |
| 光标在不同的窗口中跳转      | Prefix , < ↑ \| ↓ \| ← \| → >      |                                                                         |
| 调节光标所在窗口的大小      | 按住 Prefix , < ↑ \| ↓ \| ← \| → > |                                                                         |

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