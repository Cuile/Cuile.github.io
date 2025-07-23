#!/bin/bash

# https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/
# https://gist.github.com/chriswayg/b6421dcc69cb3b7e41f2998f1150e1df
# https://tech.he-sb.top/posts/creating-vm-template-for-pve-based-on-cloud-init/
# https://foxi.buduanwang.vip/virtualization/pve/388.html/

# 另一种快速创建与配置虚拟机的思路，回头研究一下
# https://vqiu.cn/proxmox-quick-create-vms/

# Use:
# sh create_VM.sh <vm_id> <host_name> <user_name> <img_path>

set -e

stdout() {
    echo "\n$(basename $0): $*"
}

# 虚拟机ID
VM_ID=$1
# 虚拟机名
VM_NAME=$2
# 内存大小
MEM_SIZE=2048
# 存储空间名
STORAGE_NAME="local"
# 用户信息
# 如何不设置用户，则使用系统默认用户
# debian默认用户是 debian
USER=$3
PASSWORD=123456
# cloud-init 镜像路径
if [ -z "${CLOUD_INIT_IMG+x}" ]; then
    CLOUD_INIT_IMG=$4
fi


# 创建虚拟机
stdout "create VM"
# 系统为linux 2.6~6.x，打开QEMU代理
qm create ${VM_ID} --name ${VM_NAME} --ostype l26 \
                --agent enabled=1,freeze-fs-on-backup=1,fstrim_cloned_disks=1,type=virtio

# 设置硬件
stdout "set Hardware"
# CPU 核心数，主板芯片组，内存大小，网口，串口，显示卡
# 一般 cloud-init 镜像，都是将显示转到串口输出，比如ubuntu，不这样配置系统启动不了
# ubuntu 必须使用 virtio-scsi-pci 接口
qm set ${VM_ID} --cores 2 --cpu cputype=host \
                --machine type=q35 \
                --tablet 0 \
                --memory ${MEM_SIZE} \
                --scsihw virtio-scsi-pci \
                --serial0 socket \
                --net0 model=virtio,bridge=vmbr0,firewall=0 \
                --vga type=serial0

# # 配置 BIOS
# stdout "set BIOS"
# # 使用 uefi，设置 efi 磁盘
# qm set ${VM_ID} --bios ovmf --efidisk0 file=${STORAGE_NAME}:0,efitype=4m

# 配置硬盘
stdout "set Disk"
# local-lvm不支持debian12的qcow2格式，需要预先导入
DISK=$(qm disk import ${VM_ID} ${CLOUD_INIT_IMG} ${STORAGE_NAME} --format qcow2 \
        | awk '/successfully imported disk/{print $5}' \
        | tr -d "'")
# 将镜像直接转换为硬盘，打开 IO thread
qm set ${VM_ID} --scsi0 file=${DISK}
# 硬盘扩容
qm disk resize ${VM_ID} scsi0 +5G

# 配置引导顺序
stdout "set Boot"
# 从 scsi0 引导启动
qm set ${VM_ID} --boot order=scsi0

# 配置 Cloud-init
stdout "set Cloud-init Configure"
# 使用 Cloud-init 配置文件统一管理
# 官方文档：https://cloudinit.readthedocs.io/en/latest/reference/modules.html


# 配置用户名，密码
stdout "set User and Password"
if [ -n "${USER}" ]; then
    qm set ${VM_ID} --ciuser ${USER} 
else
    USER=debian
fi
qm set ${VM_ID} --cipassword ${PASSWORD}
# qm set ${VM_ID} --sshkeys ./public.key

# 配置网络
stdout "set Network"
qm set ${VM_ID} --ipconfig0 ip=dhcp,ip6=dhcp
# qm set ${VM_ID} --ipconfig0 ip=192.168.1.252/24,gw=192.168.1.1
# 配置searchdomain，否则Cloudinit.pm脚本会报错，应该是pve的一个BUG，但不影响使用
qm set ${VM_ID} --searchdomain lan

# 使用配置文件
stdout "use Cloud-init Configure file"
# 配置文件放在“片段”卷上，但一般PVE不会自动创建“片段”卷，需要手动添加
# 查看当前local存储的配置
# cat /etc/pve/storage.cfg

# 给local存储添加snippets属性
# pvesm set local --content vztmpl,iso,backup,snippets
# 查看WebUI，local存储界面左侧栏会出现一个“片段”选项

# 注意！！！片段文件只能放在这个目录下，不支持子目录
cp cloud-config.yaml /var/lib/vz/snippets/
qm set ${VM_ID} --cicustom "user=local:snippets/cloud-config.yaml"

# 配置Cloud-init硬盘格式，系统自动升级
qm set ${VM_ID} --citype nocloud --ciupgrade 0

# 查看生成 cloud-init 配置项
stdout "View Cloud-init Configure: User"
qm cloudinit dump ${VM_ID} user
stdout "View Cloud-init Configure: Network"
qm cloudinit dump ${VM_ID} network
# 更新 cloud-init 配置
stdout "Update Cloud-init Configure"
qm cloudinit update ${VM_ID}
# 生成 Cloud-Init 磁盘
stdout "set Cloud-init Disk"
qm set ${VM_ID} --ide2 file=${STORAGE_NAME}:cloudinit,media=cdrom 
stdout "VM Creation Successful."

# stdout "Use command: 'qm template ${VM_ID}' create Template"
# 将虚拟转为模板，方便以后从模板创建虚拟机
# 创建虚拟机后先进行配置，起码配置完SSHD，再转模板
# qm template ${VM_ID}