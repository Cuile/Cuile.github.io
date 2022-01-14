---
title: "Github使用Hugo生成Blog"
date: 2022-01-14T17:15:06+08:00
draft: true
tags: ["Hugo","Github","Blog"]
---

## 设置流程

不过多说明了，网上教程非常多，可以找来看。

**参考文档**
- [使用 Github Actions 自动发布 hugo 站点](https://h1z3y3.me/posts/hugo-auto-deploy-github-with-actions/)
- [Hugo的基本安装｜网站生成｜托管至Github Pages](https://zhuanlan.zhihu.com/p/350977057)

## 各种坑位

### 1. 网页正常部署后，访问时页面却无法正常显示，部局完全是乱的。

这可能是https请求报"block:mixed-content"错误导致的，是浏览器不允许在https页面里嵌入http的请求，现在高版本的浏览器为了用户体验，都不会弹窗报错，只会在控制台上打印一条错误信息。

解决这个问题，可以从以下2点入手：

1.1. 在"theme/<YouThemeName>/layouts/partials/head.html"文件内，添加代码
```html
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
```
**参考文档**
- [https请求报错block:mixed-content问题的解决办法](https://blog.csdn.net/qq_39390545/article/details/105550949)

1.2. 确保config.toml文件内，"baseUrl"的值与实际地址一致。

### 2. config.toml 里的 theme 值，要与主题文档夹名一致，不然可能会导致主题无法应用的问题。

### 3. Github Actions 设置里的 gh-pages.yml 写法要注意

"Setup Hugo"项目里，标准版本与扩展版本的参数写法不一样。
```yml
# 使用扩展版本
- name: Setup Hugo
  uses: peaceiris/actions-hugo@v2
  with:
    hugo-version: '0.91.2'
    extended: true
```
```yml
# 使用标准版本
- name: Setup Hugo
  uses: peaceiris/actions-hugo@v2
  with:
    hugo-version: 'latest'
```
**参考文档**
- [GitHub Actions for Hugo](https://github.com/peaceiris/actions-hugo#options)

