---
title: "Centos7 安装 Postgresql"
date: 2024-01-19T13:37:15+08:00
tags:
- postgresql
- centos
- database
---

## 安装
```bash
$ yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

# 安装服务端包
$ yum install postgresql10-server postgresql10
```
## 配置
```bash
# 初始化数据库，设置自启动
$ /usr/pgsql-10/bin/postgresql-10-setup initdb
$ systemctl enable postgresql-10
$ systemctl start postgresql-10

# 设置防火墙规则
$ iptables -A INPUT -p tcp -m tcp --dport 5432 -j ACCEPT              #开放Postgresql 5432端口

$ service iptables save   # 保存防火墙规则
```

## 配置远程访问

```bash
# 切换至用户
$ su - postgres
```
```ini
; ./10/data/postgres.conf
- #listen_address
+ listen_address

; ./10/data/pg_hba.conf
; 允许所有IPv4地址
+ host all all 0.0.0.0/0 scram-sha-256
```

### 登录数据库
```bash
$ psql -U postgres
```

```sql
-- 设置数据运行参数
ALTER SYSTEM SET listen_addresses = '*';
ALTER SYSTEM SET port = 5432;
ALTER SYSTEM SET password_encryption = 'scram-sha-256';

--  修改默认用户密码
ALTER USER postgres with encrypted password '你的密码';

-- 退出数据库
\q

-- 退出用户
exit    
```

### 重启服务
```bash
systemctl restart postgresql-10
```