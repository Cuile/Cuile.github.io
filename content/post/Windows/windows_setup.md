---
title: "Windows配置"
date: 2024-01-08T11:49:59+08:00
# draft: true

tags:
- 输入法
- windows
---

## Windows 10 自带输入法，没有候选字栏

```powershell
> DISM /Online /Add-Capability /CapabilityName:Windows.Client.ShellComponents~~~~0.0.1.0
```

- [我用的win10自带输入法，最近不知道为什么没有候选字栏，只能用空格选定输入，怎么解决？](https://www.zhihu.com/question/427491064)

## 卸载预装应用
```powershell
# 查看所有预装应用
> Get-AppxPackage | Select Name, PackageFullName

# 移除指定应用（例如 Xbox）
> Get-AppxPackage *xbox* | Remove-AppxPackage

# 移除所有用户的应用（加 -AllUsers）
> Get-AppxPackage -AllUsers *Microsoft.YourPhone* | Remove-AppxPackage -AllUsers

# 彻底禁用自动安装（防止更新后恢复）
> Set-Content -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord
```

## 自定义命令
```powershell
Set-Alias -name ll -value Get-ChildItem -Force
```