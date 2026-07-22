<div align="center">

# pkumpl-typst

### 北京大学近代物理实验 Typst 报告模板

*非官方模板。移植自基于 [`revtex4-2`] 的 [`PKUMpLtX`] (v2.1.6)*

[![Typst](https://img.shields.io/badge/built%20with-Typst-239dad.svg)](https://typst.app/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/license-CC%20BY--SA%204.0-blue.svg)](./LICENSE)

[English](./README.md) | 中文

</div>

## 概述

北京大学《近代物理实验》课程的 Typst 报告模板，由 LaTeX 模板 [`PKUMpLtX`] 移植而来。本项目是独立的非官方 Typst 实现；上游 LaTeX 项目及其维护者仍是原始版式的来源。

## 功能特性

- **对齐 revtex 版式** — 正文 12pt、行距、标题间距与编号均按 `revtex4-2` 的 preprint 样式校准
- **中文排版** — Roman/Sans/Mono 映射到宋体/黑体/仿宋，斜体回退正确；提供 `macos`、`windows`、`noto`、`notofandol`、`fandol` 五套字体预设
- **APS 参考文献** — 通过内置 CSL 文件近似复现 `apsrev4-2`，Typst 原生读取 `.bib`
- **双横线表格** — `ruled-table` 复现 `ruledtabular` 的首尾双横线风格
- **首页标题区** — 一个 `frontmatter(..)` 调用渲染标题/作者/单位/日期/摘要/关键词；摘要按 `mpltx.cls` 的 11pt、400pt 宽度、首行 2em 和约 16.9pt 基线间距实现
- **彩色链接** — 交叉引用、文献引用、URL 按 LaTeX `hyperref` 默认值区分颜色

## 快速开始

**前置依赖：** 已安装 [Typst](https://github.com/typst/typst#installation)。

通过包初始化（发布到 Typst Universe 后）：

```bash
typst init @preview/unofficial-pku-mpl:0.1.0
```

从源码预览完整示例：

```bash
git clone https://github.com/xjsongphy/pkumpl-typst && cd pkumpl-typst
typst compile demo.typ
```

如需实时预览，运行 `typst watch demo.typ`。所有源文件请用 UTF-8 保存。

维护仓库时可选用 [Just](https://just.systems/) 命令运行器，提供 `just compile`、`just watch`、`just check-init`、`just firstpage` 和 `just publish`。其中 `check-init` 会模拟本地 Universe 包，并验证新初始化的项目能够编译。

## Typst 快速入门

如果刚开始使用 Typst，建议先阅读[官方 Typst 教程](https://typst.app/docs/tutorial/)，也可以阅读[中文 Typst 教程](https://typst.dev/docs/tutorial/)。如果希望让 Agent 辅助处理 Typst 文档，可参考 [Claude Typst skill](https://github.com/lucifer1004/claude-skill-typst)。

## 使用方法

在自己的 `*.typ` 文件开头导入包（从克隆仓库使用时也可直接导入 [`mplts.typ`]）：

```typst
#import "@preview/unofficial-pku-mpl:0.1.0": *
// 从本地克隆使用: #import "mplts.typ": *

#show: mplts.with(font: "macos")

#frontmatter(
  title: "实验题目",
  author: "姓名",
  email: "email@pku.edu.cn",
  phone: "(86)152XXXXXXXX",
  affiliation: "北京大学物理学院#h(1em)学号: 20000xxxxx",
  date: "2025 年 3 月 15 日",
  abstract: [ ... ],
  keywords: "关键词1, 关键词2",
)

= 引言
...
```

完整示例见 [`demo.typ`]，其中包含详细注释；最小化 `typst init` 脚手架见 [`template/main.typ`](./template/main.typ)。如有深度定制需求可自定义 [`mplts.typ`]。

### 包结构

两个 Typst 文件的职责如下：

- `mplts.typ` 是包入口，包含可复用的版式、字体、编号、图表、参考文献和工具函数实现。
- `template/main.typ` 是初始化后得到的用户文档，只负责导入已发布的包并提供报告正文示例，不重复实现样式。
- `template/bibli.bib` 与 `template/american-physics-society.csl` 会随初始化复制到用户项目。

包名改为 `unofficial-pku-mpl`。其中 `unofficial` 是中性的、与个人无关的唯一部分，`pku-mpl` 表明机构和课程。远程仓库名为 `pkumpl-typst`；包名和仓库名在 Typst Universe 发布中彼此独立。

Typst Universe 区分“发布的包”和“初始化后的项目”：`mplts.typ` 是包入口；运行 `typst init` 时，`template/main.typ` 会被复制到新项目，并通过绝对包路径导入已发布的包。本仓库中的 `demo.typ` 是完整的本地克隆示例，使用相对路径导入 `mplts.typ`。

官方发布指南的原文是：“In most cases, the template files should not include the styling code for the template. Instead, the template's entrypoint file should import a function from the package.” 同时，初始化模板必须使用绝对包路径导入。详见 [官方发布指南](https://github.com/typst/packages/blob/main/docs/README.md) 与 [manifest 文档](https://github.com/typst/packages/blob/main/docs/manifest.md#templates)。本仓库没有根目录 `template.typ`；manifest 声明的模板入口是 `template/main.typ`。

`demo.typ` 中推荐使用相对大小插入图片，比如设置为 0.8 倍当前区域文字宽度；实验装置图和数据图推荐使用矢量图插入。详见 Typst 的 [`image`] 文档。

### 字体选项

`font={macos|windows|noto|notofandol|fandol}`（默认 `macos`），与 LaTeX 版预设对应：

|         | Roman  | Sans Serif | Monospace |
| :-----: | :----: | :--------: | :-------: |
| Upright | 宋体类 |   黑体类   |  仿宋类   |
| Italic  | 仿宋类 |   楷体类   |  楷体类   |

英文字体使用 New Computer Modern。根据 Typst Universe 的要求，本包不捆绑字体；请在本机安装所选预设需要的中文字库：

- `macos`：Songti SC、PingFang SC、STFangsong、Kaiti SC（macOS）
- `windows`：SimSun/STSong、Microsoft YaHei/DengXian、FangSong、KaiTi（Windows）
- `noto`：Noto Serif CJK SC、Noto Sans CJK SC
- `fandol`：FandolSong、FandolHei、FandolFang、FandolKai
- `notofandol`：Noto Serif/Sans CJK SC 与 FandolFang/FandolKai

需要跨平台、可复现的排版时，建议选择 `noto` 或 `fandol`；默认 `macos` 是为了尽量保持上游 LaTeX 模板在 macOS 上的视觉效果。可运行 `typst fonts` 查看当前 Typst 能识别的字体名称。

### 标点选项

报告要求“全文标点符号除‘顿号’外，其他用英文半角标点符号”。若想使用全角标点但把句号从“。”自动替换为“．”，可传入 `quanjiao: true`：

```typst
#show: mplts.with(font: "macos", quanjiao: true)
```

### 常用函数

- `frontmatter(..)` — 首页标题区（标题/作者/单位/日期/摘要/关键词）
- `note(it)` — 灰色注释（对应 `\note`）
- `ii`、`ee`、`jj`、`uppi` — 数学模式下正体 `i`/`e`/`j`/π
- `sans(it)`、`mono(it)` — 无衬线 / 等宽文本
- `ruled-table(table(..))` — 首尾双横线表格（中部横线用 `table.hline(stroke: 0.4pt)`）
- `acknowledgments[..]`、`bibliography-title[..]`、`start-appendix()` — 标准环境

## 反馈

使用中发现问题或有建议？请到[项目主页](https://github.com/xjsongphy/pkumpl-typst/issues)提 issue。也欢迎提交 PR 改进本模板。

---

## 参考项目

- [`PKUMpLtX`] — 原 LaTeX 模板（基于 revtex4-2），由北京大学近代物理实验课程维护
- [`pkuthss-typst`](https://github.com/pku-typst/pkuthss-typst) — 北京大学学位论文 Typst 模板，可参考其包结构和发布实践
- [`revtex4-2`] — APS revtex 文档类
- [CSL styles](https://github.com/citation-style-language/styles) — APS 参考文献样式来源
- [`fandol`] — Fandol 中文字体

## 版权

+ Copyright (C) 2013–2026. Modern Phys. Lab, School of Phys., Peking Univ.
+ Copyright (C) 2013–2014. Sun Sibai <niasw@pku.edu.cn>
+ Copyright (C) 2013. Cao Chuanwu
+ Copyright (C) 2021–2026. Lin Xuchen <linxc@pku.edu.cn>
+ Copyright (C) 2026. Song Xinjie <xjsongphy@stu.pku.edu.cn>

## 第三方材料与授权

本项目是独立的 Typst 实现，版式和示例材料源自北京大学《近代物理实验》的
LaTeX 模板 [`PKUMpLtX`](https://github.com/CastleStar14654/PKUMpLtX)。移植和改编
的上游材料以 Creative Commons Attribution-ShareAlike 4.0 International 许可证
发布；上游版权声明已保留在上文和 [`LICENSE`] 中。

以下文件源自或复制自上游材料：

- `fig/instruments.png`
- `fig/figsample.pdf`
- `figgen.py`
- `fig.mplstyle`
- `bibli.bib`（为本 Typst 示例补充了部分条目）

APS CSL 文件及其 `template/` 下的副本保留自身的版权和授权信息，使用 Creative
Commons Attribution-ShareAlike 3.0 许可证；它们仍受上游许可证约束，并不因本项目
使用 CC BY-SA 4.0 而被重新授权。

本项目不包含北京大学官方校徽、印章、字体或其他校方品牌资源；项目是非官方项目，
与北京大学无隶属或背书关系。

## 许可证

以 [Creative Commons Attribution-ShareAlike 4.0 International](./LICENSE) (CC BY-SA 4.0) 许可发布。

[`mplts.typ`]: ./mplts.typ
[`demo.typ`]: ./demo.typ
[`PKUMpLtX`]: https://github.com/CastleStar14654/PKUMpLtX
[`revtex4-2`]: https://www.ctan.org/pkg/revtex
[`fandol`]: https://www.ctan.org/pkg/fandol
[`image`]: https://typst.app/docs/reference/visualize/image/
