---
title: "iptables 命令"
date: 2022-02-08T10:09:48+08:00
# draft: true
tags:
- Linux
- CentOS 7
- iptables
- Firewall
series:
- CLI
categories:
- 系统配置
---

**`脚本基于Centos 7`**

**注意：CentOS 7默认的防火墙不是iptables,而是firewalld**

## 停止firewalld服务

```bash
#停止firewalld服务
$ systemctl stop firewalld
#禁用firewalld服务
$ systemctl mask firewalld
```

## 安装 iptables

```bash
#先检查是否安装了iptables
$ service iptables status
#安装iptables
$ yum install -y iptables
#升级iptables
$ yum update iptables 
#安装iptables-services
$ yum install iptables-services
```

## 启动 iptables

```bash
#注册iptables服务，相当于以前的chkconfig iptables on
$ systemctl enable iptables.service
#开启服务
$ systemctl start iptables.service
#查看状态
$ systemctl status iptables.service
```

## 创建规则

```bash
# 允许ping
$ iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# or
$ iptables -A INPUT -p icmp -j ACCEPT

# 允许本地回环接口(即运行本机访问本机)
$ iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

# 如果要添加内网ip信任（接受其所有TCP请求）
$ iptables -A INPUT -p tcp -s 45.96.174.68 -j ACCEPT

# 允许已建立的或相关连的通行
$ iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 允许访问指定端口
$ iptables -A INPUT -p tcp -m tcp --dport 28124 -j ACCEPT
$ iptables -A INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
# 允许访问连续端口
$ iptables -A INPUT -p tcp -m tcp --dport 21:25 -j ACCEPT
# 允许访问不连续端口
$ iptables -A INPUT -p tcp -m multiport --dport 21:25,135:139 -j ACCEPT

# 过滤所有非以上规则的请求
$ iptables -P INPUT DROP
# 封停一个IP
$ iptables -I INPUT -s ***.***.***.*** -j DROP


#允许所有本机向外的访问
$ iptables -P OUTPUT ACCEPT

# 禁止其他未允许的规则访问
$ iptables -P INPUT DROP      // 默认入站规则为拒绝
$ iptables -P FORWARD DROP    // 默认转发规则为拒绝
```

## 删除规则

```bash
$ iptables -D INPUT #rulenum#
# or 使用建立规则时条件，删除指定规则，这个方法比如适合代码使用
$ iptables -D INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
# 解封一个IP
$ iptables -D INPUT -s ***.***.***.*** -j DROP
```

## 重启防火墙

```bash
$ service iptables restart
```

## 保存规则

```bash
$ service iptables save
```

## 查看规则

```bash
$ iptables -L -n --line-numbers
```

## 重置规则

```bash
# 使用这些命令刷新和重置 iptables 到默认状态

# 清除已有iptables规则
$ iptables -F

$ iptables -X

$ iptables -t nat -F

$ iptables -t nat -X

$ iptables -t mangle -F

$ iptables -t mangle -X

$ iptables -t raw -F

$ iptables -t raw -X

$ iptables -t security -F

$ iptables -t security -X

$ iptables -P INPUT ACCEPT

$ iptables -P FORWARD ACCEPT

$ iptables -P OUTPUT ACCEPT
```

