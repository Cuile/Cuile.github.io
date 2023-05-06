---
title: "Deepin"
date: 2023-05-06T20:20:12+08:00
# draft: true

# 标签
tags:
- deepin
# 专栏
series:
- linux
# 分类
categories:
- 系统配置
---

## 在hyper-v虚拟机下调节分辨率

```bash
$ sudo nano /etc/default/grub
```

修改配置项
```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1366x768"
```

更新 grub
```bash
$ sudo /usr/lib/deepin-api/adjust-grub-theme
$ sudo update-grub
```

*注意：这种方法最高只能支持 1920×1080 的分辨率，对于大显示器，高 DPI 的童鞋，可以考虑用 RDP，VNC 等方式来用上更高的分辨率。*

### 参考文档
- https://www.jianshu.com/p/f7fd7b708a65

## 使用运程桌面连接

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