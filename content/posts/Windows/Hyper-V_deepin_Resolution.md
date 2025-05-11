---
title: "Hyper-V 下设置 Deepin 分辨率"
date: 2023-05-06T20:20:12+08:00
# draft: true

# 标签
tags:
- deepin
- Hyper-V
# 专栏
series:
- windows
# 分类
categories:
- 配置
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

