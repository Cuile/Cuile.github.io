---
title: "VScode 在 Docker 容器内开发"
date: 2023-11-25T00:24:10+08:00
# draft: true

tags:
- python
- venv
- docker
- vscode
---
在 Docker 的容器内开发，相当于使用VSCode的远程开发能力，好处非常多。

- 开发环境统一、可维护性强
- 后期部署简单

## 1. 安装 Docker

各系统安装 Docker 的教程很多，这里略过。

## 2. 安装 Visual Stuido Code

这不废话嘛，同上。

## 3. 安装 Remote Development 扩展包

官方推荐安装 Remote Development 这个扩展包，它包括三个扩展功能：

- Remote - SSH
- Remote - Containers
- Remote - WSL

如果你只使用 Docker ，可以只安装 Remote - Containers 这个扩展。

安装成功后，你可以在 VSCode 的左下角，看到一个“蓝底色+两个相对白箭头”的图标。

点击图标，可以看到 Remote - Containers 提供了许多方法进行配置。

## 4. 配置 Remote - Containers

### 4.1. 使用现成的 docker-compose.yml 配置

1. 点击左下角的蓝色图标
1. 选择 Add Development Container Configuration Files...
1. 选择 Existing Docker Compose (Extend)
    1. VSCode 会自动在项目的根目录下，生成 .devcontainer 文件夹
    1. 在 .devcontainer 目录内，包括两个文件：
        1. devcontainer.json：VSCode 使用它连接开发容器
        1. docker-compose.yml：示例文件，可以不用管它
1. 打开 devcontainer.json 文件

> 照着 docker-compose.yml 进行修改，见下面示例

> ```json
> // If you want to run as a non-root user in the container, see .devcontainer/docker-compose.yml.
> {
>   "name": "Existing Docker Compose (Extend)",
>   // Update the 'dockerComposeFile' list if you have more compose files or use different names.
>   // The .devcontainer/docker-compose.yml file contains any overrides you need/want to make.
>   "dockerComposeFile": [
>       // 项目已有 docker-compose.yml 文件的相对路径
>       "../docker/docker-compose.yml",
>       // 可加载多个yml文件，按加载顺序排好即可
>       "docker-compose.yml"
>   ],
>   // The 'service' property is the name of the service for the container that VS Code should
>   // use. Update this value and .devcontainer/docker-compose.yml to the real service name.
>   // VSCode 要连接的容器名称，必须与 docker-compose.yml 文件里 services 项定义的一致
>   "service": "robot",
>   // The optional 'workspaceFolder' property is the path VS Code should open by default when
>   // connected. This is typically a file mount in .devcontainer/docker-compose.yml
>   // 容器的工作目录，必须与 docker-compose.yml 文件里 volumes 项定义的一致
>   "workspaceFolder": "/root/code",
>   // Use 'settings' to set *default* container specific settings.json values on container create.
>   // You can edit these settings after create using File > Preferences > Settings > Remote.
>   "settings": {
>       // This will ignore your local shell user setting for Linux since shells like zsh are typically
>       // not in base container images. You can also update this to an specific shell to ensure VS Code
>       // uses the right one for terminals and tasks. For example, /bin/bash (or /bin/ash for Alpine).
>       // 系统使用的shell，一般都 /bin/bash
>       "terminal.integrated.shell.linux": "/bin/bash"
>   },
>   // Uncomment the next line to have VS Code connect as an existing non-root user in the container. See
>   // https://aka.ms/vscode-remote/containers/non-root for details on adding a non-root user if none exist.
>   // "remoteUser": "vscode",
>   // Uncomment the next line if you want start specific services in your Docker Compose config.
>   // "runServices": [],
>   // Uncomment the next line if you want to keep your containers running after VS Code shuts down.
>   // "shutdownAction": "none",
>   // Uncomment the next line to run commands after the container is created - for example installing git.
>   // "postCreateCommand": "apt-get update && apt-get install -y git",
>   // Add the IDs of extensions you want installed when the container is created in the array below.
>   // 在容器内安装的扩展，会在启动时自动安装好
>   // 容器外即本地安装的扩展，主要对 VSCode 的外观起作用
>   // 容器内安装的扩展，才能对代码起作用，如：代码格式化等
>   "extensions": [
>       // 扩展的标识符，可以在扩展详细页面的[名称]旁边找到
>       "ms-python.python"
>   ]
> }
> ```

## 5. 运行

1. 再次点击左下角的蓝色图标
1. 选择 Reopen in Container，VSCode 将重启，并自动启动 docker ，进入容器安装扩展，准备好开发环境
1. 成功启动过一次后，VSCode 会自动在[欢迎使用]页面[最近]项目下添加快速入口

## 6. 参考链接

- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
