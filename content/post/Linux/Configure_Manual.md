---
title: "Linux 系统配置"
date: 2022-01-17T11:07:07+08:00
# draft: true
tags: 
- CLI
- bash
- ssh
- top
- linux
---

可直接下载初始化脚本使用
- [debian bookworm](https://blog.cuile.com/attachments/scripts/init_setup_debian_bookworm.sh)
- [rocky](https://blog.cuile.com/attachments/scripts/init_setup_rocky.sh)

## 1. 系统更新
- [Yum 版本库管理](../repo_manual/#更新)

## 2. 远程公私钥登录
```bash
# 生成公钥、私钥
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
...
Enter a file in which to save the key (/home/you/.ssh/algorithm): <key_name>
Enter passphrase (empty for no passphrase): [输入密码]
Enter same passphrase again: [再次输入密码]
# 设置访问权限
cd ~/.ssh
chmod 600 <key_name>
# 将公钥追加到 authorized_keys 文件，可追加多个公钥
cat <key.pub> >> authorized_keys
# 私钥在 SSH 登录时使用
```

## 3. 配置防火墙
- [iptables 配置](../iptables_manual/)---
- [Ubuntu 22 环境初始化](https://blog.hellowood.dev/posts/ubuntu-22-%E7%8E%AF%E5%A2%83%E5%88%9D%E5%A7%8B%E5%8C%96/#%E4%BF%AE%E6%94%B9-apt-%E6%BA%90)---

## 4. 配置Samba
为使用机器名快速连接

## 其它配置

### 网络端口操作
```bash
# 查看端口占用
# 查看所有端口占用情况
netstat -tlunp
# 查看指定端口占用情况
netstat -tlunp | grep <port>
```

### 查看系统版本
```bash
lsb_release -a
cat /etc/redhat-release
cat /etc/issue
```

### 系统进程操作
```bash
# 定位高CPU占用
ps H -eo user,pid,ppid,tid,time,%cpu,cmd --sort=%cpu
# 可视化显示CPU的使用状况的工具
yum install -y htop
htop
# 查看进程的启动目录
ls -l /proc/<PID>/cwd
```
- [查看CPU和内存使用情况](https://www.cnblogs.com/xd502djj/archive/2011/03/01/1968041.html)
- [查看运行进程的启动目录](https://blog.csdn.net/CHEndorid/article/details/105775330)

### 磁盘操作
```bash
# 修改硬盘挂载目录
# 卸载硬盘
umount -v /mnt/raid1-2disk-500G
# 修改挂载目录
mv /mnt/raid1-2disk-500G /mnt/raid1-250G-2disk
# 修改/etc/fstab文件里的挂载目录
nano /etc/fstab
# 重装挂载
mount -av /dev/md127 /mnt/raid1-250G-2disk
```
- [查询并筛选 磁盘空间 统计 排序](https://blog.csdn.net/u013030100/article/details/79564378)

### 修改密码
```bash
passwd <username>
```

### 查看文件夹大小
```bash
du -h --max-depth=1 <path>
```

### 实时查看文件变化
```bash
apt install inotify-tools
inotifywait -m -r -e modify,create,delete <path>
```

### 启动ssh跳转
```bash
ssh -4CN -p 2222 -L localhost:5432:<proxy service>:8888 -i ~/.ssh/<name>.key <user>@<name>.cuile.com
# 测试代码网络
curl -x http://localhost:5432 ifconfig.me
# 返回代理服务器的IP，即为成功。
```