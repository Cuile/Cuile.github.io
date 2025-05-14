---
title: "Ncftp 使用手册"
date: 2024-01-26T11:30:57+08:00
# draft: true

tags:
- ftp
- ncftp
- linux
---

NcFTP 是 Linux 上常用的 FTP客户端工具，非常好用，这里记录它的常见用法。

## ncftp
FTP浏览工具
```bash
$ ncftp
# 一定注意参数顺序
ncftp > open -u <username> -p <password> <remote-host>
# 使用被动模式传输
ncftp > set passive yes
ncftp > put <local-files>
```

## ncftpput
FTP上传命令行工具
```bash
# 一定注意参数顺序
# 使用被动模式传输
$ ncftpput -u <username> -p <password> -F <remote-host> <remote-path> <local-files>
# or
$ ncftpput -f ftp.cfg -F <remote-path> <local-files>
```
```ini
; ftp.cfg
host ftp.server.com
user myusername
pass mypasswd
```

- [NcFTP Client](https://www.ncftp.com/ncftp/)