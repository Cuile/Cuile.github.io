---
title: "Windows X-Lite 版本说明"
date: 2026-04-24T16:23:32+08:00
# draft: true

tags:
- Windows
- x-lite
---

Windows X-Lite 优化的 Windows 版本旨在提升性能、隐私性、稳定性和可控制性，同时降低资源占用、提高响应速度，并且几乎能在任何 PC 上运行——无论新旧强弱。

但网站上各版本与镜像的展示逻辑是交叉且毫无条理的，容易给人看懵，特在些说明如下：

## 可下载的内容分11个部分
1. [Windows 10 Builds](https://windowsxlite.com/win10)
1. [Windows 11 Builds](https://windowsxlite.com/win11)
1. [Special Edition Builds](https://windowsxlite.com/SE)
1. [Ultralight](https://windowsxlite.com/ultralight)
1. [Barebone Builds](https://windowsxlite.com/Atomic)
1. [x86 Builds](https://windowsxlite.com/Micro10-22H2)
1. [Windows Update Packs](https://windowsxlite.com/updatepacks)
1. [Software](https://windowsxlite.com/software)
1. [Registry Tweaks](https://windowsxlite.com/tweaks)
1. [Windows Subsystem For Android](https://windowsxlite.com/WSA)
1. [Wallpaper](https://windowsxlite.com/wallpaper)

## 各版本之间的差异
| 版本   | <center>Ultralight 超精简版</center>                                                                                                                                                |
| :---:  | :---                                                                                                                                                                                |
|概述    |超精简版保留了运行大多数第三方应用和游戏所需的核心组件                                                                                                                               |
|不支持  |<ul><li>Windows Mail、Windows Calendar（邮件/日历）</li><li>BitLocker、Smart Card（加密/智能卡）</li><li>OneDrive、Defender（云存储/杀毒）</li><li>备份与还原、语音、诊断、疑难解答</li><li>Windows 更新、可选功能（如 Hyper‑V、WSA、WSL2）</li><li>此外，安装额外语言时可能遇到问题。</li></ul>                                                                                                                                                                                     |
|支持    |<ul><li>台式机、笔记本、平板电脑</li><li>WLAN、蓝牙</li><li>微软商店、UWP 应用</li><li>Xbox Game Pass、Xbox 手柄</li><li>打印功能</li><li>以及绝大多数第三方应用和游戏。</li></ul>   |
|包含镜像|<ul><li>['Micro 10'](#micro-10)</li><li>'Neon Gamer'</li><li>'Micro 11 24H2'</li><li>'Micro 11 23H2'</li><li>'Micro 11 22H2' SE</li><li>'Micro 11 22H2'</li><li>'Atomic 11'</li></ul>|

## 版本内部镜像差异
### Micro 10 {#micro-10}
| 镜像   |<center>['Micro 10'](https://windowsxlite.com/Micro10)</center>|<center>['Micro 10' SE [x86]](https://windowsxlite.com/Micro10_x86_SE)</center>|<center>['Micro 10' SE [x64]](https://windowsxlite.com/Micro10_x64_SE)</center>|
| :---:  |:---                                                           |:---                                                                           |:---                                                                           |
|基础版本|<center>Windows 10 22H2 Pro (Build 19045.3324) AMD64</center>  |<center>Windows 10 22H2 Pro (Build 19045.3757) x86</center>                    |<center>Windows 10 22H2 Pro (Build 19045.3757) x64</center>                    |
|版本说明|<ul><li>这是我们首个基于 Windows 10 22H2 的超精简版！</li><li>极致性能之选！ 此版本基于 Windows 10 22H2，精简至核心，但仍保留了大多数用户需要的功能。它在隐私、性能、操控性、稳定性和外观风格方面为 Windows 带来了革新。</li><li>默认启用按流量计费的连接。 我们强烈建议保持此设置开启。这意味着 Windows 不会自动为你的电脑下载驱动程序，因此，我们建议你直接从电脑制造商的官网下载驱动程序。</li><li>Windows 更新服务和 Windows 防火墙默认均为禁用状态，但你可以在“开始菜单” - “X-Lite 工具”文件夹中轻松启用它们。你需要启用 Windows 更新服务才能使用 Microsoft Store 和安装额外的语言包。</li></ul>|<ul><li>我们的首个 Windows 10 22H2 x86 版本！</li><li>极致性能之选！基于 Windows 10 22H2，此版本精简至核心，但仍保留了大多数用户需要的功能！并在隐私、性能、操控性、稳定性和风格方面为 Windows 带来革新。</li><li>此版本基于原始的 Micro 10 版本，因此我们依赖 Micro 10 的原始演示视频来让你了解此版本的能力和所提供的体验。它之所以是一个特别版，是因为在主题、鼠标指针和壁纸方面进行了令人兴奋的全新改动，呈现出焕然一新的外观，如本页底部的截图所示。</li><li>Windows 更新服务和 Windows 防火墙默认禁用，但可以通过开始菜单 - X-Lite 工具文件夹轻松启用。你需要启用 Windows 更新服务才能使用 Microsoft Store 和安装额外的语言包。</li><li>要在添加额外语言时获得完整的 Windows 设置翻译支持，请先开启 Windows 更新服务，确保按流量计费的连接已关闭，然后安装你需要的语言包，最后重启电脑以完成更改！</li><li>此版本未预装 .NET Framework 3.5，且无法添加。它完全支持 .NET 4.8，并完全支持安装 .NET 桌面运行时 5、6、7、8 等。</li></ul>|<ul><li>极致性能之选！基于 Windows 10 22H2，此版本精简至核心，但仍保留了大多数用户需要的功能！并在隐私、性能、操控性、稳定性和风格方面为 Windows 带来革新。</li><li>此版本基于原始的 Micro 10 版本，因此我们依赖 Micro 10 的原始演示视频来让你了解此版本的能力和所提供的体验。它之所以是一个特别版，是因为在主题、鼠标指针和壁纸方面进行了令人兴奋的全新改动，呈现出焕然一新的外观，如本页底部的截图所示。</li><li>Windows 更新服务和 Windows 防火墙默认禁用，但可以通过开始菜单 - X-Lite 工具文件夹轻松启用。你需要启用 Windows 更新服务才能使用 Microsoft Store 和安装额外的语言包。</li><li>要在添加额外语言时获得完整的 Windows 设置翻译支持，请先开启 Windows 更新服务，确保按流量计费的连接已关闭，然后安装你需要的语言包，最后重启电脑以完成更改！</li><li>此版本未预装 .NET Framework 3.5，且无法添加。它完全支持 .NET 4.8，并完全支持安装 .NET 桌面运行时 5、6、7、8 等。</li></ul>|
|亮点速览|<ul><li>1.3GB ISO！</li><li>2.5GB 安装后大小！</li><li>虚拟内存默认启用！</li><li>稳定性和性能提升！</li><li>包含可选系统透明效果！</li><li>为您的应用和游戏带来极致性能！</li><li>已将 Intel RST 和 Serial IO 驱动集成到 Windows 安装程序中！</li><li>完全支持 UWP 应用、Xbox、Microsoft Store 等！</li><li>更新了框架、运行时库和桌面应用安装器！</li><li>包含自定义主题、图标、壁纸等！</li><li>包含 HEVC 解码器！（非 Windows 10 原生）</li><li>额外的改进和优化！</li><li>无预装 UWP 应用！</li><li>包含 Microsoft Store 安装器！</li><li>完全支持旧式 PC</li><li>完全支持台式机、笔记本电脑和平板电脑</li><li>完全支持额外语言包</li><li>旨在为您的电脑注入新活力</li></ul>💥 旨在适用于所有电脑，无论新旧强弱，台式机还是笔记本电脑。|<ul><li>869 MB ISO！</li><li>1.5 GB 安装后大小！</li><li>虚拟内存默认启用！</li><li>稳定性和性能提升！</li><li>包含可选系统透明效果！</li><li>为您的应用和游戏带来极致性能！</li><li>完全支持 UWP 应用、Microsoft Store 等！</li><li>包含自定义主题、图标、壁纸、鼠标指针等！</li><li>额外的改进和优化！</li><li>包含 Microsoft Store 和截图工具！</li><li>完全支持台式机、笔记本电脑和平板电脑</li><li>完全支持额外语言包</li><li>旨在为您的电脑注入新活力</li></ul>💥 旨在适用于所有电脑，无论新旧强弱，台式机还是笔记本电脑。|<ul><li>1.2 GB ISO！</li><li>2 GB 安装后大小！</li><li>虚拟内存默认启用！</li><li>稳定性和性能提升！</li><li>包含可选系统透明效果！</li><li>为您的应用和游戏带来极致性能！</li><li>完全支持 UWP 应用、Microsoft Store 等！</li><li>包含自定义主题、图标、壁纸、鼠标指针等！</li><li>额外的改进和优化！</li><li>包含 Microsoft Store 和截图工具！</li><li>完全支持台式机、笔记本电脑和平板电脑</li><li>完全支持额外语言包</li><li>旨在为您的电脑注入新活力</li></ul>💥 旨在适用于所有电脑，无论新旧强弱，台式机还是笔记本电脑。|
|已移除  |Cortana（小娜）、Smart Screen（智能屏幕筛选）、Edge 浏览器、UWP 应用、BitLocker（磁盘加密）、Hyper‑V、WSL2（Linux 子系统）、OneDrive、智能卡、Windows Defender、Windows 邮件、备份与还原、遥测、诊断、疑难解答、地图、可选功能支持（WSL2、Hyper‑V、沙盒等）、更新支持、组件存储、语音功能、语音唤醒、部分字体。|Cortana、Smart Screen、Edge、UWP 应用、BitLocker、Hyper-V、WSL2、One Drive、智能卡、Windows Defender、Windows 邮件、备份和还原、遥测、诊断、疑难解答、地图、可选功能支持（WSL2、Hyper-V、沙盒等）、更新支持、组件存储、语音、语音唤醒、部分字体。|Cortana、Smart Screen、Edge、UWP 应用、BitLocker、Hyper-V、WSL2、One Drive、智能卡、Windows Defender、Windows 邮件、备份和还原、遥测、诊断、疑难解答、地图、可选功能支持（WSL2、Hyper-V、沙盒等）、更新支持、组件存储、语音、语音唤醒、部分字体。      |
|已禁用  |错误报告、索引、UAC、广告、休眠、电源节流。|错误报告、索引、UAC、广告、休眠、电源节流。                                |错误报告、索引、UAC、广告、休眠、电源节流。                                   |
|已启用  |DirectPlay、.NET Framework 3.5、SMB1。                        |DirectPlay、SMB1。                                                         |DirectPlay、SMB1。                                                            |
|性能优先|——此版本旨在最大化性能、响应速度和资源节省。                           |此版本旨在最大化性能、响应速度和资源节省。                                 |此版本旨在最大化性能、响应速度和资源节省。                                    |


