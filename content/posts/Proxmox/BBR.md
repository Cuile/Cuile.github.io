---
title: "Proxmox 配置 BBR"
date: 2023-10-03T13:04:09+08:00
# draft: true

# 标签
tags:
- Proxmox
- tcp
- bbr
# 专栏
series:
# 分类
categories:
---

## 查看系统内核

```bash
$ uname -r
```
kernel 4.9 及以上已支持 tcp_bbr，看内核版本是否大于等于4.9，否则要升级内核，或者安装bbr。

bbr2 效果要好于 bbr，相当原理可查看参考文档

## 配置拥塞算法

```bash
# 查看可用的拥塞算法
$ sysctl net.ipv4.tcp_available_congestion_control

# 查看使用的拥塞算法
$ sysctl net.ipv4.tcp_congestion_control

# 设置拥塞算法
$ sysctl -w net.core.default_qdisc=fq
$ sysctl -w net.ipv4.tcp_congestion_control=bbr

# 查看设置结果
$ lsmod | grep bbr
```

## 配置持久化

```bash
$ echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
$ echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
$ sysctl -p
```

## 参考文档
- [从流量控制算法谈网络优化 – 从 CUBIC 到 BBRv2 算法](https://aws.amazon.com/cn/blogs/china/talking-about-network-optimization-from-the-flow-control-algorithm/)
- [linux手动配置BBR](https://www.jianshu.com/p/2dd5132b37b4)
- [Linux 网络调优：内核网络栈参数篇 net.core.default_qdisc](https://www.starduster.me/2020/03/02/linux-network-tuning-kernel-parameter/#netcoredefault_qdisc)