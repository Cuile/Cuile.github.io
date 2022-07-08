---
title: "urllib.parse.urlencode 使用详解"
date: 2022-01-17T15:24:58+08:00
# draft: true
tags: ["http"]
series:
- Python
categories:
- 编程
---

> urllib.parse.urlencode(query, doseq=False, safe='', encoding=None, errors=None, quote_via=quote_plus)
urllib.parse.urlencode 将对象或两元素序列转换为百分比编码的ASCII文本字符串，字符串是由'&'字符分隔的一系列 key=value 对，其中 key 和 value 都使用 quote_via 函数引用。

## GET 请求
```python
import urllib
params = urllib.parse.urlencode({'spam': 1, 'eggs': 2, 'bacon': 0})
url = "http://www.musi-cal.com/cgi-bin/query?%s" % params
with urllib.request.urlopen(url) as f:
    print(f.read().decode('utf-8'))
```

## POST 请求
```python
import urllib.request
import urllib.parse
data = urllib.parse.urlencode({'spam': 1, 'eggs': 2, 'bacon': 0})
data = data.encode('ascii')
with urllib.request.urlopen("http://requestb.in/xrbl82xr", data) as f:
    print(f.read().decode('utf-8'))
```

> 如果结果字符串要用作具有 urlopen() 函数的POST操作的 data，则它应该被编码为字节，否则将导致 TypeError。

默认情况下 urlencode 函数使用 quote_plus() 函数进行编码，也可以选用 quote() 函数进行编码，两者最大的不同在于对特定字符的处理。

>urllib.parse.quote_plus(string, safe='', encoding=None, errors=None)
默认情况下使用 quote_plus() 函数，它将空格被编码为 '+' 字符，而“/”字符被编码为 %2F，它遵循GET请求（application/x-www-form-urlencoded）的标准。
urllib.parse.quote(string, safe='/', encoding=None, errors=None)
可以作为备用的函数是 quote()，它将空格编码为 %20，字母，数字和 '_.-'字符不被编码，而“/”字符被默认为安全字符不被编码。

编码时会对所有字符进行编码处理，这会导致一些情况下编码后的参数不能被正确的识别，所以在使用时可根据编码的需求，指定一个编码函数。

```python
urllib.parse.urlencode({'spam': 1, 'eggs': 2, 'bacon': 0}, quote_via=urllib.parse.quote)
```
但即使指定函数，还会有一些特殊情况，需要保留一些特定的字符不被编码。
比如，我们想得到下面的参数

```url
constraints[colors][0]=blue&amp;constraints[colors][1]=%E7%99%BD%20%E8%89%B2&amp;constraints[colors][2]=red&amp;order=newest
```

但无论使用 quote_plus() 或 quote()，“[” 和 “]” 字符一定会被编码。

> 要最大限度地控制编码的内容，请使用 quote() 并指定 safe 的值。

遇到这种情况，就需要根据手册的说明，指定 safe 的值来保证某字符不会被编码。

```python
urllib.parse.urlencode(data, safe='/[]', quote_via=urllib.parse.quote)
```

> safe，encoding 和 errors 参数被传递到 quote_via (encoding 和 errors 参数仅当查询元素是 str 时被传递)。

## 参考
- [urllib.parse.urlencode 手册](https://www.rddoc.com/doc/Python/3.6.0/zh/library/urllib.parse/#urllib.parse.urlencode)
- [urllib.parse.quote 手册](https://www.rddoc.com/doc/Python/3.6.0/zh/library/urllib.parse/#urllib.parse.quote)