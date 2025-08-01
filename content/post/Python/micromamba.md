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
### Windows
#### 1. 下载
推荐使用 PowerShell[^1]
```powershell
# 下载并安装 VC++ Redistributable，需要管理员模式
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "$env:TEMP\vc_redist.x64.exe"
Start-Process -Wait -FilePath "$env:TEMP\vc_redist.x64.exe" -ArgumentList "/install", "/quiet", "/norestart"
# 下载micromamba
Invoke-Webrequest -URI https://micro.mamba.pm/api/micromamba/win-64/latest -OutFile micromamba.tar.bz2
# 使用7z解压
& "C:\Program Files\7-Zip\7z.exe" x "micromamba.tar.bz2" -o"tmp"
# 使用tar解压，系统内置不用安装
mkdir micromamba
tar -xvf .\tmp\micromamba.tar -C .\micromamba\
.\micromamba\Library\bin\micromamba.exe --help
# 查看输出
```
#### 2. 安装[^2]
```powershell
.\micromamba\Library\bin\micromamba.exe shell init -s powershell -r C:\Your\Root\Prefix
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
```

加入设置 micromamba 别名的命令。
设置别名后，即方便使用，也可配合 VSCode 的配置，实现自动启动开发环境。
```powershell
Set-Alias -name conda -value micromamba
```
### Debian
#### 1. 下载
```bash
# 下载可执行文件
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
mv bin/ micromamba
micromamba/micromamba --help
# 查看输出
```
#### 2. 安装[^2]
```bash
~/micromamba/micromamba shell init -s bash -r ~/micromamba
```
> ~/.bashrc
```bash

# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \$ '
eval SSH_AUTH_SOCK=/tmp/ssh-XXXXXXFcYYOW/agent.55612; export SSH_AUTH_SOCK;
SSH_AGENT_PID=55613; export SSH_AGENT_PID;

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/root/micromamba/micromamba';
export MAMBA_ROOT_PREFIX='/root/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
```
```bash
echo "alias conda='micromamba'" >> ~/.bashrc
```

## 配置
重新启动命令行环境
```shell
# 配置包通道
conda config append channels conda-forge
conda config append channels free
conda config append channels defaults
# 配置包目录
# windows
conda config append pkgs_dirs $Env:MAMBA_ROOT_PREFIX\pkgs
# debian
conda config append pkgs_dirs $MAMBA_ROOT_PREFIX/pkgs
# 关闭SSL验证
conda config set ssl_verify false
# 查看 micromamba 设置
conda info
# 初始化base环境
conda env update -n base
# 升级
conda self-update
```

## 使用
### 1. 创建Python环境
```yml
# env.yml
name: py3.12
channels:
  - conda-forge
  - free
dependencies:
  - python=3.12
```
```shell
conda create -f env.yml
# or
conda create -n py3.12 python=3.12 -c conda-forge -c free
```

### 2. 操作环境
```shell
# 导出
conda env export -n py3.12 --from-history py3.12.yaml
# 导入
conda env create -f py3.12.yaml
# 克隆
conda create -n py3.12 --clone py3.12_new
# 删除
conda env remove -n py3.12
```
[^1]:[Micromamba Installation](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html#operating-system-package-managers)
[^2]:[使用 Micromamba 替换 Miniconda 更快配置 Python 环境](https://zhuanlan.zhihu.com/p/622346839?utm_id=0)