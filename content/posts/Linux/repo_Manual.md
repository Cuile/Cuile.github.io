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
series:
categories:
---

## APT

[Debian 全球镜像站](https://www.debian.org/mirror/list#per-country)

### 修改仓库
```bash
# 查找延迟最小的镜像
sudo apt install -y netselect-apt && sudo netselect-apt
...
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

echo 'http://mirrors.bfsu.edu.cn/debian/' | sudo tee /etc/apt/mirrors/debian.list
echo 'http://mirrors.bfsu.edu.cn/debian-security/' | sudo tee /etc/apt/mirrors/debian-security.list
sudo apt autoremove -y netselect-apt
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