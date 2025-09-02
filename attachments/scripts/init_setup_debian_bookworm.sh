#!/bin/bash
# based on cloud-init debian

set -e

# 添加系统判断，即可通过函数运行不同的命令
stdout() {
  echo "$(basename $0): $1"
}
installer() {
  sudo apt-get install -y $* # $* 将所有参数视为一个单一的字符串
}
# 添加系统判断，即可对变量赋不同的值
BASHRC="${HOME}/.bashrc"
# SSH_KEY="${HOME}/.ssh/cuile.key"

stdout "配置服务器时区"
timedatectl set-timezone Asia/Shanghai

stdout "关闭邮件服务"
sudo systemctl stop postfix@-.service
sudo systemctl disable postfix@-.service
    
stdout "配置软件仓库"
# 可使用以下命令，扫描延迟最低的软件仓库
# sudo apt install -y netselect-apt && sudo netselect-apt && sudo apt autoremove -y netselect-apt
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/mirrors/debian.list
sed -i -e "s/deb.debian.org/mirrors.bfsu.edu.cn/" /etc/apt/mirrors/debian-security.list

stdout "配置Shell提示符"
echo "PS1='\[\e[36;40m\][\D{%Y-%m-%d} \A] \[\e[0m\] \[\e[35;40m\]\w\[\e[0m\]\n\[\e[33;40m\][\u@\H]\[\e[0m\] \\$ '" >> ${BASHRC}

stdout "添加自定义命令"
sed -i -e"s/#alias ll='ls -l'/alias ll='ls -l'/" ${BASHRC}

stdout "安装 Git" \
  && installer git keychain
  # && echo "eval `keychain --eval $SSH_KEY`" >> $BASHRC \
  # && ssh -T git@github.com \

stdout "安装 Docker" \
  && installer ca-certificates curl \
  && sudo install -m 0755 -d /etc/apt/keyrings \
  && sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && sudo chmod a+r /etc/apt/keyrings/docker.asc\
  && sudo echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && sudo apt-get update \
  && installer docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  && sudo systemctl enable docker.service \
  && sudo systemctl start docker.service \
  && sudo docker version ; sudo docker compose version

# stdout "安装 iptables" 

stdout "配置 sshd"
sudo sed -i -e"s/#Port 22/Port 22/" /etc/ssh/sshd_config
# 允许密码登录
# sed -i -e"s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config
# 解决SSH自动断开问题
sudo sed -i -e"s/#ClientAliveInterval 0/ClientAliveInterval 60/" /etc/ssh/sshd_config
sudo sed -i -e"s/#ClientAliveCountMax 3/ClientAliveCountMax 3/" /etc/ssh/sshd_config
sudo systemctl restart sshd.service

stdout "配置优先使用IPv4网络"
sudo sed -i -e"s/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/" /etc/gai.conf



stdout "使用 \"source ${BASHRC}\" 命令重新加载Shell"