---
title: "Proxmox 命令行"
date: 2022-12-27T16:51:54+08:00
# draft: true

# 标签
tags:
- CLI
# 专栏
series:
- Proxmox
# 分类
categories:
- 系统配置
---

## 强制删除虚拟机
```bash
$ rm -f /etc/pve/nodes/*/*/<vm_id>.conf
```
参考文档
- [修復Proxmox VE：無法刪除虛擬機器](https://blog.pulipuli.info/2014/08/proxmox-ve-fix-proxmox-ve-destroy.html#postcataproxmox-ve-fix-proxmox-ve-destroy.html0_anchor2)