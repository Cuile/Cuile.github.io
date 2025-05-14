---
title: "MySQL 数据操作"
date: 2022-01-18T14:50:28+08:00
# draft: true
tags:
- mysql
---

## 1. 复制

- [复制表数据，表结构的3种方法](http://blog.51yip.com/mysql/1311.html)

## 2. 导入

### 2.1 使用 LOAD DATA

- 如果是导入有中文的数据，我的mysql 设置的utf8 字符集，所以你要导入的 文件也要保存utf-8的字符集，数据表列的顺序必须和excel的对应，否则导入的数据会有错误,
- 文件路径名要上的 " \ "要变成 “ \ ”或者 " / ",否则会报错
- 如果mysql用户没有读取本地文件的权限，那必须添加local参数，通过mysql client来读取文件

- [通过load data infile，20秒导入100W数据](https://blog.csdn.net/JavaReact/article/details/78854283)
- [LOAD DATA INFILE语句导入数据进入MySQL的一些注意事项](https://www.jianshu.com/p/dc94471d6778)

## 3. 删除

 - [清空表(truncate)与删除表中数据(delete) 详解](https://blog.csdn.net/chenshun123/article/details/79676446)