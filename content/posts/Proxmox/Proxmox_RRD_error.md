---
title: "修复 Proxmox RRD 错误"
date: 2022-02-08T10:42:35+08:00
# draft: true
tags:
series:
- Proxmox
categories:
- 系统配置
---

Proxmox系统安装后，日志报错
```log
rrdcached[4513]: handle_request_update: Could not read RRD file.
pmxcfs[4527]: [status] notice: RRDC update error /var/lib/rrdcached/db/pve2-vm/85235: -1
pmxcfs[4527]: [status] notice: RRD update error /var/lib/rrdcached/db/pve2-vm/85235: mmaping file '/var/lib/rrdcached/db/pve2-vm/85235': Invalid argument
```

修复命令
```bash
$ rm -r /var/lib/rrdcached/db
$ systemctl restart rrdcached.service
```

## 参考文档
- [Strange RRD error](https://forum.proxmox.com/threads/strange-rrd-error.102139/post-441801)