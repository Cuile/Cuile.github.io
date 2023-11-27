---
title: "VSCode 配置 Python 开发环境"
date: 2023-11-25T00:24:10+08:00
# draft: true

# 标签
tags:
- micromamba
- python
- venv
- vscode
# 专栏
# series:
# 分类
# categories:
---

使用 VSCode 开发 Python 是替代 PyCharm 的一个很好选择，有丰富的扩展和第三方工具可以使用，安装配置好它们，会让开发工作事半功倍。下面列举推荐安装的扩展和工具：

扩展
- Material Icon There
  - VSCode图标，很好看
- Python
  - 微软官方扩展，一定要装
- Pylance
  - 微软官方扩展，一定要装
- autoDocstring
- Python Environment Manager
- Ruff
- Code Runner
- Qt for Python

工具
- Micromamba
  - 使用 Micromamba 来配置 Python 开发环境有几个好处：
    - micromamba 是一个包管理器，可方便的同时安装几个软件，形成一个独立的开发环境，与其它项目的开发环境完全隔离。
    - micromamba 安装的软件，不会在系统留下痕迹，不会污染本地系统。
    - micromamba 只配置 python 基础环境，不影响 python 虚拟环境，同一个基础环境可提供给多个虚拟环境使用。

## 配置 Micromamba 
### Windows环境
#### 下载
推荐使用 PowerShell[^1]
```powershell
> Invoke-Webrequest -URI https://micro.mamba.pm/api/micromamba/win-64/latest -OutFile micromamba.tar.bz2
> tar xf micromamba.tar.bz2
> MOVE -Force Library\bin\micromamba.exe micromamba.exe
>.\micromamba.exe --help
# 查看输出
```

#### 安装[^2]
```powershell
> .\micromamba.exe shell init -s powershell
```
默认位置为 $HOME/micromamba，也就是 C:\Users\username\micromamba 。
如果想自己指定位置，可以加上 “-p \<path\>” 参数。

同时会在 PowerShell 的 Profile 文件中（相当于 Bash 的 .bashrc）添加以下代码，保证每次启动 PowerShell 时，都会自动初始化 Micromamba 。
```powershell
# $HOME/Documents/WindowsPowerShell/profile.ps1
#region mamba initialize
# !! Contents within this block are managed by 'mamba shell init' !!
$Env:MAMBA_ROOT_PREFIX = "C:\Users\username\micromamba"
$Env:MAMBA_EXE = "C:\Users\username\.micromamba\Library\bin\micromamba.exe"
(& $Env:MAMBA_EXE 'shell' 'hook' -s 'powershell' -p $Env:MAMBA_ROOT_PREFIX) | Out-String | Invoke-Expression
#endregion
```
在这段代码的下面，加入设置 micromamba 别名的命令。
```powershell
> Set-Alias -name conda -value micromamba
```
设置别名后，即方便使用，也可配合 VSCode 的配置，实现自动启动开发环境。

#### 配置 Python 基础环境
```powershell
> cd ~/micromamba
> conda create -f env.yml
```
```yml
# env.yml
name: PyQt
channels:
  - conda-forge
  - free
dependencies:
  - python 3.11
  - mingw 4.7
```

#### 配置 VSCode[^2]
配置 Venv 路径
1. 使用 “ctrl+,” 打开设置界面，搜索 venv ，出现两个结果：
    - Python: Venv Folders # 如果安装时使用默认位置，就填写 micromamba，下面的不用设置
    - Python: Venv Path    # 如果安装时没有使用默认位置，就填写安装位置，上面的不用设置
    - Python: Conda Path
2. 重启VSCode，进入 Python 项目，就可以看到右下角的 Python 环境了，如果创建了多个环境，可以通过这里切换。
3. 使用 “ctrl+`” 打开项目终端界面，看到括号里的名字，与刚才创建的基础环境名一致，就成功了。
```powershell
(PyQt) PS "Your Project Path">
```

#### 配置 Python 虚拟环境
使用项目终端界面，创建虚拟环境
```powershell
> python -m venv .venv
```
查看 VSCode 最左侧的主侧栏，打开 Python Environment Manger 扩展（Python icon）。
```
˅ WORKSPACE ENVIRONMENTS
 > .venv(3.11.0)

˅ GLOBAL ENVIRONMENTS
 ˅ Global
  > PyQt(3.11.0)
 ˅ Venv
  > .venv(3.11.0)
```
关于 Python Environment Manger 的相关操作，这里不再类述，也是非常简单的。

重启 VSCode，进入项目终端界面，看到括号里的名字，与刚才创建的虚拟环境名一致，就成功了。
```powershell
(.venv) PS "Your Project Path">
```

## 配置 VSCode
- Editor: Default Formatter # 选 Ruff

## 配置 Python
- Python > Terminal: ACtivate Env In Current Terminal # 勾选
- Python > Terminal: Focus After Launch               # 勾选
- Python: Language Server                             # 选 Pylance

## 配置 Pylance
- Pylthon > Analysis: Type Checking Mode # 选 basic

[^1]:[Micromamba Installation](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html#operating-system-package-managers)
[^2]:[使用 Micromamba 替换 Miniconda 更快配置 Python 环境](https://zhuanlan.zhihu.com/p/622346839?utm_id=0)