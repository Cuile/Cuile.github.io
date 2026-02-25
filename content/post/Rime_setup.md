---
title: "Rime/中州韵 输入法安装设置"
date: 2024-01-19T13:11:15+08:00
tags:
- Rime
---
Rime/中州韵 输入法是一个跨平台的输入引擎，非常强大优秀。
它在不同的平台有不同的名字：
- Windows: 小狼毫 Weasel
- MacOS: 鼠鬚管 Squirrel, 小企鹅 fcitx5-macos
- Linux: ibus-rime, fcitx5-rime

## Windows
### 配置输入法

- `输入法设定`>`获取更多输入方案`>`在打开的命令行窗口`
- 输入 "wubi_pinyin" 回车

### 配置P站风格配色主题
```yaml
# weasel.custom.yaml
patch:
  # P站风格配色主题
  "style/color_scheme": "Pornhub"  
  "preset_color_schemes/Pornhub":
    author: "周庸生"
    back_color: 0x000000
    border_color: 0x000000
    candidate_text_color: 0xffffff
    comment_text_color: 0xffffff
    hilited_back_color: 0x009bff
    hilited_candidate_back_color: 0x009bff
    hilited_candidate_text_color: 0x000000
    hilited_comment_text_color: 0x000000
    hilited_lable_color: 0x000000
    hilited_text_color: 0x000000
    label_color: 0xffffff
    name: Pornhub
    text_color: 0xffffff
```

## Debian
### 安装 fcitx5
```bash
killall ibus-daemon \
&& apt remove ibus \
&& apt update \
&& apt install -y fcitx5 fcitx5-config-qt fcitx5-chinese-addons fcitx5-rime fcitx5-material-color
```
### 安装 东风破/plum/ 配置工具
```bash
# 因为fcitx5-rime是fcitx5团队带为开发的，所以要指定第三方Rime发行版本
# 注意：此命令会默认配置所有预设置项
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | rime_frontend=fcitx5-rime bash
# 后续使用
cd ~/plum/
rime_frontend=fcitx5-rime bash rime-install
# 更新
rime_frontend=fcitx5-rime bash rime-install plum

# 也可以直接安装输入法，不配置预设置项
# 这里是直接安装五笔拼音混合输入法
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | rime_frontend=fcitx5-rime bash -s -- wubi pinyin-simp
```
- [rime/plum: 東風破 /plum/: Rime configuration manager and input schema repository](https://github.com/rime/plum?tab=readme-ov-file#advanced-usage)
- [rime/rime-wubi: 【五筆字型】輸入方案](https://github.com/rime/rime-wubi)

### 配置输入法
```yaml
# ~/.local/share/fcitx5/rime/default.custom.yaml
patch:
  schema_list:
    - schema: wubi_pinyin
```
- [在方案選單中添加五筆、雙拼](https://github.com/rime/home/wiki/CustomizationGuide#%E5%9C%A8%E6%96%B9%E6%A1%88%E9%81%B8%E5%96%AE%E4%B8%AD%E6%B7%BB%E5%8A%A0%E4%BA%94%E7%AD%86%E9%9B%99%E6%8B%BC)

> 可惜Linux版本无法配置自定义样式

### 应用
- 切换到中州韵输入法 > 打开系统托盘菜单 > 选择重新部署

## 参考文档
- [RIME | 中州韻輸入法引擎](https://rime.im/)
- [Rime输入法安装与配置](https://www.thisfaner.com/p/rime/)
- [Rime默认英文状态](https://www.jianshu.com/p/7eb4a2ac0b69)
- [致第一次安装RIME的你](https://www.zybuluo.com/eternity/note/81763)