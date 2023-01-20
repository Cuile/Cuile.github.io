---
title: "在 Python Shell 中重新导入模块"
date: 2023-01-20T23:44:17+08:00
# draft: true

# 标签
tags:
- python
# 专栏
series:
# 分类
categories:
- 编程
---

不同版本中，不同的表现形式：
- Python 2.x：reload() 是内置函数
- Python 3.0 - 3.3：使用 imp.reload(module)
- Python 3.4：imp 已经被废弃，取而代之的是 importlib

```python
from importlib import reload

reload(<module>)
```

参考文档
- [Python 重新加载模块 reload](https://blog.csdn.net/lvhdbb/article/details/95230019)