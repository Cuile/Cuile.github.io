---
title: "在pypi上发布自己的Python库"
date: 2018-05-11T14:49:57+08:00
# draft: true
tags: 
- PyPi
series:
- Python
categories:
- 代码
---

Python 的 pypi.python.org 站点终于要退休了，而新的接任者 pypi.org 无论从美观、风格上都让人大大的喜欢，终于在审美一这项上及格了。

而且新的 pypi.org 能够正确的渲染 Markdown 格式的描述，实在是让人欣慰，终于可以和 Github 同步了，不用在麻烦的转换一次了。

下面就来聊聊，如何正确的把库发布到 pypi.org 上：

## 1. 注册 pypi.org 账号

嗯，这是正确的废话！

## 2. 编写 setup.py

setup.py 的内容比较重要，但其它的细节不谈，主要聊聊 long_description 部分，这部分是对库能力的详细描述。

> 如果说 keywords 和 description 能提高别人搜索到项目的概率的话，那 long_description 就在很大程度上决定别人对你对项目有没有进一步的想法了。

在针对 long_description 的网上介绍中，对具体使用方法明确写出的是少之又少，所以我今天就特别举例说明一下。

### 2.1 setup.py

```python
#!/usr/bin/env python
# coding: utf-8

from setuptools import setup

setup(
name='sequence2hash',
version='1.1.2',
keywords='tuple dict list sequence hash key/value',
packages=['sequence2hash'],

url='https://github.com/Cuile/sequence2hash',
description='This tool converts a valid value in a sequence to a hash and contains a path to a valid value in the key field',
long_description_content_type='text/markdown',
long_description=open('README.md', encoding='utf8').read(),

author='cuile',
author_email='i@cuile.com'
)
```

### 2.2 读取 readme.md 文件

```python
long_description=open('README.md', encoding='utf8').read()
```

这句代码是较少明确说明的，可以不引用 io 库，而直接使用 open 函数读取文件内容，由于 pypi.org 支持 Markdown ，所以可以和 Github 使用同一份 README.md 文件。

### 2.3 设置内容类型

```python
long_description_content_type='text/markdown'

```

这句很重要，标明元数据字段中 long_description 的格式，支持 text/plain, text/x-rst, text/markdown 。

> A content type can be specified with the long_description_content_type argument, which can be one of text/plain, text/x-rst, or text/markdown, corresponding to no formatting, reStructuredText (reST), and the Github-flavored Markdown dialect of Markdown respectively.

## 3. 打包上传

先升级一下必要的打包工具，setuptools>= 38.6.0 才能使用新的元数据生成发布包， twine> = 1.11.0 才能将元数据正确发送到 PyPI 。

```bash
$ pip install -U setuptools twine

# 打包
$ python setup.py sdist

# 上传
$ twine upload dist/*
```

_twine 会依次上传 dist 文件夹下的所有内容，但 pypi.org 对已上传过的文件和版本是不允许再次上传的，所以每次更新内容时除了 version 字段递增外，还要在打包前删除 dist 文件夹，由打包命令重新生成，以防文件夹内有老版本的包，导致上传失败。_

## 参考
- [如何将自己的程序发布到 PyPI](https://zhuanlan.zhihu.com/p/26159930)
- [PyPI 终于支持 Markdown 了](https://zhuanlan.zhihu.com/p/34853707)
- [打包 python package 到 pypi](http://litaotao.github.io/submit-push-package-to-pypi)
- [在Pypi上发布自己的Python包](https://www.jianshu.com/p/e9ec8666decc)
- [Packaging and distributing projects](https://packaging.python.org/tutorials/distributing-packages/#description)
- [EMOJI CHEAT SHEET](https://www.webpagefx.com/tools/emoji-cheat-sheet/)
- [GitHub上README写法暨GFM语法解读](https://blog.csdn.net/guodongxiaren/article/details/23690801)