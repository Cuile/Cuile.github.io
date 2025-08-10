---
title: "Scoop的安装与使用"
date: 2025-07-16T18:10:23+08:00
# draft: true

tags:
- windows
- scoop
# series:
# categories:
---

## 安装

### 1. 环境准备
```powershell
# PowerShell 版本：≥5.0
> $PSVersionTable.PSVersion

# .NET Framework：≥4.5
> $PSVersionTable.CLRVersion
```
- [下载 .NET Framework](https://dotnet.microsoft.com/zh-cn/download/dotnet-framework)
- [在 Windows 上安装 .NET](https://learn.microsoft.com/zh-cn/dotnet/core/install/windows)

### 2. 安装
```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# 普通用户安装
> Invoke-RestMethod -Uri https://blog.cuile.com/attachments/scripts/scoop_install.ps1 | Invoke-Expression
# 管理员用户安装
> irm blog.cuile.com/attachments/scripts/scoop_install.ps1 -outfile 'install.ps1'
> .\install.ps1 -RunAsAdmin
# 默认安装到 C:\Users\<user>\scoop
# 验证安装
> scoop help
# 安装aria2，提升下载速度
> scoop install aria2
# 安装7zip，提升解压成功率
> scoop install 7zip
```
强制使用7zip解压
```json
// ~\.config\scoop\config.json
{
  "7ZIPEXTRACT_USE_EXTERNAL": true
}
```

### 3. 使用
```powershell
```