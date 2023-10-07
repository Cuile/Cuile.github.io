---
title: "OpenWRT 配置 IPv6"
date: 2023-10-04T19:48:18+08:00
# draft: true

# 标签
tags:
- firewall
- network
- ipv6
# 专栏
series:
- openwrt
# 分类
categories:
- 系统配置
---

OpenWRT 配置 IPv6，在网上有许多教程，但大部分都说的不清不楚。
所以我从 OpenWRT 配置文件的角度，给出一个肯定能用的配置。
相关配置原理不详述，可自行上网查找。

## 系统环境
- 北京联通 300M 家宽 （客服说100元/月，可提供公网IPv4/IPv6地址，其实IPv6是免费给的）
- OpenWRT（PVE虚机，非直通网卡）
    - 目标平台：x86/64
    - 固件版本：OpenWrt 21.02.0 r16279-5cc0535800 / LuCI openwrt-21.02 branch git-23.093.57360-e98243e
    - 内核版本：5.4.143
    - DHCPv6 客户端 (odhcp6c)
    - RA & DHCPv6 服务器 (odhcpd)
    - IPv6 防火墙 (ip6tables) 
    - Luci网页配置 (luci-proto-ipv6)

## 配置流程
1. 光猫桥接（电话联通，远程搞定）
2. OpenWRT WAN IPv6 配置
> ```yaml
> # /etc/config/network
> ...
> config interface 'lan'
>         option proto 'static'
>         option ipaddr '192.168.10.10'
>         option netmask '255.255.255.0'
>         option device 'eth0'
>         option ip6assign '64' # IPv6分配长度。要与 wan 口一致。
> 
> config interface 'wan'
>         option proto 'pppoe'
>         option username '***********'
>         option password '***********'
>         option device 'eth1'
>         option ipv6 'auto' # 自动获取IPv6地址，使用这个选项后，会自动创建一个虚拟动态接口(WAN_6)，不用配置。
>         option ip6assign '64' # IPv6分配长度。参考 WAN_6 接口 IPv6-PD 的掩码长度，一般为“60”，比它大即可，系统默认为64。
> ...
> ```
3. OpenWRT 防火墙配置
> ```yaml
> # /etc/config/firewall
> ...
> config zone
>         option name 'lan'
>         list network 'lan'
>         option input 'ACCEPT'
>         option output 'ACCEPT'
>         option forward 'ACCEPT'
> 
> config zone
>         option name 'wan'
>         list network 'wan'
>         option input 'DROP' # 关闭 wan 口输入流量
>         option output 'ACCEPT' # 只出不进
>         option forward 'REJECT'
>         option masq '1' # 打开 NAT 功能
>         option mtu_fix '1' # 路由器直接拨号时使用
> ...
> # 转发规划很重要
> config forwarding
>         option src 'lan'
>         option dest 'wan'
> ...
> # 允许外网IPv6协议下，任意地址的547端口的UDP包通过wan口，访问本机546端口
> config rule
>         option name 'Allow-DHCPv6'
>         option proto 'udp'
>         option src 'wan'
>         option src_port '547'
>         option dest_port '546'
>         option target 'ACCEPT'
>         option family 'ipv6'
> ```
4. OpenWRT DHCP 配置
```yaml
# /etc/config/dhcp
...
config dhcp 'lan'
        option interface 'lan'
        option start '100'
        option dhcpv4 'server'
        option limit '200'
        option force '1'
        option leasetime '2h'
        option ra 'server' # RA服务 服务器模式
        option dhcpv6 'server' # DHCPv6服务 服务器模式
        list ra_flags 'none' # RA标记 无

config dhcp 'wan'
        option interface 'wan'
        option ignore '1'
        list ra_flags 'none'

config odhcpd 'odhcpd'
        option maindhcp '0'
        option leasefile '/tmp/hosts/odhcpd'
        option leasetrigger '/usr/sbin/odhcpd-update'
        option loglevel '4'

```
5. 重启OpenWRT
6. 查看 Luci -> 网络 -> 接口 -> LAN，已拿到的IPv6地址
7. 测试本机外网IPv6地址，与 LAN 的 IPv6地址一致即可
> ```bash
> $ curl 6.ipw.cn
> ```


## 参考文档
- [IPv6 configuration](https://openwrt.org/docs/guide-user/network/ipv6/configuration)
- [IPv6 原理及如何设置 OpenWrt](https://vicfree.com/2023/02/ipv6-explained-and-setup-in-openwrt/)
- [如何配置防火墙](https://openwrt.org/zh-cn/doc/uci/firewall)
- [IPv6](https://openwrt.org/docs/guide-user/network/ipv6/start)