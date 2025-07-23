#!/bin/bash

# 下载clound-init镜像
# 注意！！！
# 注意！！！
# 注意！！！
# 一定要下载各Linux发生版为OpenStack准备的镜像，只有这种镜像能与PVE兼容。
# 其它镜像可以正常创建虚拟机，但会出现各种问题，比如无法登录。
# wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2

CLOUD_INIT_IMG="./debian-12-generic-amd64.qcow2"
. ./create_VM.sh "$1" "$2" "$3"

stdout "
    1. 启动虚拟机，因配置时间较长，请耐心等待
    2. WebUI虚拟机概要查看VM IP地址
    3. 本地密码无法登录，使用cloud-config.yaml里配置的public.key，通过SSH工具登录VM，User: ${USER}
    4. 首次启动，使用 \"sh /usr/sbin/init_setup_debian.sh\" 脚本初始化环境
    "