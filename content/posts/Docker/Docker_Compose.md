---
title: "Docker Compose 指令"
date: 2022-07-19T11:31:21+08:00
# draft: true

# 标签
tags:
- docker compose
- cli
# 专栏
series:
- Docker
# 分类
categories:
---

## command 指令

### 字符串方式
```yml
    command: /bin/bash -c "cp /app/dtest/config.default.yml /app/config.yml && python -u /app/dtest/tcc.py"
    # 另一种方式
    command: /bin/bash -c " while true; do sleep 1; done"
```
- [docker compose command 执行多条指令](https://blog.csdn.net/whatday/article/details/108863389)

### 配置文件方式

......

## tty 指令
启动后停在cli，等待登录
```yml
    stdin_open: true # 对应 docker run 中的 -i
    tty: true        # 对应 docker run 中的 -t
```
