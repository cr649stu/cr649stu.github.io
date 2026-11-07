# 个人主页 · 使用说明

四个主页面 + 四个可点的项目原型。全站没有 JavaScript 框架、没有后端，纯静态文件。

| 文件 | 页面 |
| --- | --- |
| `index.html` | 首页（浅蓝渐变，居中：你好 / 名字 / 一句话 / 四个入口） |
| `education.html` | 教育背景（纵向时间线：武汉理工大学 · 数字经济） |
| `skills.html` | 专业技能（两列六张卡片） |
| `hobbies.html` | 个人爱好（足球，附一个相关作品入口） |
| `works.html` | 个人作品（七张作品卡） |
| `works-before-graduation.html` | 「毕业之前」项目页：标题 + 说明 + **原型窗口**（一屏内） |
| `demo-before-graduation.html` | 「毕业之前」可点原型：记录 / 互助 / 纪念 都能点进去 |
| `works-clubhub.html` | 「社团活动管理」项目页：负责人 / 学生两种视角切换 |
| `demo-clubhub.html` | 「社团活动管理」可点原型：登录、报名、发布活动 |
| `works-timer.html` | 「计时器」项目页：直接嵌着计时器 |
| `demo-timer.html` | 「计时器」本体：开始 / 暂停 / 重置 |
| `works-gacha.html` | 「传奇抽卡」项目页：直接嵌着游戏 |
| `demo-gacha.html` | 「传奇抽卡」本体：301 名球员、367 张卡 |
| `style.css` | 全站样式 |
| `project.css` | 项目页与原型的样式 |
| `assets/demo/` | 原型用到的 10 张图片 |

打开方式：双击 `index.html`。

> 原型页用 iframe 嵌在项目页里，本地双击打开一般能显示；如果空白，
> 点项目页右上角的「新窗口打开 ↗」，或直接双击 `demo-before-graduation.html`。

## 设计约定

- 只用三种颜色：白 `#ffffff`、浅灰（`--gray-text` / `--gray-line`）、深蓝 `#1b3a8b`
- 页面背景是极浅的蓝色渐变（顶部偏蓝、往下过渡到白），其余元素不用渐变
- 没有阴影、没有装饰元素
- 动效只有颜色变化（0.2s）
- 首页不放导航，靠四个按钮进入子页；子页顶部一条细线导航，当前页为深蓝色
- 「个人作品」排在第一位：首页按钮为蓝字、蓝边，右上角挂一枚「精选」小角标；
  子页导航里它被一圈蓝色细边框框成小胶囊

## 关于「毕业之前」原型

真实项目是 React + Express + SQLite，需要 Node 后端，GitHub Pages 跑不起来。
所以这里做的是一个**纯前端的可点复刻**：同样的三个栏目、同样的内容结构和视觉，
数据写在 `demo-before-graduation.html` 里，点赞、筛选、搜索、加购物袋都在浏览器里模拟。

想改成真实项目的话，需要把后端部署到能跑 Node 的服务器（Render、Railway 之类），
再把项目页里的 iframe 地址换过去。

## 个人信息

- 姓名：王开怀
- 学校与专业：**武汉理工大学 · 数字经济**

## 上传到 GitHub Pages

1. 打开 `https://github.com/CR649STU/cr649stu.github.io/upload/main`
2. 把 **15 个文件**和 **assets 文件夹**一起拖进去：
   `works-before-graduation.html`、`demo-before-graduation.html`、
   `works-clubhub.html`、`demo-clubhub.html`、`works-timer.html`、`demo-timer.html`、
   `works-gacha.html`、`demo-gacha.html`、
   `style.css`、`project.css`
3. 拖 `assets` 文件夹（里面是 `demo/` 十张图），GitHub 会保留目录结构
4. 提交信息填 `更新个人主页`，点「提交变更」
5. 等 1～2 分钟，访问 `https://cr649stu.github.io/works.html`

> 别传 zip：GitHub 不会解压。
> 仓库里如果还留着旧版本（`hobbies.html`、`contact.html`、`work.html`、`script.js`、
> `assets/before-graduation/`），点进去删除即可。

## 改内容

- 技能：`skills.html` 的六张卡片
- 作品：`works.html` 的四张卡片
- 原型内容：`demo-before-graduation.html` 顶部的 `posts` / `questions` / `products` 三个数组