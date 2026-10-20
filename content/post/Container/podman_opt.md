---
title: "Podman操作"
date: 2026-10-20T21:11:19+08:00
# draft: true

tags:
- podman
- container
# series:
# categories:
---
## Volume迁移
```bash
# 导出数据
podman volume export <volume_name> | gzip > /tmp/<volume_name>_backup.tar.gz

scp /tmp/<volume_name>_backup.tar user@hostname:/tmp/
# 或使用 rsync
rsync -avz /tmp/<volume_name>_backup.tar user@hostname:/tmp/

# 创建目标卷
podman volume create <volume_name>
# 导入数据
gunzip -c /tmp/<volume_name>_backup.tar.gz | podman volume import <volume_name> -
```
