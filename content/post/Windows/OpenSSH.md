---
title: "OpenSSH的安装与使用"
date: 2025-07-17T02:06:38+08:00
# draft: true

tags:
- windows
- openssh
# series:
# categories:
---

1. 安装 OpenSSH 客户端
```powershell
# 检查是否已安装 OpenSSH 客户端
> Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*'

# 安装 OpenSSH 客户端
> Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# 验证安装
> ssh -V
```

2. 安装 OpenSSH 服务器
```powershell
# 检查是否已安装 OpenSSH 服务器
> Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'

# 安装 OpenSSH 服务器
> Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# 启动 SSH 服务并设置为自动启动
> Start-Service sshd
> Set-Service -Name sshd -StartupType Automatic

# 检查服务状态
> Get-Service sshd
# 重启服务
> Restart-Service sshd
```

3. 配置防火墙（允许 SSH 端口 22）
```powershell
# 允许入站 SSH 连接
> New-NetFirewallRule -Name "OpenSSH-Server" -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```