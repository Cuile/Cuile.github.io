---
title: "VSCode 配置 Python 开发环境"
date: 2023-11-25T00:24:10+08:00
# draft: true

tags:
- micromamba
- python
- venv
- vscode
---
使用 VSCode 开发 Python 是替代 PyCharm 的一个很好选择，有丰富的扩展和第三方工具可以使用，安装配置好它们，会让开发工作事半功倍。下面列举推荐安装的扩展和工具：

*扩展*
- Material Icon There
  - VSCode图标，很好看
- Python
  - 微软官方扩展，一定要装
- Pylance
  - 微软官方扩展，一定要装
- autoDocstring
- Python Environment Manager
- Ruff
- Code Runner
- Qt for Python

*工具*
- Micromamba
  - 使用 Micromamba 来配置 Python 开发环境有几个好处：
    - micromamba 是一个包管理器，可方便的同时安装几个软件，形成一个独立的开发环境，与其它项目的开发环境完全隔离。
    - micromamba 安装的软件，不会在系统留下痕迹，不会污染本地系统。
    - micromamba 只配置 python 基础环境，不影响 python 虚拟环境，同一个基础环境可提供给多个虚拟环境使用。

## 配置 Micromamba
[Micromamba的安装与使用]({{< ref "post/Python/micromamba.md">}})

## 配置 VSCode[^1]
配置 Venv 路径
1. 使用 “ctrl+,” 打开设置界面，搜索 venv ，出现两个结果：

| 选项 | 值   |
| :---  | :--- |
| Python: Venv Folders | 如果安装时使用默认位置，就填写 micromamba，下面的不用设置 |
| Python: Venv Path    | 如果安装时没有使用默认位置，就填写安装位置，上面的不用设置 |
| Python: Conda Path   | 直接输入conda 即可                                     |

2. 重启VSCode，进入 Python 项目，就可以看到右下角的 Python 环境了，如果创建了多个环境，可以通过这里切换。这里需要注意 vscode 可以识别多个 Python 版本，但无法正确配置它们。所以创建不同的 Python 版本后，还要为项目选择解释器。

### 使用 Python 虚拟环境
1. 使用项目终端界面，创建虚拟环境。
```powershell
# 先激活 micromamba 环境
PS "Your Project Path"> conda activate PyQt

# 创建Python虚拟环境
# --upgrade 参数是升级虚拟环境用的，新建虚拟环境时要去掉。
# --system-site-packages 会降低环境隔离性，生产环境慎用。
(PyQt) PS "Your Project Path"> python -m venv --prompt "<myproject>" --upgrade-deps .venv --symlinks --upgrade --system-site-packages
# 查看项目资源管理器，看到 .venv 文件夹就成功了。

# 激活Python虚拟环境
(PyQt) PS "Your Project Path"> Activate.ps1

# 成功进入虚拟环境
(myproject) (PyQt) PS "Your Project Path">

```
重启 vscode 再次进入项目终端，不一定会看到项目前缀[^2]。VsCode已经自动修你激活了Python虚拟环境，不需要再操作。
安装包里不需要激活 micromamba 环境，否则包将被安装到 micromamba 环境中。

## 其它配置
| 选项 | 值  |
| :---  | :--- |
| Editor: Default Formatter                           | Ruff |
| Python > Terminal: ACtivate Env In Current Terminal | 勾选    |
| Python > Terminal: Focus After Launch               | 勾选    |
| Python: Language Server                             | Pylance |
| Pylthon > Analysis: Type Checking Mode              | basic |

---
[^1]:[使用 Micromamba 替换 Miniconda 更快配置 Python 环境](https://zhuanlan.zhihu.com/p/622346839?utm_id=0)
[^2]:[Activate Environments in Terminal Using Environment Variables](https://github.com/microsoft/vscode-python/wiki/Activate-Environments-in-Terminal-Using-Environment-Variables)