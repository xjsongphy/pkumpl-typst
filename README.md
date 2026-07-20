# `PKUMpLst`, [项目页]

*A Typst template for 'Modern Physics Laboratory' in PKU — 移植自基于 [`revtex4-2`] 的 [`PKUMpLtX`] (v2.1.6)*

+ Copyright (C) 2013--2025. Modern Phys. Lab, School of Phys., Peking Univ.
+ Copyright (C) 2013--2014. Sun Sibai <niasw_at_pku.edu.cn>
+ Copyright (C) 2013. Cao Chuanwu <>
+ Copyright (C) 2021--2025. Lin Xuchen <linxc_at_pku.edu.cn>
+ Typst 移植 (PKUMpLst): 2025.

本工作以 Creative Commons Attribution-ShareAlike 4.0 International 许可发布.
查看该许可请见 [`LICENSE`],
或致信 Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

希望本模板能帮助同学们专注报告内容, 减少在格式等问题上不必要的时间消耗.
本模板是 LaTeX 版 [`PKUMpLtX`] 的 Typst 移植, 力求在页面几何、字体、行距、表格风格
(首尾双横线)、参考文献样式 (APS) 与章节写作要求说明等方面与原模板保持一致.
本模板不保证可靠性.

**重要提示**: 请使用 `typst` 编译 (`typst compile template.typ`).

- [下载](#下载)
- [文件内容](#文件内容)
- [使用方法](#使用方法)
  - [编译](#编译)
  - [字体选项](#字体选项)
  - [标点选项](#标点选项)
  - [函数与命令列表](#函数与命令列表)
- [与 LaTeX 版 (PKUMpLtX) 的差异](#与-latex-版-pkumpltx-的差异)
- [反馈](#反馈)

## 下载

+ 稳定版: 前往 [Releases] 页面下载最新版本的 `Source code` 文件.
+ 最新: 在[项目页]下载最新源代码.
+ `git clone`: 如果会使用 git, 可以直接 `git clone` 本项目, 之后可以直接 `pull` 获取更新.

## 文件内容

+ [`mplts.typ`]: 模板文件 (对应 LaTeX 版的 `mpltx.cls`).
+ `README.md`: 本文件, 说明文档.
+ [`template.typ`]: 示例报告模板兼说明文档, 可编译得到 `template.pdf`.
  + [`bibli.bib`]: 用于参考文献生成的文件 (Typst 原生读取 `.bib`).
  + [`fig/`]: 示例报告用到的图片.
+ [`american-physics-society.csl`]: APS 参考文献样式 (来自 [CSL styles 仓库](https://github.com/citation-style-language/styles), 2024-12-17 版本), 用于近似复现 `apsrev4-2` 的引用与文献列表风格.
+ [`figgen.py`]: 生成其中一张图片用的脚本.
  + [`fig.mplstyle`]: 相应的格式设置.
+ [`LICENSE`]: CC BY-SA 4.0 许可文本.

## 使用方法

编写报告时, 将 [`mplts.typ`] 复制/链接到当前文件夹, 然后在自己的 `*.typ` 文件开头导入:

```typst
#import "mplts.typ": *

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

`font` 为字体选项 (见下). 使用前推荐先仔细查看 [`template.typ`] 文件.
如果有魔改需求可以自定义 [`mplts.typ`].

### 编译

Typst 单次编译即可 (无 `\tableofcontents` 二次回写、无 `bibtex` 单独步骤):

```bash
typst compile template.typ
```

如需实时预览, 可使用 `typst watch template.typ`.
所有源代码请用 UTF-8 保存.

### 字体选项

`font={macos|noto|fandol}` (对应 LaTeX 版的同名选项, 当前默认 `macos`)

+ `macos`: 默认选项. Roman=Songti SC, Sans=PingFang SC, Mono=STFangsong; 斜体分别映射到 STFangsong / Kaiti SC. 适合 macOS.
+ `noto`: Roman=Noto Serif CJK SC, Sans=Noto Sans CJK SC; 仿宋/楷体回退到 macOS 自带字体. 适合已安装思源系列字体的系统.
+ `fandol`: Roman=FandolSong, Sans=FandolHei, Mono=FandolFang. 需事先安装 [`fandol`] 字体.

英文字体使用 Typst 默认的 New Computer Modern (近 Latin Modern).

各选项的字体配置风格 (与 LaTeX 版一致):
|         | Roman  | Sans Serif | Monospace |
| :-----: | :----: | :--------: | :-------: |
| Upright | 宋体类 |   黑体类   |  仿宋类   |
| Italic  | 仿宋类 |   楷体类   |  楷体类   |

### 标点选项

报告要求是 "全文标点符号除 '顿号' 外, 其他用英文半角标点符号".
若想使用全角标点但把句号从 "。" 自动替换为 "．", 可传入 `quanjiao: true`:

```typst
#show: mplts.with(font: "macos", quanjiao: true)
```

### 函数与命令列表

+ `frontmatter(..)`: 渲染首页标题区 (标题/作者/单位/日期/摘要/关键词). `email`/`phone` 会作为作者脚注给出 (email 为 mailto 链接).
+ `note(it)`: 灰色注释 (对应 `\note`).
+ `ii`, `ee`, `jj`: 数学模式下正体 `i`/`e`/`j` (用法 `$ #ee^(#uppi #ii) + 1 = 0 $`).
+ `uppi`: 正体圆周率 π.
+ `sans(it)`, `mono(it)`: 无衬线 / 等宽文本 (对应 `\textsf` / `\texttt`).
+ `ruled-table(table(..))`: 生成首尾双横线的表格 (对应 `ruledtabular` 环境), 表内中部横线请用 `table.hline(stroke: 0.4pt)` 给出.
+ `acknowledgments[..]`: 致谢环境.
+ `start-appendix()`: 附录起始 (章节编号切换为字母).

## 与 LaTeX 版 (PKUMpLtX) 的差异

本模板力求效果一致, 但因 Typst 与 LaTeX/revtex 的机制不同, 存在以下已知差异:

+ **参考文献**: 使用 CSL 样式 (`american-physics-society.csl`) 近似复现 `apsrev4-2`, 引用以 `[n]` 形式给出, 文献列表为数字编号. 个别字段排版与 `apsrev4-2` 不完全一致.
+ **表格脚注**: Typst 不会自动把表内脚注移到表尾, 推荐把表注作为表格下方的小字直接写出.
+ **正文脚注**: Typst 用普通页脚脚注; LaTeX 版 (revtex) 会将正文脚注并入参考文献列表 (尾注).
+ **小数点对齐列** (`d{a.b}`): Typst 无直接等价物, 请用 `align` 对齐或手工排版.
+ **`physics` 宏包**: Typst 无对应, 如需正体物理符号请用 `upright(..)` / `rm(..)` 等.
+ **章节编号**: 默认采用阿拉伯数字 `1`, `1.1`, 附录为 `A`, `A.1`.
+ 其余 (页面边距、行距、首段缩进、宋体衬线、双横线表格、关键词、摘要收窄等) 均与原模板一致.

## 反馈

如果使用中发现问题或有建议, 请到[项目页]提 issue.
如果有大佬愿意改进这个模板, 也欢迎动手.

[项目页]: https://github.com/CastleStar14654/PKUMpLst
[Releases]: https://github.com/CastleStar14654/PKUMpLst/releases

[`mplts.typ`]: mplts.typ
[`template.typ`]: template.typ
[`bibli.bib`]: bibli.bib
[`fig/`]: fig/
[`american-physics-society.csl`]: american-physics-society.csl
[`figgen.py`]: figgen.py
[`fig.mplstyle`]: fig.mplstyle
[`LICENSE`]: LICENSE

[`PKUMpLtX`]: https://github.com/CastleStar14654/PKUMpLtX
[`revtex4-2`]: https://www.ctan.org/pkg/revtex
[`fandol`]: https://www.ctan.org/pkg/fandol
