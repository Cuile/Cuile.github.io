---
title: "Deepin 使用远程桌面"
date: 2023-05-06T21:04:06+08:00
# draft: true

# 标签
tags:
- deepin
- rdp
# 专栏
series:
- linux
# 分类
categories:
---

安装 xrdp
```bash
$ sudo apt install xrdp
```

启动xrdp服务，并设置为开机启动
```bash
$ sudo systemctl start xrdp
$ sudo systemctl enable xrdp
```

解决黑屏/空屏/无画面
```bash
$ nano /etc/xrdp/startwm.sh
```
```ini
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
. $HOME/.profile
```
![](https://pic1.zhimg.com/80/v2-26630883e20c4ef9ffa7beea502ab8dc_720w.webp)

重启deepin，使用Xorg模式登录
![](https://pic2.zhimg.com/80/v2-9d0e56840db9b195ebb2518d9ed42331_720w.webp)

### 参考文档
- [Deepin下安装XRDP远程连接](https://bbs.deepin.org/zh/post/209321)
- [Ubuntu/Debian/Kali xrdp远程桌面黑屏/空屏/无画面解决办法](https://zhuanlan.zhihu.com/p/456814956)