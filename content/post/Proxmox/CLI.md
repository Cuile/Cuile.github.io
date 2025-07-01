---
title: "ProxmoxVE 命令行"
date: 2022-12-27T16:51:54+08:00
# draft: true

tags:
- CLI
- ProxmoxVE
---

[遇事不决，多读文档！](https://pve.proxmox.com/pve-docs/index.html)

## 虚拟机

### 创建
使用命令行创建 VM 非常方便，而且还可以使用各发行版的云镜像，快速创建速度又快，占用空间又小，非常方便。
<script src="https://gist.github.com/Cuile/6e42bea498355d5cafaacfa66981daf9.js"></script>

```bash
# 增加硬盘空间
# 建议从模板创建虚拟机后，再增加虚拟机硬盘的空间，这样可以保持模板的大小
qm disk resize <VM_ID> scsi0 +30G

# 关闭
qm stop <vmid>
# 如果关闭失败
qm list
# 找到 vm 对应的 pid
kill <pid>

# 删除
qm destroy <vmid> --destroy-unreferenced-disks 1 --purge 1 --skiplock 1

# 强制删除
rm -f /etc/pve/nodes/*/*/<vm_id>.conf
# [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)
```
---
## LXC容器

```bash
# 关闭
pct stop <vmid>
pct list
```
---
## 存储

```bash
# 查看存储空间使用情况
pvesm status

# 查看存储内的文件
pvesm list <storage>

# 查看存储配置
cat /etc/pve/storage.cfg

# 给local存储添加存储类型
pvesm set local --content snippets,rootdir,import,images,backup,vztmpl,iso
# 注意！！！片段文件只能放在 /var/lib/vz/snippets/ 目录下，不支持子目录

# 将local-lvm(LVM-Thin)合并到local
# 移动虚拟机硬盘到local
qm disk move <vmid> <disk> <storage> --format qcow2 --delete 1
# 移动容器卷到local
pct move-volume <vmid> <volume> <storage> --delete 1
# 删除local-lvm存储
lvremove pve/data
# 空间合并到local
lvextend -l +100%FREE -r pve/root
# 在WebUI的“数据中心”-"存储"里，手动移除local-lvm
```