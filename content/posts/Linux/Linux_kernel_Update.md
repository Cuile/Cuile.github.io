---
title: "Linux系统内核升级"
date: 2022-02-08T10:17:48+08:00
# draft: true
tags:
- kernel
- CLI
series:
- Linux
categories:
- 系统配置
---

**`脚本基于Centos 7`**

## 1、查看系统内核版本
```bash
$ uname -r
3.10.0-514.26.2.el7.x86_64
$ cat /etc/redhat-release 
CentOS Linux release 7.6.1810 (Core)
```

## 2、升级内核
导入elrepo的key，然后安装elrepo的yum源
```bash
$ rpm -import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
$ rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```
查看可用的内核相关包
```bash
$ yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
```
主分支ml(mainline)，稳定版(stable)，长期维护版lt(longterm)
安装内核
```bash
$ yum -y --enablerepo=elrepo-kernel install kernel-ml.x86_64 kernel-ml-devel.x86_64
```

## 3、修改grub
```bash
# 查看系统内核列表
$ awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
CentOS Linux (5.2.11-1.el7.elrepo.x86_64) 7 (Core) # 新内核（5.2.11）在0的位置上
CentOS Linux (3.10.0-957.27.2.el7.x86_64) 7 (Core)
CentOS Linux (3.10.0-514.26.2.el7.x86_64) 7 (Core)
CentOS Linux (3.10.0-514.el7.x86_64) 7 (Core)
CentOS Linux (0-rescue-963c2c41b08343f7b063dddac6b2e486) 7 (Core)

$ vim /etc/default/grub
#将 GRUB_DEFAULT=saved 改为 GRUB_DEFAULT=0

# 重建内核配置
$ grub2-mkconfig -o /boot/grub2/grub.cfg

# or 使用第二种命令行方式，减少操作复杂度，减少出错机率

# 查看系统内核列表
$ cat /boot/grub2/grub.cfg | grep menuentry
if [ x"${feature_menuentry_id}" = xy ]; then
  menuentry_id_option="--id"
  menuentry_id_option=""
export menuentry_id_option
menuentry 'CentOS Linux (6.2.2-1.el7.elrepo.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.81.1.el7.x86_64-advanced-fbc2582d-2e8a-4c41-8ba8-83656d8df89b' {
menuentry 'CentOS Linux (3.10.0-1160.83.1.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.81.1.el7.x86_64-advanced-fbc2582d-2e8a-4c41-8ba8-83656d8df89b' {
menuentry 'CentOS Linux (3.10.0-1160.81.1.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.81.1.el7.x86_64-advanced-fbc2582d-2e8a-4c41-8ba8-83656d8df89b' {
menuentry 'CentOS Linux (3.10.0-1160.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-1160.el7.x86_64-advanced-fbc2582d-2e8a-4c41-8ba8-83656d8df89b' {
menuentry 'CentOS Linux (0-rescue-9745ea2ecc634c89aef55f4dc21ee8fc) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-0-rescue-9745ea2ecc634c89aef55f4dc21ee8fc-advanced-fbc2582d-2e8a-4c41-8ba8-83656d8df89b' {
# 配置默认内核
$ grub2-set-default "CentOS Linux (6.2.2-1.el7.elrepo.x86_64) 7 (Core)"
# 验证修改结果
$ grub2-editenv list
saved_entry=CentOS Linux (6.2.2-1.el7.elrepo.x86_64) 7 (Core)
```

## 4、重启系统
```bash
$ reboot

#查看内核版本
$ uname -r
5.2.11-1.el7.elrepo.x86_64
```