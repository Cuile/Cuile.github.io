#!/bin/bash

function logger {
    echo "$(basename $0): $1"
}
# 添加系统判断，即可通过函数运行不同的命令
function updater {
    apt-get update
}
function installer {
    apt-get install -y $* # $* 将所有参数视为一个单一的字符串
}
# 添加系统判断，即可对变量赋不同的值
BASHRC="~/.bashrc"
SSH_KEY="~/.ssh/cuile.key"


updater

logger "配置命令提示符" \
    && echo "PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '" >> $BASHRC \
    && logger "完成"

logger "配置服务器时区" \
    && timedatectl set-timezone Asia/Shanghai \
    && logger "完成"

logger "安装 Git" \
    && installer git keychain \
    && echo "eval `keychain --eval $SSH_KEY`" >> $BASHRC \
    && ssh -T git@github.com \
    && logger "完成"

logger "安装 Docker" \
    && installer ca-certificates curl \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc\
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && updater \
    && installer docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    && systemctl enable docker.service \
    && systemctl start docker.service \
    && docker version ; docker compose version \
    && logger "完成"

logger "安装 iptables" 

logger "配置 sshd"