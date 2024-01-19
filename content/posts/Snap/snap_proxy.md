---
title: "snap 设置代理"
date: 2024-01-19T13:15:15+08:00
tags:
- snap
- proxy
---

使用snap 的过程中经常遇到无法链接的情况。
```bash
$ sudo snap install code --classic
error: unable to contact snap store
```
这是因为SnapCraft将软件包放在自己的海外服务器上，因为众所周知的原因，访问速度异常缓慢，不加代理的情况下，基本无法使用。

Linux上的一些应用程序会通过读取环境变量 http_proxy 和 https_proxy 来应用代理服务器设置，典型的有Chrome。

然而，Snap比较特别，它不会从环境变量中上述环境变量中读取代理服务器设置，因此直接使用
```ini
export http_proxy=[代理服务器地址]
export https_proxy=[代理服务器地址]
```
是不起作用的。

网上有一些修改配置文件的方法，个人觉得很麻烦，也容易出错，所以选了最简单可靠的命令行模式。

## 1. 设置命令
```bash
$ sudo snap set system proxy.https="http://代理服务器地址:代理端口"
$ sudo snap set system proxy.http="http://代理服务器地址:代理端口"
```

## 参考文档
- [ubuntu snap install 代理设置](https://www.cnblogs.com/brep/p/14643507.html)
- [为Snapd设置代理](https://www.jianshu.com/p/0891648b657a)