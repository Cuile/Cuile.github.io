---
title: "Proxmox 命令行"
date: 2022-12-27T16:51:54+08:00
# draft: true

# 标签
tags:
- CLI
- Proxmox
# 专栏
series:
# 分类
categories:
---
## 强制关闭虚拟贾
```bash
$ qm stop <vm id>
```
- [pve(proxmox ve)强制关闭虚拟机](https://blog.csdn.net/hlz_07/article/details/122305983)

---
## 强制删除虚拟机
```bash
$ rm -f /etc/pve/nodes/*/*/<vm id>.conf
```
- [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)

---
## 缩小硬盘

*注意不要对有系统的虚拟机硬盘进行操作*
- [ProxmoxVE(PVE) 减小缩减虚拟机硬盘设置的空间大小](https://mayanpeng.cn/archives/158.html#google_vignette)