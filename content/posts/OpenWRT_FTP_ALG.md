---
title: "启用 FTP ALG 功能"
date: 2022-02-07T10:08:02+08:00
# draft: true
tags:["OpenWRT","FTP","ALG"]
---



## 1. 安装软件包
```bash
# opkg install kmod-nf-nathelper-extra
# opkg install kmod-nf-ipvs-ftp
```

## 2. 添加配置
```bash
# nano /etc/sysctl.d/11-nf-conntrack.conf
```

增加"net.netfilter.nf_conntrack_helper=1"

在使用FTP的主动模式时，要注意关闭网关上的ALG功能（如Windows ALG服务），同时使用可能引起失败

**参考文档**

- [原版OpenWRT启用FTP ALG功能](https://vnf.cc/2021/02/openwrt-ftp-alg/)
- [防火墙设置了NAT ALG功能导致FTP数据连接故障](https://blog.moper.net/2210.html)