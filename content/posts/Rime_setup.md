---
title: "Rime输入法设置"
date: 2024-01-19T13:11:15+08:00
tags:
- Rime
---

## 1.安装五笔

- `输入法设定`-`获取更多输入方案`-`在打开的命令行窗口`
- 输入 "wubi" 回车

## 2.配置P站风格配色主题

- `用户文件夹`-`weasel.custom.yaml`
- 在 "patch:" 项目下加入：
```yaml
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
- 注意格式缩进

## 参考文档

- [Rime输入法安装与配置](https://www.thisfaner.com/p/rime/)
- [Rime默认英文状态](https://www.jianshu.com/p/7eb4a2ac0b69)
- [致第一次安装RIME的你](https://www.zybuluo.com/eternity/note/81763)