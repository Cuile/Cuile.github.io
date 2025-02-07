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
## 强制关闭虚拟机
```bash
$ qm stop <vmid>
$ pct stop <vmid>
# 如果关闭失败
$ qm list
$ pct list
# 找到 vm 对应的 pid
$ kill <pid>
```
- [pve(proxmox ve)强制关闭虚拟机](https://blog.csdn.net/hlz_07/article/details/122305983)

---
## 强制删除虚拟机
```bash
$ rm -f /etc/pve/nodes/*/*/<vm_id>.conf
```
- [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)

---
## 调整硬盘大小
```bash
# 增加硬盘空间
# 建议从模板创建虚拟机后，再增加虚拟机硬盘的空间，保持模板的大小
qm resize <VM_ID> scsi0 +30G
```
*注意不要对有系统的虚拟机硬盘进行操作*
- [ProxmoxVE(PVE) 减小缩减虚拟机硬盘设置的空间大小](https://mayanpeng.cn/archives/158.html#google_vignette)

---
## 创建 cloud-init VM

使用命令行创建 VM 非常方便，而且还可以使用各发行版的云镜像，快速创建速度又快，占用空间又小，非常方便。

```bash
#!/bin/bash

# 虚拟机ID
VM_ID="666"
# 虚拟机名
VM_NAME="test"
# 内存大小
MEM_SIZE="2048"
# 存储空间名
STORAGE_NAME="local-lvm"
# cloud-init 镜像路径
UBUNTU_IMG="/var/lib/vz/template/iso/ubuntu-20.04-minimal-cloudimg-amd64.img"

# 创建虚拟机，系统为linux 2.6~6.x，打开QEMU代理
qm create ${VM_ID} --name ${VM_NAME} --ostype l26 --agent enabled=1
	
# 设置硬件
# CPU 核心数，主板芯片组，内存大小，网口，串口，显示卡
# 一般 cloud-init 镜像，都是将显示转到串口输出，比如ubuntu，不这样配置系统启动不了
qm set ${VM_ID} --cores 2 --machine q35 --memory ${MEM_SIZE} --net0 virtio,bridge=vmbr0 --serial0 socket --vga serial0

# 配置硬盘
# ubuntu 必须使用 virtio-scsi-pci 接口，将 ubuntu cloud-init 镜像直接转换为硬盘，打开 IO thread
qm set ${VM_ID}	--scsihw virtio-scsi-pci --scsi0 file=${STORAGE_NAME}:0,import-from=${UBUNTU_IMG},iothread=1
# pvesm path local-lvm:vm-8000-disk-0

# 配置 BIOS
# 使用 uefi，设置 efi 磁盘
# 注意此命令必须在配置硬盘命令后执行，因为使用 import-from 导入镜像时，必须使用"${STORAGE_NAME}:0"作为虚拟磁盘
qm set ${VM_ID} --bios ovmf --efidisk0 file=${STORAGE_NAME}:1,efitype=4m

# 配置 Cloud-Init
# 指定用户名，密码，ip设置 
qm set ${VM_ID} --ciuser pyspider --cipassword 123456  --ipconfig0 ip=dhcp,ip6=dhcp
# qm set ${VM_ID} --ciuser pyspider --sshkey ~/.ssh/id_rsa.pub --ipconfig0 ip=10.10.10.222/24,gw=10.10.10.1

# 配置 Cloud-Init 磁盘
# 网上都让使用 --ide2 来作为磁盘接口，但实际使用中不能正常启动，只能使用 --scsi1
qm set ${VM_ID} --scsi1 ${STORAGE_NAME}:cloudinit 

# 配置引导顺序
# 从 scsi0 引导启动
qm set ${VM_ID} --boot order=scsi0

# 查看 cloud-init 配置项
qm cloudinit dump ${VM_ID} user

# 将虚拟转为模板，方便以后从模板创建虚拟机
# 创建虚拟机后先进行配置，起码配置完SSHD，再转模板
qm template ${VM_ID}
```
- https://pve.proxmox.com/pve-docs/chapter-qm.html
- https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df
- https://techbythenerd.com/posts/creating-an-ubuntu-cloud-image-in-proxmox/
- https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/
- https://www.cpci.dev/pve-cloud-init-and-cloud-image/
- http://book.321jr.com/books/6974c/page/pve-cloud-init
- http://book.321jr.com/books/6974c/page/pve-cloud-init-centosubuntudebiancloud-images