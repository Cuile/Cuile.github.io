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
# 启动鼠标支持
set -g mouse on
set -g mode-keys vi

# WindTerm需在 会话 --> 首选项 --> 设置 --> 终端 --> 鼠标追踪 --> 追踪事件
# 取消勾选：
# - 移动事件
# - 点击事件
# - 右键单击事件
# WindTerm使用鼠标修改面板大小，受WindTerm限制无法实现

# 禁用 WindTerm 的默认鼠标行为（防止冲突）
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
# 1. 禁用左键释放自动复制（改为仅选择）
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel
# 2. 右键复制已选文本（需先左键选择）
bind -T copy-mode-vi MouseDown3Pane send-keys -X copy-pipe-and-cancel \
  "xclip -i -selection clipboard 2>/dev/null || \
   pbpaste 2>/dev/null || \
   win32yank.exe -i 2>/dev/null"
# 3. 右键直接粘贴系统剪贴板内容（跨系统支持）
bind -n MouseDown3Pane run-shell \
  "tmux set-buffer -- \"$(xclip -o -selection clipboard 2>/dev/null || \
                          pbpaste 2>/dev/null || \
                          win32yank.exe -o 2>/dev/null)\"; \
   tmux paste-buffer"

# 解除默认的鼠标调整绑定（可选）
unbind-key -T root MouseDrag1Border
# 重新绑定鼠标拖动调整大小
bind -n MouseDrag1Border resize-pane -M

# status line
set -g status-justify centre
set -g status-left "#{session_name}"
set -g status-right "%F %R"
# 窗口编号自动重新排序
set -g renumber-windows on

# status line > window list
set -g window-status-format "#{window_index}:#{window_name}"
set -g window-status-separator " | "
set -g window-status-current-format "#{window_index}:#{window_name}"
set -g window-status-current-style bold,italics

# pane
set -g pane-border-format " #{pane_index}:#{pane_title} $ #{pane_current_command} "
set -g pane-border-status top
set -g history-limit 10000
```
```bash
# 更新配置，不需要关闭tmux，直接运行马上生效
tmux source-file ~/.tmux.conf
```

## 快捷键操作
Prefix = Ctrl + b

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

*所有的快捷键都是ctrl + b按完松开，再去按下一个功能键！，不是一下子全按上。*

### 会话操作

| 操作           | 快捷键            | 命令                                                          | 
| :---           | :---             | :---                                                          | 
| 启动，会话      |                  | ```tmux new -s <session_name>```                               |
| 进入，会话      |                  | ```tmux <attach \| a> -t <session_name \| session_index>```    |
| 展示，会话列表  |                  | ```list-session```                                             |
| 跳转，会话      | ```Prefix + s``` | ```switch -t <session_name \| session_index>```                |     
| 修改，会话标题  | ```Prefix + $``` | ```rename-session -t <old_name \| session_index> <new_name>``` |     
| 翻屏模式[^1]    | ```Prefix + [``` |                                                                | 
| **命令模式**   | ```Prefix + :``` |                                                                | 
| 退出，会话      | ```Prefix + d``` | ```detach```                                                   |     
| 关闭，会话      |                  | ```tmux kill-session -t <session_name \| session_index>```     |

[^1]: PgUp, PgDn 实现上下翻页（mac可以用 fn + ↑ ↓实现上下翻页），q 退出翻屏模式。

### 窗口操作

| 操作                  | 快捷键                    | 命令                                                                 |
| :---                  | :---                      | :---                                                                |
| 展示，窗口列表         |                           | ```list-window [-t <session_name>]```                               |
| 修改，窗口标题         | ```Prefix + ,```          | ```rename-window <newp_name>```                                     |
| 添加，当前会话         | ```Prefix + c```          |                                                                     |
| 跳转，使用列表         | ```Prefix + w```          |                                                                     |
| 跳转，快速             | ```Prefix + 数字键```     |                                                                     |
| 跳转，顺序             | ```Prefix + < n \| p >``` |                                                                     |
| 交换，窗口位置         |                           | ```swap-window -s <source-window-index> -t <target-window-index>``` |
| 移动，窗口位置         |                           | ```move-window -t <new-window-index>```                             |
| 关闭，当前窗口         | ```Ctrl + d```            | ```kill-window -t <session_name \| session_index>:<window-index>``` |
| 关闭，当前会话所有窗口  | ```Prefix + !```          |                                                                     |

### 面板操作
| 操作                        | 快捷键                                    | 命令                                                                           |
| :---                        | :---                                     | :---                                                                           |
| 展示，面板列表               |                                          | ```list-panes -t <session_name \| session_index>:<window-index>```             |
| 展示，面板编号               | ```Prefix + q```                         |                                                                                |
| 修改，面板标题               |                                          | ```select-pane -T "new-title" -t <session-name>:<window-index>.<pane-index>``` |
| 拆分，将当前面板分成左右两份  | ```Prefix + %```                         |                                                                                |
| 拆分，将当前面板分成上下两份  | ```Prefix + "```                         |                                                                                |
| 排列，水平改为垂直           | ```按住 Prefix + -```                    |                                                                                |
| 排列，垂直改为水平           | ```按住 Prefix + \```                    |                                                                                |
| 排列，所有面板水平           |                                          | ```select-layout even-horizontal ```                                           |
| 排列，所有面板垂直           |                                          | ```select-layout even-verticalc```                                             |
| 移动，面板到窗口             |                                          | ```move-pane -t <session-name>:<window-index>```                               |
| 移动，所有面板位置顺时针移动  | ```Prefix + Ctrl + o```                  |                                                                                |
| 移动，所有面板位置逆时针移动  | ```Prefix + Alt + o```                   |                                                                                |
| 交换，当前面板与左侧/上方面板 | ```Prefix + {```                         |                                                                                |
| 交换，当前面板与右侧/下方面板 | ```Prefix + }```                         |                                                                                |
| 交换，指定面板               |                                          | ```swap-pane -s <source-pane-index> -t <target-pane-index>```                 |
| 布局，切换当前面板的布局方向  | ```Prefix + Space```                     |                                                                               | 
| 布局，循环切换5种预设布局     | ```Prefix + Alt + [1~5]```               |                                                                               | 
| 选中，当前窗口中的不同面板    | ```Prefix + < ↑ \| ↓ \| ← \| → >```      |                                                                                |
| 调节，光标所在面板的大小      | ```按住 Prefix + < ↑ \| ↓ \| ← \| → >``` |                                                                                |
| 关闭，当前面板               | ```Prefix + x```                         |                                                                                |

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

### 参考文档
- [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
- [tmux(1) - OpenBSD manual pages](http://man.openbsd.org/OpenBSD-current/man1/tmux.1)

## 备份与恢复
```bash
apt install tmuxp
# 备份
tmuxp freeze -f yaml -o <backup_name>.yaml <session_name>
# 恢复
tmuxp load -s <new_session_name> <backup_name>.yaml 
```
- [tmuxp](https://tmuxp.git-pull.com/)