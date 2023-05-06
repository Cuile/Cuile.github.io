---
title: "Hyper-V 环境下给 CentOS 磁盘扩容"
date: 2022-12-26T21:01:32+08:00
# draft: true

# 标签
tags:
- CentOS
# 专栏
series:
- Hyper-V
# 分类
categories:
- 系统配置
---

使用Hyper-V安装CentOS虚拟机，使用起来非常方便。但遇到磁盘空间不够时，不像Windows虚拟机那样方便给磁盘空间扩容。
总体两分二步：

## 1. vhdx扩容

关闭虚拟机，然后给磁盘扩容，操作方便网上教程多，这里不再赘述。

## 2. CentOS扩容

### 2.1 查看分区表

```bash
$ lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   20G  0 disk 
├─sda1            8:1    0  200M  0 part /boot/efi
├─sda2            8:2    0    1G  0 part /boot
└─sda3            8:3    0  8.8G  0 part 
  ├─centos-root 253:0    0  7.8G  0 lvm  /
  └─centos-swap 253:1    0    1G  0 lvm  [SWAP]
```
以上内容可以看出，sda已经扩容到20G，但sda1+sda2+sda3只有10G说明vhdx扩容成功。

### 2.2 建立新分区

```bash
$ fdisk /dev/sda

The device presents a logical sector size that is smaller than
the physical sector size. Aligning to a physical sector (or optimal
I/O) size boundary is recommended, or performance may be impacted.
欢迎使用 fdisk (util-linux 2.23.2)。

更改将停留在内存中，直到您决定将更改写入磁盘。
使用写入命令前请三思。


命令(输入 m 获取帮助)：n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): 
Using default response p
分区号 (2-4，默认 2)：
起始 扇区 (20971520-41943039，默认为 20971520)：
将使用默认值 20971520
Last 扇区, +扇区 or +size{K,M,G} (20971520-41943039，默认为 41943039)：+10G
值超出范围。
Last 扇区, +扇区 or +size{K,M,G} (20971520-41943039，默认为 41943039)：+9.9G
不支持的后缀：“.9G”。
支持：10^N: KB (千字节), MB (兆字节), GB (吉字节)
            2^N: K  (约千字节), M  (约兆字节), G  (约吉字节)
Last 扇区, +扇区 or +size{K,M,G} (20971520-41943039，默认为 41943039)：+9G 
分区 2 已设置为 Linux 类型，大小设为 9 GiB

命令(输入 m 获取帮助)：w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: 设备或资源忙.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
正在同步磁盘。
```
#### 重读分区表时，发生错误
```bash
$ partprobe
Error: 备份 GPT 表不像应该的那样出现在磁盘的末尾。这可能意味这其它操作系统相信磁盘小一些。通过将备份移动到末尾 (并删除旧备份) 来修正？
Warning: Not all of the space available to /dev/sda appears to be used, you can fix the GPT to use all of the space (an extra 20971520 blocks) or continue with the current setting? 
```
#### 查看分区表时，发现新分区未创建成功
```bash
$ lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   20G  0 disk 
├─sda1            8:1    0  200M  0 part /boot/efi
├─sda2            8:2    0    1G  0 part /boot
└─sda3            8:3    0  8.8G  0 part 
  ├─centos-root 253:0    0  7.8G  0 lvm  /
  └─centos-swap 253:1    0    1G  0 lvm  [SWAP]

```

#### 使用 parted 修复分区表
```bash
$ parted /dev/sda
GNU Parted 3.1
使用 /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p                                                                
错误: 备份 GPT 表不像应该的那样出现在磁盘的末尾。这可能意味这其它操作系统相信磁盘小一些。通过将备份移动到末尾 (并删除旧备份) 来修正？
修正/Fix/忽略/Ignore/放弃/Cancel? fix                                     
警告: Not all of the space available to /dev/sda appears to be used, you can fix the GPT to use all of the space (an extra 20971520 blocks) or continue with the current
setting? 
修正/Fix/忽略/Ignore? fix                                                 
Model: Msft Virtual Disk (scsi)
Disk /dev/sda: 21.5GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name                  标志
 1      1049kB  211MB   210MB   fat16        EFI System Partition  启动
 2      211MB   1285MB  1074MB  xfs
 3      1285MB  10.7GB  9452MB                                     lvm

(parted) p                                                                
Model: Msft Virtual Disk (scsi)
Disk /dev/sda: 21.5GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name                  标志
 1      1049kB  211MB   210MB   fat16        EFI System Partition  启动
 2      211MB   1285MB  1074MB  xfs
 3      1285MB  10.7GB  9452MB                                     lvm

(parted) quit                                                             
```

#### 再次建立新分区
```bash
$ fdisk /dev/sda
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.
欢迎使用 fdisk (util-linux 2.23.2)。

更改将停留在内存中，直到您决定将更改写入磁盘。
使用写入命令前请三思。


命令(输入 m 获取帮助)：n
分区号 (4-128，默认 4)：
第一个扇区 (34-41943006，默认 20969472)：
Last sector, +sectors or +size{K,M,G,T,P} (20969472-41943006，默认 41943006)：+10G
已创建分区 4


命令(输入 m 获取帮助)：w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: 设备或资源忙.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
正在同步磁盘。
```

### 2.3 重读分区表
```bash
$ partprobe
```
重读分区表，正常不会有任何输出

#### 再次查看分区表，可以看到 sda4 分区已经创建好了
```bash
$ lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   20G  0 disk 
├─sda1            8:1    0  200M  0 part /boot/efi
├─sda2            8:2    0    1G  0 part /boot
├─sda3            8:3    0  8.8G  0 part 
│ ├─centos-root 253:0    0  7.8G  0 lvm  /
│ └─centos-swap 253:1    0    1G  0 lvm  [SWAP]
└─sda4            8:4    0   10G  0 part 
```

### 2.4 将 sda4 分区加入 centos-root 分区
```bash
$ lvm
lvm> pvcreate /dev/sda4
  Physical volume "/dev/sda4" successfully created.
lvm> pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               centos
  PV Size               8.80 GiB / not usable 2.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              2253
  Free PE               0
  Allocated PE          2253
  PV UUID               D5K7Ds-a0I8-67Kt-LE1J-HKi7-aaKX-CLaJTg
   
  "/dev/sda4" is a new physical volume of "10.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sda4
  VG Name               
  PV Size               10.00 GiB
  Allocatable           NO
  PE Size               0   
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               digjnH-8XFC-kMQT-nOEL-y9FJ-ImaB-t8FB7d
   
lvm> vgdisplay
  --- Volume group ---
  VG Name               centos
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               8.80 GiB
  PE Size               4.00 MiB
  Total PE              2253
  Alloc PE / Size       2253 / 8.80 GiB
  Free  PE / Size       0 / 0   
  VG UUID               f77tkP-7xzc-qcyf-t0JN-OYOQ-ZfLL-PJPD8w
   
lvm> vgextend centos /dev/sda4
  Volume group "centos" successfully extended
lvm> vgdisplay
  --- Volume group ---
  VG Name               centos
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               <18.80 GiB
  PE Size               4.00 MiB
  Total PE              4812
  Alloc PE / Size       2253 / 8.80 GiB
  Free  PE / Size       2559 / <10.00 GiB
  VG UUID               f77tkP-7xzc-qcyf-t0JN-OYOQ-ZfLL-PJPD8w
   
lvm> lvextend -l +100%FREE /dev/centos/root
  Size of logical volume centos/root changed from 7.80 GiB (1997 extents) to <17.80 GiB (4556 extents).
  Logical volume centos/root successfully resized.
lvm> exit
  Exiting.

$ xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=4, agsize=511232 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=2044928, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 2044928 to 4665344
```

#### 再次查看磁盘容量与分区表，centos-root分区空间已经扩容为17.8G
```bash
$ df -h
文件系统                 容量  已用  可用 已用% 挂载点
devtmpfs                 876M     0  876M    0% /dev
tmpfs                    887M     0  887M    0% /dev/shm
tmpfs                    887M  8.4M  879M    1% /run
tmpfs                    887M     0  887M    0% /sys/fs/cgroup
/dev/mapper/centos-root   18G  7.3G   11G   41% /
/dev/sda2               1014M  215M  800M   22% /boot
/dev/sda1                200M   12M  189M    6% /boot/efi
tmpfs                    178M     0  178M    0% /run/user/0

$ lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   20G  0 disk 
├─sda1            8:1    0  200M  0 part /boot/efi
├─sda2            8:2    0    1G  0 part /boot
├─sda3            8:3    0  8.8G  0 part 
│ ├─centos-root 253:0    0 17.8G  0 lvm  /
│ └─centos-swap 253:1    0    1G  0 lvm  [SWAP]
└─sda4            8:4    0   10G  0 part 
  └─centos-root 253:0    0 17.8G  0 lvm  /
```

## 参考文档
- [Hyper-v下Centos实现扩容硬盘磁盘空间大小](https://www.jianshu.com/p/44c3f86b1d36)