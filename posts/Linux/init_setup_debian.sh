#!/bin/bash
apt-get update

echo "配置命令提示符" \
    && echo "PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '" >> ~/.bashrc \
    && echo "完成"

echo "配置服务器时区" \
    && timedatectl set-timezone Asia/Shanghai \
    && echo "完成"

echo "安装 Git" \
    && apt-get -y install git \
    && echo "完成"

echo "安装 Docker" \
    && apt-get install -y ca-certificates curl \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc\
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && systemctl enable docker.service \
    && systemctl start docker.service \
    && docker version ; docker compose version \
    && echo "完成"

echo "安装 iptables" 

echo "配置 sshd"