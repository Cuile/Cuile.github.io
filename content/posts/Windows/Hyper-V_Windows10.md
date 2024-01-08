---
title: "Windows 10 家庭版安装 Hyper-V"
date: 2022-12-26T20:55:50+08:00
# draft: true

# 标签
tags:
- Windows
- Hyper-V
- 系统配置
# 专栏
series:
# 分类
categories:
---

一般新电脑买来都默认安排家庭版，相比专业版一个主要的区别就是没有Hpyer-V 功能。
Hpyer-V 功能支持虚拟机，Windows原生的虚拟机在资源占用方便很有优势，不只是对开发人员有用，对日常办公也非常方便。

- 常用的办公软件环境统一
- 迁移方便
- 控制流氓软件占用资源
- 可随时通过还原点，还原系统

## 1. 安装脚本

```bash
pushd "%~dp0"
 
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
 
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
 
del hyper-v.txt
 
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
```
保存为Hyper-V.cmd

## 2. 运行脚本

将脚本放到桌面，右键“以管理员身份运行”，等待安装结束后，就可以使用 Hyper-V 功能了。

## 3. 其它

- [在 Windows 或 Windows Server 的 Hyper-V 中升级虚拟机版本](https://learn.microsoft.com/zh-cn/windows-server/virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server)