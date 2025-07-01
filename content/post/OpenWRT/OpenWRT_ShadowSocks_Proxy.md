---
title: "OpenWRT 配置透明代理"
date: 2022-02-07T13:37:19+08:00
# draft: true
tags: 
- v2ray
- proxy
- ShadowSocks
- OpenWRT
---

本文记录OpenWrt设置透明代理的步骤及原理。

## 1. 系统环境

- 硬件环境：Windows 10 Hyper-V虚拟机，单核处理器，256M内存
- 固件版本：OpenWrt 19.07.6 r11278-8055e38794 / LuCI openwrt-19.07 branch git-21.101.59933-c56d9f2
- [shadowsocks-libev：3.3.5](https://github.com/shadowsocks/openwrt-shadowsocks/releases)
- luci-app-shadowsocks：2.0.2
- [v2ray-plugin：4.37.3-20210413](https://github.com/honwen/openwrt-v2ray-plugin/releases)
- ChinaDNS：1.3.3
- luci-app-chinadns：1.6.2
- https-dns-proxy：2021-01-17-5
- luci-app-https-dns-proxy：git-21.062.76689-a607f9c-1
- luci-i18n-https-dns-proxy-zh-cn：git-21.062.76689-a607f9c-1

## 2. 运行流程

透明代理的运行原理主要由`DNS访问流程`、`IP访问流程`两部分组成组成

### 2.1 DNS访问流程

```mermaid
flowchart LR
    lh((localhost));
    dm(Dnsmasq);
    cd(ChinaDNS);
    hdp(https-dns-proxy);
    ss(Shadowsocks);
    fd(国外DNS);
    dd(国内DNS);

    lh -- 1 udp:53 --> dm;
    dm -- 2 udp:5555 --> cd;
    cd -- 3.1 udp:5353--> hdp;
    cd -- 3.2 udp --> dd;
    hdp -- 4 tcp --> ss;
    ss -- 5 tcp --> fd;

    fd -. 6 .-> ss;
    ss -. 7 .-> hdp;
    hdp -. 8.1 .-> cd;
    dd -. 8.2 .-> cd;
    cd -. 9 缓存 .-> dm;
    dm -. 10 IP地址 .-> lh;
```

### 2.2 IP访问流程

```mermaid
flowchart LR
    fs(国外服务器);
    ds(国内服务器);
    lh((localhost));
    route{chinadns_chnroute.txt};
    ss(Shadowsocks);

    lh -- 1 --> route;
    route -- 2.1 国内IP --> ds;
    route -- 2.2 国外IP --> ss;
    ss -- 3 加密访问 --> fs;

    fs -. 4 返回加密数据 .-> ss;
    ds -. 5.1 返回数据 .-> lh;
    ss -. 5.2 返回解密数据 .-> lh;
```

## 3. 配置

### 3.1 Shadowsocks-libev + v2ray-plugin

- `服务器管理`-`编辑服务器`-`插件参数`：一定要加上"loglevel=none"，如果不加v2ray-plugin插件几分钟就会被系统杀死
- `访问控制`-`被忽略IP列表`：/etc/chinadns_chnroute.txt

### 3.2 https-dns-proxy

由于使用了v2ray-plugin 插件，导致Shadowsocks不再支持UDP包，所以使用TCP的方式查询DNS
- `在开始/停止时更新DNSMASQ配置`：不更新配置 *如果自动更新配置，会影响到ChinaDNS的配置*
- `Force Router DNS`：Let local devices use their own DNS servers if set
- `实例`
    - 谷歌, 127.0.0.1, 5353
    - Cloudflare(安全防护), 127.0.0.1, 5454

### 3.3 ChinaDNS

- `启用双向过滤`：勾选
- `监听端口`：5555
- `上游服务器`：114.114.114.114,127.0.0.1:5353,127.0.0.1:5454

### 3.4 DHCP/DNS

将OpenWrt的上游DNS指向ChinaDNS
- `常规设置`-`DNS转发`：127.0.0.1#5555

关闭使用解析文件，指定上游DNS
- `HOSTS和解析文件`-`忽略解析文件`：勾选

### 3.5 计划任务

```bash
## For ipip.net
## 每周一12:30执行
30 12 * * 1    wget https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt -O /tmp/china_ip_list.txt && mv /tmp/china_ip_list.txt /etc/chinadns_chnroute.txt
5  *  *  *  *  /usr/bin/ss-subscribe auto >/dev/null 2>&1
```

### 3.6 防火墙

- `常规设置`-`区域`-`wan`-`IP动态伪装`：一定要勾选！！！

## 参考文档

- [OpenWRT下安装和配置shadowsocks](http://douxinchun.github.io/blog/20210302/install-shadowsocks-on-openwrt.html)
- [Shadowsocks + ChnRoute 实现 OpenWRT / LEDE 路由器自动科学上网](https://cokebar.info/archives/664)
- [Shadowsocks for OpenWRT / LEDE 拾遗](https://cokebar.info/archives/850)
- [ChinaDNS原理与源码分析](https://cyberloginit.com/2019/04/08/chinadns-code-analysis.html)