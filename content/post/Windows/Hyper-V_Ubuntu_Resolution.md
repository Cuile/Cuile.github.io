---
title: "Hyper-V 下设置 Ubuntu 分辨率"
date: 2022-12-26T20:58:50+08:00
# draft: true

tags:
- Ubuntu
- Hyper-V
- windows
---

Hyper-V 环境下安装 Linux 是无法调节分辨率的，但可以通过设置指定分辨率，不过最大只能支持1920x1080

##  1. 修改配置文件
```bash
$ sudo nano /etc/default/grub
```
将配置
```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash "
```
修改为
```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1920x1080"
```
这里要注意屏幕的实际分辨率，在15寸的笔记本上，适合的分辨率为1600x900

## 2. 更新 Grub
```bash
$ sudo update-grub
```

## 3. 重启
```bash
$ reboot
```

## 参考文档
[Hyper-V 下 Ubuntu/Deepin 如何设置分辨率](https://www.pcoic.com/system/743.html)