---
title: "使用 sed 命令操作文本文件"
date: 2022-01-17T11:18:47+08:00
# draft: true
tags: ["Linux","sed"]
---

**`脚本基于Ubuntu 20.04`**

## 合并文件
```bash
cat info.log error.log > merge.log.bak
cp merge.log.bak merge.log
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

## 统计
```bash
sed -n '/ status:DELIVRD,/p' result.log | wc -l
sed -n '/"originalStatus":"DELIVRD"/p' merge.log | wc -l
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

## 去重复
```bash
$ awk '!x[$0]++' merge.log
$ sort -n merge.log | uniq
```

## 删除空行
```bash
$ sed -i '/^\s*$/d' merge1.log
```

```bash
# 修改Ubuntu源地址
$ sudo sed -i 's/\(archive\|security\).ubuntu/mirrors.aliyun/' /etc/apt/sources.list
```