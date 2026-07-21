<div align="center">

# PKUMpLst

### 北京大学近代物理实验 Typst 报告模板

*移植自基于 [`revtex4-2`] 的 [`PKUMpLtX`] (v2.1.6)*

[![Typst](https://img.shields.io/badge/built%20with-Typst-239dad.svg)](https://typst.app/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/license-CC%20BY--SA%204.0-blue.svg)](./LICENSE)

[English](./README.md) | 中文

</div>

## 概述

北京大学《近代物理实验》课程的 Typst 报告模板，由 LaTeX 模板 [`PKUMpLtX`] 移植而来。

## 功能特性

- **对齐 revtex 版式** — 正文 12pt、行距、标题间距与编号均按 `revtex4-2` 的 preprint 样式校准
- **中文排版** — Roman/Sans/Mono 映射到宋体/黑体/仿宋，斜体回退正确；提供 `macos`、`noto`、`fandol` 三套字体预设
- **APS 参考文献** — 通过内置 CSL 文件近似复现 `apsrev4-2`，Typst 原生读取 `.bib`
- **双横线表格** — `ruled-table` 复现 `ruledtabular` 的首尾双横线风格
- **首页标题区** — 一个 `frontmatter(..)` 调用渲染标题/作者/单位/日期/摘要/关键词
- **彩色链接** — 交叉引用、文献引用、URL 按 LaTeX `hyperref` 默认值区分颜色

## 快速开始

**前置依赖：** 已安装 [Typst](https://github.com/typst/typst#installation)。

通过包初始化（发布到 Typst Universe 后）：

```bash
typst init @preview/pku-mpl
```

从源码预览完整示例：

```bash
git clone https://github.com/xjsongphy/PKUMpLst && cd PKUMpLst
typst compile demo.typ
```

如需实时预览，运行 `typst watch demo.typ`。所有源文件请用 UTF-8 保存。

## 使用方法

在自己的 `*.typ` 文件开头导入包（从克隆仓库使用时也可直接导入 [`mplts.typ`]）：

```typst
#import "@preview/pku-mpl:0.1.0": *
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

完整示例见 [`demo.typ`]，其中包含详细注释；最小化 `typst init` 脚手架见 [`template/main.typ`](./template/main.typ)。如有深度魔改需求可自定义 [`mplts.typ`]。

### 字体选项

`font={macos|noto|fandol}`（默认 `macos`），与 LaTeX 版预设对应：

|         | Roman  | Sans Serif | Monospace |
| :-----: | :----: | :--------: | :-------: |
| Upright | 宋体类 |   黑体类   |  仿宋类   |
| Italic  | 仿宋类 |   楷体类   |  楷体类   |

英文字体使用 New Computer Modern。选用 `fandol` 需先安装 [`fandol`] 字体。

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

使用中发现问题或有建议？请到[项目主页](https://github.com/xjsongphy/PKUMpLst/issues)提 issue。也欢迎提交 PR 改进本模板。

---

## 参考项目

- [`PKUMpLtX`] — 原 LaTeX 模板（基于 revtex4-2），由北京大学近代物理实验课程维护
- [`revtex4-2`] — APS revtex 文档类
- [CSL styles](https://github.com/citation-style-language/styles) — APS 参考文献样式来源
- [`fandol`] — Fandol 中文字体

## 版权

+ Copyright (C) 2013–2026. Modern Phys. Lab, School of Phys., Peking Univ.
+ Copyright (C) 2013–2014. Sun Sibai <niasw@pku.edu.cn>
+ Copyright (C) 2013. Cao Chuanwu
+ Copyright (C) 2021–2026. Lin Xuchen <linxc@pku.edu.cn>
+ Copyright (C) 2026. Song Xinjie <xjsongphy@stu.pku.edu.cn>

## 许可证

以 [Creative Commons Attribution-ShareAlike 4.0 International](./LICENSE) (CC BY-SA 4.0) 许可发布。

[`mplts.typ`]: ./mplts.typ
[`demo.typ`]: ./demo.typ
[`PKUMpLtX`]: https://github.com/CastleStar14654/PKUMpLtX
[`revtex4-2`]: https://www.ctan.org/pkg/revtex
[`fandol`]: https://www.ctan.org/pkg/fandol
