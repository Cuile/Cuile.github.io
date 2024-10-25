---
title: "Hyper-V 网络设置"
date: 2022-12-26T20:49:50+08:00
# draft: true

# 标签
tags:
- network
- Hyper-V
- 系统配置
- windows
# 专栏
series:
# 分类
categories:
---

## 1. 网络设置

- Hyper-V 安装完后，将自动创建一个“默认虚拟交换机”，并同时创建一个同名的虚拟网卡。
    - 如在宿主机同时安装了“Windows沙盒”功能，则沙盒会给每个物理网卡和虚拟网卡，都自动的再创建一个对应的虚拟网卡，容易造成混乱，使用中要注意。
    - 此交换机名及虚拟网卡都无法修改，虚拟机直接填加即可使用网络，但每次启动时IP都会发生变化。
- 将宿主机物理网卡直接共享给“默认虚拟交换机”对应的网卡，是比较省事、且高效的方法，相当于在物理网卡上做了一个NAT转换。
    - 优点：IP地址会自动固定为192.168.137.1，网速较快。
    - 缺点：在多个物理网卡之间切换时非常不方便。
- 貌似问题已解决 
    - ~~Windows 网络共享重启会失效，这个BUG一直没有解决，需要如此解决：~~
        - ~~找到“Internet Connection Sharing”服务~~
            - ~~启动类型：自动~~
        - ~~找到注册表中“HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\SharedAccess”~~
            - ~~新建“DWORD(32位)值(D)”：EnableRebootPersistConnection~~
            - ~~值（十六进制）：1~~
        - ~~重启电脑~~
- 在宿主机使用无线网卡时，由于Hyper-V对无线网卡支持的不好，需要做以下操作：
    - 新建“外部虚拟交换机”：
        - 选择宿主机网卡，勾选“允许管理操作系统共享此网络适配器”，相当于在无线网卡上做了一个NAT转换。
            - 网速较快。
            - 会在宿主机上创建一个网桥，一个虚拟网卡，且宿主机可同时上网。
        - 反之，则只会添加一个网桥，且宿主机无法同时上网。
            - 这是 Hyper-V 对无线网卡支持不够好的表现，而且网速很慢，慢到什么程度呢？慢到微信连文件都发不出去！
    - 新建“内部虚拟交换机”：
        - 会在宿主机上创建一个虚拟网卡。
        - 将所有虚拟机都接入自建的“内部虚拟交换机”，可以解决IP变化的问题。
    - 在宿主机上，将“外部虚拟交换机”创建的虚拟网卡，共享给“内部虚拟交换机”创建的虚拟网卡。
        - “内部虚拟交换机”创建的虚拟网卡IP地址会自动固定为192.168.137.1，所有虚拟机的网段会固定为192.168.137.0。

## 2. 网络拓扑

使用以下拓扑结构来，解决多个物理网卡随时切换的问题：
宿主机直连路由器，宿主机上创建一个虚拟路由器，和一个虚拟机，宿主机与虚拟机都通过虚拟路由器来上网。

|         | TP Route | 宿主机 | OpenWRT | 虚拟机 |
|---------|----------| ----- | ------- | ------ |
| WLAN    | >DHCP<br>IP: 192.168.10.113<br>IP: 192.168.10.114<br>mac: ac-8f | >Bridge<br>IP: -<br>mac: ac-8f             | - | - |
| 外部网络 | -        | >WLAN<br>IP: 192.168.10.113<br>mac: ac-8f                       | >WLAN<br>IP: 192.168.10.114<br>mac: 01-36  | -                                         |
| 内部网络 | -        | >DHCP<br>IP: 192.168.123.100<br>mac: 01-28           | >Static<br>IP: 192.168.123.1<br>mac: 01-29 | >DHCP<br>IP: 192.168.123.102<br>mac: 01-2c |
| 网桥    | -        | >Switch<br>IP: -<br>mac: ac-8f             | -                                         | -                                         | 

可以尝试使用网桥功能，解决多物理网卡切换的问题

## 3. 查看网卡、虚拟网卡、虚拟交换机的命令

使用管理员模式，启动 PowerShell

查看所有网卡
```powershell
get-netadapter 
```
查看虚拟交换机
```powershell
get-vmswitch
```
查看所有虚拟网卡
```powershell
get-vmnetworkadapter -all 
```
查看在主机上的虚拟网卡
```powershell
get-vmnetworkadapter -managementos 
```
查看网卡组
```powershell
get-netlbfoteam
```
删除虚拟网卡
```powershell
remove-vmnetworkadapter -managementos -name "xxx"
```
删除虚拟交换机
```powershell
remove-vmswitch -name "xxx"
```
删除网卡组
```powershell
remove-netlbfoteam -name "xxx"
```
这里要注意删除顺序是，虚拟网卡 >  虚拟交换机 > 网卡组 > 物理网卡。

当然还有一个最简单粗暴的命令，删除所有设置，只保留物理网卡，非常简单好用。
```powershell
netcfg -d
```

## 参考文档

- Hyper-V网络设置
    - [理解Hyper-V外部网络、内部网络、私有网络](https://www.junmajinlong.com/virtual/network/hyperv_net/)
    - [删除Windows中隐藏的物理网卡和网络虚拟化失败后的虚拟网卡](https://www.cnblogs.com/qingspace/p/4268993.html)
    - [Hyper-V 网络配置](https://blog.51cto.com/u_15162069/2761935)
    - [如何从设备管理器中删除Hyper-V虚拟交换机扩展适配器](https://www.it-swarm.cn/zh/hyper-v/%E5%A6%82%E4%BD%95%E4%BB%8E%E8%AE%BE%E5%A4%87%E7%AE%A1%E7%90%86%E5%99%A8%E4%B8%AD%E5%88%A0%E9%99%A4hyperv%E8%99%9A%E6%8B%9F%E4%BA%A4%E6%8D%A2%E6%9C%BA%E6%89%A9%E5%B1%95%E9%80%82%E9%85%8D%E5%99%A8/960270896/)
    - [Win10 Hyper-v下虚拟机使用无线网络](https://www.cnblogs.com/daner1257/p/9824745.html)
    - [hyper-v使用wifi链接网络](https://www.cnblogs.com/guoyabin/p/4443146.html)
- Windows 网络共享
    - [Windows 网络共享重启失效解决方案](https://blog.moeyukina.top/index.php/2019/12/08/windowsics/)
    - [win10 系统在做双网卡共享Internet问题-已解决！！多谢帮助！！](https://social.technet.microsoft.com/Forums/security/zh-CN/efb64b6a-a90c-469c-ba42-53866ddde7ad/win10?forum=win10itprogeneralCN)