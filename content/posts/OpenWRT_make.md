---
title: "编译x86_64版本的OpenWrt"
date: 2022-02-08T10:05:20+08:00
# draft: true
tags:
- OpenWRT
- 
---

## 1、准备环境

建议使用纯linux系统进行编译，如 Ubuntu 20.04 LTS，这样环境比较简单，兼容问题也少。

> 用WSL环境编译，可参考  
> - [使用 Windows 子系统 ( WSL ) 编译 OpenWrt](https://p3terx.com/archives/compiling-openwrt-with-wsl.html)

为提高编译的成功率，采用国内大神Lean的版本。

官方版本因编译过程中，下载、兼容等等太多问题，建议不要使用。

```bash
sudo apt-get update
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync
```

## 2、下载代码

国内用户请准备好梯子
```bash
git clone https://github.com/coolsnowwolf/lede
cd lede
./scripts/feeds update -a
./scripts/feeds install -a
```

## 3、配置组件

```bash
make menuconfig
```
> Hyper-V平台配置，可参考  
> - [让OpenWRT完美适应Hyper-V](https://soha.moe/post/make-openwrt-fits-hyperv.html)

## 4、开始编译

```bash
make -j8 download V=sc
make -j1 V=sc
```
编译过程中下载库很难一次成功，如果编译报错，可多尝试几次，每次都可以补全几个文件
> 详细的命令说明，可参考  
> - [OpenWrt 编译步骤与命令详解教程](https://p3terx.com/archives/openwrt-compilation-steps-and-commands.html)  
> - [如何编译一个属于自己的OpenWrt固件](https://openwrt.club/1.html)

编译完成无报错的情况下，最终文件在
```bash
cd ./bin/targets/x86/64/
```

## 5、转成vhdx格式

vhdx格式，可以方便的在Hyper-V虚拟机中使用
```bash
qemu-img convert something.vmdk -O vhdx something.vhdx
```
> 如何使用，可参考  
> - [在 Windows 10 上使用 Hyper-V 安装 LEDE 软路由](https://blog.skk.moe/post/hyper-v-win10-lede/)


## 参考文档

- [Lean Github](https://github.com/coolsnowwolf/lede)  
- [openwrt.org](https://openwrt.org/)  
- [Quickstart build images](https://openwrt.org/docs/guide-developer/quickstart-build-images)