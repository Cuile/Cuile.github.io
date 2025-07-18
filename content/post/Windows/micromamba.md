---
title: "Micromamba的安装与使用"
date: 2025-07-17T01:18:10+08:00
# draft: true

tags:
- micromamba
- python
- windows
# series:
# categories:
---

## 安装

### Windows环境

#### 1. 下载
推荐使用 PowerShell[^1]
```powershell
# 下载并安装 VC++ Redistributable，需要管理员模式
> Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "$env:TEMP\vc_redist.x64.exe"
> Start-Process -Wait -FilePath "$env:TEMP\vc_redist.x64.exe" -ArgumentList "/install", "/quiet", "/norestart"
# 下载micromamba
> Invoke-Webrequest -URI https://micro.mamba.pm/api/micromamba/win-64/latest -OutFile micromamba.tar.bz2
# 使用7z解压
> & "C:\Program Files\7-Zip\7z.exe" x "micromamba.tar.bz2" -o"tmp"
# 使用tar解压，系统内置不用安装
> mkdir micromamba
> tar -xvf .\tmp\micromamba.tar -C .\micromamba\
> .\micromamba\Library\bin\micromamba.exe --help
# 查看输出
```

#### 2. 安装[^2]
```powershell
> .\micromamba\Library\bin\micromamba.exe shell init -s powershell -r C:\Your\Root\Prefix
```
默认位置为 $HOME/micromamba，也就是 C:\Users\username\micromamba 。

同时会在 PowerShell 的 Profile 文件中（相当于 Bash 的 .bashrc）添加以下代码，保证每次启动 PowerShell 时，都会自动初始化 Micromamba 。

> $HOME/Documents/WindowsPowerShell/profile.ps1
```powershell
#region mamba initialize
# !! Contents within this block are managed by 'mamba shell init' !!
$Env:MAMBA_ROOT_PREFIX = "C:\Users\username\micromamba"
$Env:MAMBA_EXE = "C:\Users\username\micromamba\Library\bin\micromamba.exe"
(& $Env:MAMBA_EXE 'shell' 'hook' -s 'powershell' -p $Env:MAMBA_ROOT_PREFIX) | Out-String | Invoke-Expression
#endregion

# 加入设置 micromamba 别名的命令。
# 设置别名后，即方便使用，也可配合 VSCode 的配置，实现自动启动开发环境。
Set-Alias -name conda -value micromamba
```
重新启动PowerShell
```powershell
# 配置包通道
> conda config append channels conda-forge
> conda config append channels free
> conda config append channels defaults
# 配置包目录
> conda config append pkgs_dirs $Env:MAMBA_ROOT_PREFIX\pkgs
# 关闭SSL验证
> conda config set ssl_verify false
# 查看 micromamba 设置
> conda info
# 初始化base环境
> conda env update -n base
```

#### 3. 创建Python环境
```yml
# env.yml
name: py3.12
channels:
  - conda-forge
  - free
dependencies:
  - python=3.12
```
```powershell
> conda create -f env.yml
# or
> conda create -n py3.12 python=3.12 -c conda-forge -c free
```

#### 4. 操作环境
```powershell
# 导出
> conda env export -n py3.12 --from-history > py3.12.yaml
# 导入
> conda env create -f py3.12.yaml
# 克隆
> conda create -n py3.12 --clone py3.12_new
# 删除
> conda env remove -n py3.12
```
---
[^1]:[Micromamba Installation](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html#operating-system-package-managers)
[^2]:[使用 Micromamba 替换 Miniconda 更快配置 Python 环境](https://zhuanlan.zhihu.com/p/622346839?utm_id=0)