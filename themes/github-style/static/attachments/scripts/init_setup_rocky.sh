#!/bin/bash
# based on rocky

set -e

echo "配置命令提示符" \
    && echo "PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '" >> ~/.bash_profile

echo "配置服务器时区" \
    && timedatectl set-timezone Asia/Shanghai

echo "安装 iptables" \
    && PORT="28883" \
    && systemctl stop firewalld \
    ; yum -y erase firewalld \
    ; yum -y install iptables iptables-services initscripts \
    && systemctl enable iptables \
    && systemctl start iptables \
    && iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT \
    && iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT \
    && iptables -A INPUT -p icmp -j ACCEPT \
    && iptables -A INPUT -p tcp -m tcp --dport ${PORT} -j ACCEPT \
    && iptables -P OUTPUT ACCEPT \
    && iptables -P INPUT DROP \
    && iptables -P FORWARD DROP \
    && service iptables save \
    && iptables -nL

echo "配置 sshd"

echo "安装 Git" \
    && yum -y install git

echo "安装 Docker" \
    && yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine \
    && yum install -y yum-utils lvm2 device-mapper-persistent-data \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
    && yum makecache timer \
    && yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
    && systemctl enable docker.service \
    && systemctl start docker.service \
    && docker run hello-world \
    && docker compose version