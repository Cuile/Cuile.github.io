---
title: "screen 命令"
date: 2022-12-28T14:24:08+08:00
# draft: true

tags:
- cli
- screen
- linux
---

***已弃用，转到 [Tmux 命令]({{< ref "tmux.md">}})***

## 创建屏幕
```bash
# 离线方式创建屏幕，一般用在启动脚本
$ screen -S <screen_name> -d -m
```
## 查年屏幕
```bash
$ screen -ls
```

## 执行命令
```bash
# 在指定屏幕内输入cmd，注意\n代表回车
$ screen -S <screen_name> -X stuff "<cmd>\n"
# 在当前窗口内，通过另一个过滤进程控制窗口的输入或输出。
# 非常复杂，还没有搞明白有什么用
# 官方建议：小心使用！
$ screen -S <screen_name> -X |<cmd>
$ screen -S <screen_name> -X !..|<cmd>
$ screen -S <screen_name> -X exec<cmd>
```
参考文档
- [screen stuff](https://www.gnu.org/software/screen/manual/screen.html#index-stuff)
- [screen exec](https://www.gnu.org/software/screen/manual/screen.html#index-exec)

## 离开屏幕
在 screen 终端下，按 Ctrl+a d 键

## 退出屏幕
```bash
# 进入指定屏幕，再退出
$ screen -r <screen_name|pid>
$ exit
# 指定屏幕，直接退出
$ screen -S <screen_name> -X quit
```