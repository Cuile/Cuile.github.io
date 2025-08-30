---
title: "iptables 配置"
date: 2022-02-08T10:09:48+08:00
# draft: true
tags:
- iptables
- Firewall
- linux
---

**`基于Centos 7`**

**注意：CentOS 7默认的防火墙不是iptables,而是firewalld**

## 停止firewalld服务

```bash
# 停止firewalld服务
systemctl stop firewalld
# 禁用firewalld服务
# systemctl mask firewalld
# 删除firewalld
yum erase firewalld
```

## 安装 iptables
```bash
# 先检查是否安装了iptables
systemctl status iptables
# 安装iptables
yum install iptables iptables-services -y
```

## 启动 iptables
```bash
# 注册iptables服务，相当于以前的chkconfig iptables on
systemctl enable iptables
# 开启服务
systemctl start iptables
# 查看状态
systemctl status iptables
# 重启防火墙
systemctl restart iptables
# 保存规则
service iptables save
# 如果报“-bash: service: command not found”，则需要安装initscripts
yum install initscripts -y
```

## 关键规则
注意添加规则的先后顺序
```bash
# 允许已建立的或相关连的通行
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# 添加SSH访问端口
iptables -A INPUT -p tcp -m tcp --dport 28124 -j ACCEPT
# 允许本地回环接口(即运行本机访问本机)
iptables -A INPUT -i lo -j ACCEPT
# 允许ping
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# 禁止所有本机入站访问
iptables -P INPUT DROP      // 默认入站规则为拒绝
# 允许所有本机出站访问
iptables -P OUTPUT ACCEPT
# 允许所有本机转发访问
iptables -P FORWARD ACCEPT  # 禁止的话podman桥接网络不无正常工作，或者要配置相应的podman规则
```

## 其它规则
```bash
# 允许访问指定端口
iptables -A INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
# 允许访问连续端口
iptables -A INPUT -p tcp -m tcp --dport 21:25 -j ACCEPT
# 允许访问不连续端口
iptables -A INPUT -p tcp -m multiport --dport 21:25,135:139 -j ACCEPT

# 转发数据包
# 将<本地端口>接收到的TCP数据包，直接转发到<目标IP>的<目标端口>
iptables -t nat -A PREROUTING -p tcp --dport <本地端口> -j DNAT --to-destination <目标IP>:<目标端口>
# 将<目标IP>的<目标端口>发来的TCP数据包，IP地址修改为<本地IP>后，原路转发回去
iptables -t nat -A POSTROUTING -p tcp -d <目标IP> --dport <目标端口> -j SNAT --to <本地IP>
# 如果要添加内网ip信任（接受其所有TCP请求）
iptables -A INPUT -p tcp -s 45.96.174.68 -j ACCEPT
# 封停一个IP
iptables -I INPUT -s ***.***.***.*** -j DROP
# 删除规则
iptables -D INPUT #rulenum#
# or 使用建立规则时条件，删除指定规则，这个方法比如适合代码使用
iptables -D INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
# 解封一个IP
iptables -D INPUT -s ***.***.***.*** -j DROP
```

## 查看规则
```bash
iptables -L -n --line-numbers
```

## 重置规则
```bash
# 使用这些命令刷新和重置 iptables 到默认状态

# 清除已有iptables规则
iptables -F

iptables -X

iptables -t nat -F

iptables -t nat -X

iptables -t mangle -F

iptables -t mangle -X

iptables -t raw -F

iptables -t raw -X

iptables -t security -F

iptables -t security -X

iptables -P INPUT ACCEPT

iptables -P FORWARD ACCEPT

iptables -P OUTPUT ACCEPT
```

