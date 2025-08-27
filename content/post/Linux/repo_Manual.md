---
title: "软件库管理"
date: 2022-02-08T10:28:50+08:00
# draft: true
tags:
- CentOS
- debian
- repo
- yum
- apt 
- Linux
---

## APT

[Debian 全球镜像站](https://www.debian.org/mirror/list#per-country)

### 查找延迟最小的镜像
```bash
sudo apt install -y netselect-apt \
    && sudo netselect-apt \
    && sudo apt autoremove -y netselect-apt \
    && rm -f sources.list
```
```bash
The fastest 10 servers seem to be:

        http://mirrors.bfsu.edu.cn/debian/
        http://mirrors.tuna.tsinghua.edu.cn/debian/
        http://mirrors.neusoft.edu.cn/debian/
        http://mirrors.jlu.edu.cn/debian/
        http://ftp.cn.debian.org/debian/
        http://debian.cs.nycu.edu.tw/debian/
        http://mirror.i3d.net/debian/
        http://mirrors.163.com/debian/
        http://mirror.bizflycloud.vn/debian/
        http://ftp.kaist.ac.kr/debian/

Of the hosts tested we choose the fastest valid for http:
        http://mirrors.bfsu.edu.cn/debian/

Writing sources.list.
Done.
```

### 修改仓库
```bash
# PVE QEMU debian-12-generic-amd64.qcow2
# echo 'http://mirrors.bfsu.edu.cn/debian/' | sudo tee /etc/apt/mirrors/debian.list
# echo 'http://mirrors.bfsu.edu.cn/debian-security/' | sudo tee -a /etc/apt/mirrors/debian-security.list
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/mirrors/debian.list
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/mirrors/debian-security.list

# PVE LXC debian-12-standard_12.7-1_amd64.tar.zst
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/sources.list
sed -i -e "s/security.debian.org/mirrors.bfsu.edu.cn\/debian-serurity/" /etc/apt/sources.list

# Docker imaage debian:12
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/sources.list.d/debian.sources

# 启用非自由仓库
sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list

# update    
apt update
```
```bash
# 查询软件包版本信息、优先级和来源
apt policy <package_name>
apt-cache policy <package_name>

# 安装指定版本的包
apt install <package_name>=<version_number>
```

---

## YUM

### 查询仓库
```bash
yum repolist
# 显示所有仓库
yum repolist all
# 显示所有启动的仓库
yum repolist enabled
# 显示所有禁用的仓库
yum repolist disabled
```

### 修改仓库
最常用的修改操作就是启动和停用, 可以使用以下命令实现:
```bash
yum-config-manager --enable repository…
yum-config-manager --disable repository…
```

### 更换阿里云软件安装源
```bash
# 备份原镜像文件，以免出错后可以恢复。
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
&& mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup \
&& mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup

# 下载新的CentOS-Base.repo 到/etc/yum.repos.d/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
&& curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
&& curl -o /etc/yum.repos.d/epel-testing.repo http://mirrors.aliyun.com/repo/epel-testing.repo

# 运行yum makecache生成缓存
yum clean all && yum makecache
```

### 查看已安装软件
```bash
yum list installed
```

### 更新软件
```bash
# 升级所有包同时也升级软件和系统内核
yum -y update

# 只升级所有包，不升级软件和系统内核
yum -y upgrade
```

###  参考文档
- [查RPM](https://crpm.cn/) <sup>找不到包的时候，可以在这上面查查，非常有帮助</sup>
- [阿里巴巴开源镜像站](https://developer.aliyun.com/mirror/)
    - [centos](https://developer.aliyun.com/mirror/centos)
    - [epel](https://developer.aliyun.com/mirror/epel)