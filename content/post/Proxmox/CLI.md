---
title: "ProxmoxVE 命令"
date: 2022-12-27T16:51:54+08:00
# draft: true

tags:
- ProxmoxVE
- lxc
- kvm
- pve
---

[遇事不决，多读文档！](https://pve.proxmox.com/pve-docs/index.html)

## QEMU/KVM虚拟机
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
```
- [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)
---
## LXC容器
```bash
# 扩大硬盘
# 将容器的 rootfs 增加到绝对大小
pct resize <lxc_id> rootfs <size>G
# 将容器的 rootfs 增加相对大小
pct resize <lxc_id> rootfs +<size>G

# 缩小硬盘
# 备份lxc
vzdump <lxc_id> --mode stop --compress zstd --storage <storage_name>
# 删除lxc
pct shutdown <lxc_id> 
pct destroy <lxc_id>
# 恢复到指定大小，size默认单位是G
pct restore <lxc_id> /var/lib/vz/dump/<backup_name> --rootfs <storage_name>:<size>

# 关闭
pct list
pct stop <vmid>
```
---
## 存储
```bash
# 查看存储空间使用情况
pvesm status

# 查看存储内的文件
pvesm list <storage_name>

# 查看存储配置
cat /etc/pve/storage.cfg

# 给local存储添加存储类型
pvesm set local --content snippets,rootdir,import,images,backup,vztmpl,iso
# 注意！！！片段文件只能放在 /var/lib/vz/snippets/ 目录下，不支持子目录

# 将local-lvm(LVM-Thin)合并到local
# 移动虚拟机硬盘到local
qm disk move <vm_id> <disk> <storage_name> --format qcow2 --delete 1
# 移动容器卷到local
pct move-volume <vm_id> <volume> <storage_name> --delete 1
# 删除local-lvm存储
lvremove pve/data
# 空间合并到local
lvextend -l +100%FREE -r pve/root
# 在WebUI的“数据中心”-"存储"里，手动移除local-lvm
```

## 宿主机
```bash
# 修改主机名
hostnamectl set-hostname <new_name>
# 编辑/etc/hosts文件
nano /etc/hosts
```
```text
127.0.0.1       localhost.localdomain localhost
192.168.x.xxx   <new_name>.<domain> <new_name>
...
```
```bash
# 重启 PVE 相关服务
# 更新 SSL 证书
systemctl restart pve-cluster \
    && pvecm updatecerts --force \
    && systemctl restart pveproxy pvedaemon

# 修改监控数据目录
systemctl stop rrdcached
mv /var/lib/rrdcached/db/pve2-node/<old_name> /var/lib/rrdcached/db/pve2-node/<new_name>
mv /var/lib/rrdcached/db/pve2-storage/<old_name> /var/lib/rrdcached/db/pve2-storage/<new_name>
systemctl start rrdcached && systemctl restart pvedaemon pvestatd pveproxy
# 迁移 LXC 配置
mv /etc/pve/nodes/<old_name>/lxc/* /etc/pve/nodes/<new_name>/lxc/ 2>/dev/null
# 迁移 QEMU 配置
mv /etc/pve/nodes/<old_name>/qemu-server/* /etc/pve/nodes/<new_name>/qemu-server/ 2>/dev/null
# 删除旧节点目录
rm -rf /etc/pve/nodes/<old_name>

# 重启
reboot
```