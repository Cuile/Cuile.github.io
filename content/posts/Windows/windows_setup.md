---
title: "Windows配置"
date: 2024-01-08T11:49:59+08:00
# draft: true

# 标签
tags:
- 输入法
# 专栏
series:
- windows
# 分类
categories:
- 配置
---

## Windows 10 自带输入法，没有候选字栏

```powershell
> DISM /Online /Add-Capability /CapabilityName:Windows.Client.ShellComponents~~~~0.0.1.0
```

- [我用的win10自带输入法，最近不知道为什么没有候选字栏，只能用空格选定输入，怎么解决？](https://www.zhihu.com/question/427491064)