---
title: "OpenWRT 版本区别"
date: 2023-10-04T14:10:17+08:00
# draft: true

tags:
- version
- OpenWRT
---

## x86

| 版本 | 说明 |
| :-: | :--- |
| 64 | 用于现代PC硬件（大约在2007年以后的产品），它是为具有64位功能的计算机而构建的，并支持现代CPU功能。除非有充分的理由，否则请选择此选项。|
| Generic | 仅适用于32位硬件（旧硬件或某些Atom处理器），应为i586 Linux体系结构，将在Pentium 4及更高版本上运行。仅当您的硬件无法运行64位版本时才使用此功能。|
| Legacy | 用于奔腾4之前的非常旧的PC硬件，在Linux体系结构支持中称为i386。它会错过许多现代硬件上想要/需要的功能，例如多核支持以及对超过1GB RAM的支持，但实际上会在较旧的硬件上运行，而其他版本则不会。|
| Geode | 是为Geode SoC定制的自定义旧版目标，Geode SoC仍在许多（老化的）网络设备中使用，例如PCEngines的较旧Alix板。|

| 文件名 | 说明 |
| :---: | :--- |
| Combined | 组合的，包括bootloader、kernel、rootfs |
| squashfs | 该磁盘映像使用传统的OpenWrt布局，一个squashfs只读根文件系统和一个读写分区，在其中存储您安装的设置和软件包。由于此映像的组装方式，您只有230 兆MB的空间来存储其他程序包和配置，而Extroot不起作用。squashfs适用于直接编译带有软件包的openwrt系统，方便重置路由器，不必从安装包重新刷机。|
| ext4 | 此磁盘映像使用单个读写ext4分区，没有只读squashfs根文件系统，因此可以扩大分区。故障安全模式或出厂重置等功能将不可用，因为它们需要只读的squashfs分区才能起作用。选择64的情况下，ext4适合我们扩容，并安装软件包。|
| efi | 指的是UEFI，可以使用GPT分区列表，是较新的技术，性能和可扩展性上更好，不带efi的则是使用Legacy。 |
| bootloader | 引导程序 |
| kernel | Linux内核 |
| rootfs | openwrt根系统 |

### 参考文档

- [OpenWrt on x86 hardware (PC / VM / server)](https://openwrt.org/docs/guide-user/installation/openwrt_x86)
- [安装OpenWrt到电脑，安装包选哪个？](https://blog.csdn.net/WTCLLB/article/details/131094724)
- [openwrt x86版本](https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=193351&page=1&authorid=227980)
- [原版Openwrt在x86平台上的安装和配置以及常用插件安装](https://www.bilibili.com/read/cv21254550/)

