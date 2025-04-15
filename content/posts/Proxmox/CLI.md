---
title: "ProxmoxVE 命令行"
date: 2022-12-27T16:51:54+08:00
# draft: true

# 标签
tags:
- ProxmoxVE
- CLI
# 专栏
series:
# 分类
categories:
---

[遇事不决，多读文档！](https://pve.proxmox.com/pve-docs/index.html)

## 虚拟机

### 创建
使用命令行创建 VM 非常方便，而且还可以使用各发行版的云镜像，快速创建速度又快，占用空间又小，非常方便。
<script src="https://gist.github.com/Cuile/6e42bea498355d5cafaacfa66981daf9.js"></script>
---

### 调整硬盘大小
```bash
# 增加硬盘空间
# 建议从模板创建虚拟机后，再增加虚拟机硬盘的空间，这样可以保持模板的大小
qm disk resize <VM_ID> scsi0 +30G
```
*注意不要对有系统的虚拟机硬盘进行操作*
- [ProxmoxVE(PVE) 减小缩减虚拟机硬盘设置的空间大小](https://mayanpeng.cn/archives/158.html#google_vignette)
---

## 关闭
```bash
qm stop <vmid>
# 如果关闭失败
qm list
# 找到 vm 对应的 pid
kill <pid>
```
---

## 删除
```bash
qm destroy <vmid> --destroy-unreferenced-disks 1 --purge 1 --skiplock 1
```
---

## 强制删除
```bash
rm -f /etc/pve/nodes/*/*/<vm_id>.conf
```
- [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)
---

## LXC容器

### 关闭
```bash
pct stop <vmid>
pct list
```
---