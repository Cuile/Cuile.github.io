---
title: "使用 sed 命令操作"
date: 2022-01-17T11:18:47+08:00
# draft: true
tags: 
- sed
- CLI
- Linux
---

## 
```bash
sed [OPTION] [expression] file

[OPTION]
  -n 打印匹配内容
  -i 替换模式
  -i.bak 替换前先备份文件
  -E 使用扩展正则表达式，语法更接近现代正则表达式（如 Perl、Python、JavaScript），代码更清晰易读（去掉了很多反斜杠），减少转义错误
  -e 使用表达式，可使用多个表达式

[expression]
  s|regular|replace| 替换命令
  \|regular|replace|g 匹配整行，默认只匹配一次
  \|regular|replace|d 删除行
  \|regular|replace|p 打印行
  0,\|regular|s||replace| 仅替换从文件开头（第 0 行）首次匹配regular成功的内容，只用GNU版本的sed


```

## 读取指定行
```bash
sed -n '1,2p' file
```

## 删除行
```bash
# 删除空行
sed -i '/^\s*$/d' merge1.log
sed -i '/^$/d' filename.txt  # `^$` 匹配空行
# 按行号删除
sed -i '5d' filename.txt  # 删除第5行
# 删除最后一行
sed -i '$d' filename.txt  # `$` 表示最后一行
# 删除连续行
sed -i '10,20d' filename.txt  # 删除第10到20行
# 删除不连续的行
sed -i '5d;10d;15d' filename.txt  # 删除第5、10、15行
# 删除包含特定文本的行
sed -i '/pattern/d' filename.txt  # 删除含"pattern"的行
# 删除不匹配的行（保留匹配行）
sed -i '/pattern/!d' filename.txt  # `!` 表示取反
# 删除以某文本开头/结尾的行
sed -i '/^prefix/d' filename.txt  # 删除以"prefix"开头的行
sed -i '/suffix$/d' filename.txt  # 删除以"suffix"结尾的行
```

##  删除冗余信息
```bash
sed -i 's/.*a2p_replyclient_log.*[infoerror].[0-9].log.gz://' merge.log \
&& sed -i 's/org.springframework.amqp.rabbit.RabbitListenerEndpointContainer.* - //' merge.log \
&& sed -i '/.*send 1 time for the url is .*/d' merge.log \
&& sed -i '/.*redis key:[0-9]*,value:.*/d' merge.log

sed -i '/>>>>.* retry:2/d' 2021.8.log
sed -i 's/the content of the url:.*receiveStatusReportResultChinaMobile.shtml //' 2021.8.log
```

## 删除毫秒
```bash
sed -i 's/\.[0-9]\{0,3\}\( \[\)/\1/' merge.log
```

## 删除时间
```bash
sed -i 's/.*\(\[INFO\]\)/\1/' 2021.8.log
sed -i 's/.*\(\[ERROR\]\)/\1/' 2021.8.log
sed -i 's/time:.*,\(is_china_mobile\)/\1/' 2021.8.log
```

## 删除冗余字符 
```bash
sed -i 's/error for the url//' merge.log
sed -i 's/can not read content from the url//' merge.log
```

## 统计
```bash
sed -n '/ status:DELIVRD,/p' result.log | wc -l
sed -n '/"originalStatus":"DELIVRD"/p' merge.log | wc -l
```

## 去重复
```bash
awk '!x[$0]++' merge.log
sort -n merge.log | uniq
```

## 修改Ubuntu源地址
```bash
sudo sed -i 's/\(archive\|security\).ubuntu/mirrors.aliyun/' /etc/apt/sources.list
```

## SSH连接不自动断开
```bash
sed -i 's|^#\(ClientAliveInterval\) 0$|\1 60|g' /etc/ssh/sshd_config
sed -i 's|^#\(ClientAliveCountMax\) 3$|\1 5|g' /etc/ssh/sshd_config
systemctl restart sshd
```

## /etc/hosts
```bash
# sed 参考 http://man.linuxde.net/sed
        #  https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html
sed ......
```

## 参考文档
- [sed入门详解教程](https://developer.aliyun.com/article/623030)