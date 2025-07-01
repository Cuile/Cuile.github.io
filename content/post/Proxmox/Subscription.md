---
title: "ProxmoxVE 关闭订阅提示"
date: 2023-06-06T20:20:04+08:00
# draft: true

tags:
- subscription
- proxmoxve
---

## 修改JS文件
```bash
$ nano /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
```
*6.0+ (380行)*
```javascript
if (data.status !== 'Active') {
```
*替换为*
```javascript
if (false) {
```
*重启服务*
```bash
$ systemctl restart pveproxy.service
```

## 参考文档
- [PVE 去掉登录后无效订阅提示](https://blog.csdn.net/qq_34667723/article/details/108151518)