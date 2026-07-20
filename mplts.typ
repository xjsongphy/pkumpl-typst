// PKUMpLst --- A Typst template for 'Modern Physics Laboratory' in PKU
//
// 本文件是 PKUMpLtX (mpltx.cls, 基于 revtex4-2) 的 Typst 移植.
// 请阅读 `README.md` 与 `template.typ` 后使用.
//
// Copyright (C) 2013--2025. Modern Phys. Lab, School of Phys., Peking Univ.
// 基于 PKUMpLtX (Lin Xuchen <linxc@pku.edu.cn> 等) 的工作, 以 CC BY-SA 4.0 许可.

// ========== 字体配置 ==========
// 对应 mpltx.cls 的 `font` 选项. 默认 `macos`, 与源模板的 `font=macos` 一致.
// Roman=宋体类, Sans=黑体类(苹方), Mono=仿宋类; 斜体分别映射到仿宋/楷体.
#let _fontsets = (
  macos: (
    main: ("New Computer Modern", "Songti SC"),
    bold-main: ("Songti SC",), // 宋体粗体由系统提供
    sans: ("New Computer Modern", "PingFang SC"),
    mono: ("STFangsong",),
    // 斜体映射 (xeCJK ItalicFont)
    main-italic: ("STFangsong",),
    sans-italic: ("Kaiti SC",),
    mono-italic: ("Kaiti SC",),
  ),
  noto: (
    main: ("New Computer Modern", "Noto Serif CJK SC"),
    sans: ("New Computer Modern", "Noto Sans CJK SC"),
    mono: ("STFangsong",),
    main-italic: ("STFangsong",),
    sans-italic: ("Kaiti SC",),
    mono-italic: ("Kaiti SC",),
  ),
  fandol: (
    main: ("New Computer Modern", "FandolSong"),
    sans: ("New Computer Modern", "FandolHei"),
    mono: ("FandolFang",),
    main-italic: ("FandolFang",),
    sans-italic: ("FandolKai",),
    mono-italic: ("FandolKai",),
  ),
)

#let _pick-font(font) = {
  if font in _fontsets { _fontsets.at(font) }
  else { _fontsets.macos } // 未知字体回退到 macos
}

// ========== 文档级 setup (对应 \documentclass{mpltx} 的全局设置) ==========
// 用法: #show: mplts.with(font: "macos")
#let mplts(doc, font: "macos", quanjiao: false) = {
  let fs = _pick-font(font)

  // ----- 页面几何 (geometry: hmargin=2.5cm, top=2cm, bottom=1.6cm, includefoot) -----
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2cm, bottom: 1.6cm),
  )

  // ----- 文本与字体 (11pt 正文, 中文宋体, 英文 Latin Modern 系列) -----
  set text(
    size: 11pt,
    font: fs.main,
  )
  show text.where(weight: "regular"): set text(font: fs.main)
  // 粗体: xeCJK BoldFont
  show text.where(weight: "bold"): set text(font: fs.main)
  // 斜体: xeCJK ItalicFont
  show text.where(style: "italic"): set text(font: fs.main-italic)
  show text.where(style: "italic", weight: "bold"): set text(font: fs.main-italic)

  // 无衬线/等宽快捷函数 (供 \textsf / \texttt 使用)
  // 通过下面的 sans()/mono() 函数手动调用

  // ----- 段落 (linespread 1.3, 首段缩进 2em, 两端对齐) -----
  set par(
    leading: 0.8em,
    justify: true,
    first-line-indent: 2em,
    spacing: 0.9em,
  )
  // 全角句点映射 (quanjiao 选项: 。→ ．)
  if quanjiao {
    show "。": "．"
  }

  // ----- 标题编号与本地化 -----
  set heading(numbering: "1.1.1")
  // 交叉引用前缀本地化: \sectionautorefname = 小节
  set heading(supplement: "小节")

  show heading.where(level: 1): it => {
    v(1.0em, weak: true)
    align(center)[
      #set text(weight: "bold", size: 12pt)
      #if it.numbering != none {
        context [#counter(heading).display(it.numbering) #h(0.5em)]
      }
      #it.body
    ]
    v(0.5em, weak: true)
  }
  show heading.where(level: 2): it => {
    v(0.7em, weak: true)
    block(width: 100%)[
      #set text(weight: "bold", size: 11pt)
      #if it.numbering != none {
        context [#counter(heading).display(it.numbering) #h(0.5em)]
      }
      #it.body
    ]
    v(0.3em, weak: true)
  }
  show heading.where(level: 3): it => {
    v(0.5em, weak: true)
    block(width: 100%)[
      #set text(weight: "bold", style: "italic", size: 11pt)
      #if it.numbering != none {
        context [#counter(heading).display(it.numbering) #h(0.5em)]
      }
      #it.body
    ]
    v(0.2em, weak: true)
  }

  // ----- 公式编号 (1), 交叉引用 "式 (1)" -----
  set math.equation(numbering: "(1)")

  // ----- 图表本地化: 图 1 / 表 1, 表标题在上方, 图标题在下方 -----
  // 图表本地化前缀: 图 / 表
  set figure(supplement: "图")
  show figure.where(kind: table): set figure(supplement: "表")
  // 表格标题置于上方 (revtex 表标题在上, 图标题在下)
  show figure.where(kind: table): set figure.caption(position: top)
  // 标题格式: "图 1 　caption"
  show figure.caption: it => {
    set text(size: 10pt)
    if it.kind == table {
      [表 #it.counter.display(it.numbering) #h(1em) #it.body]
    } else {
      [图 #it.counter.display(it.numbering) #h(1em) #it.body]
    }
  }

  // ----- 参考文献标题本地化 (由 template 中 #bibliography 给出 title:"参考文献") -----

  doc
}

// ========== 首页标题区 (对应 \title ... \maketitle 与 abstract/keywords) ==========
#let frontmatter(
  title: "",
  author: "",
  affiliation: "",
  abstract: none,
  keywords: "",
  email: none,
  phone: none,
  date: none,
) = {
  set par(first-line-indent: 0em)
  align(center)[
    #block(inset: 0pt)[
      #text(size: 17pt, weight: "bold", title)
    ]
    #v(0.6em)
    #if email != none {
      // emailphone: 作为作者脚注, 内容为 "<email>; <phone>", email 为 mailto 链接
      let body = author
      if phone != none {
        body = [#author#footnote[#link("mailto:" + email)[#email]; #phone]]
      } else {
        body = [#author#footnote[#link("mailto:" + email)[#email]]]
      }
      text(size: 12pt, body)
    } else {
      text(size: 12pt, author)
    }
    #v(0.2em)
    #text(size: 10pt, affiliation)
    #if date != none [
      #v(0.2em)
      #text(size: 10pt, date)
    ]
  ]
  // 摘要: 收窄到 400pt, 首行空两格, 两端对齐
  v(0.8em)
  align(center)[
    #block(width: 400pt)[
      #set par(justify: true, first-line-indent: 2em)
      #abstract
    ]
  ]
  // 关键词: 加粗 "关键词:"
  v(0.6em)
  align(center)[
    #block(width: 400pt)[
      #set par(first-line-indent: 0em)
      #text(size: 10pt)[*关键词:* #keywords]
    ]
  ]
  v(1.0em)
  set par(first-line-indent: 2em)
}

// ========== 工具函数 (对应模板新定义的命令) ==========

// \note: 灰色注释
#let note(it) = text(fill: gray, it)

// \ii, \ee, \jj: 数学模式下正体 i, e, j
#let ii = math.upright("i")
#let ee = math.upright("e")
#let jj = math.upright("j")
// \uppi: 正体圆周率
#let uppi = math.upright("π")

// sans / mono 文本快捷函数 (对应 \textsf / \texttt)
#let sans(it) = text(font: _fontsets.macos.sans, it)
#let mono(it) = text(font: _fontsets.macos.mono, it)

// \mc: multicolumn 简写 (Typst 表格中无需, 提供为兼容别名, 直接返回内容)
#let mc(it) = it

// 双横线 (ruledtabular 首尾双横线): 两条平行细线, 间距 2.5pt
#let _double-rule = block(width: 100%, spacing: 0pt)[
  #stack(
    dir: ttb,
    spacing: 2.5pt,
    line(length: 100%, stroke: 0.5pt),
    line(length: 100%, stroke: 0.5pt),
  )
]

// ruled-table: 包裹一个标准 Typst table, 生成首尾双横线 (对应 ruledtabular 环境).
// 用法见 template.typ. 表内中部横线请在 table 中用 table.hline(stroke: 0.4pt) 给出.
#let ruled-table(it) = block(width: 100%, spacing: 0pt)[
  #_double-rule
  #v(3pt)
  #it
  #v(3pt)
  #_double-rule
]

// 致谢环境 (对应 acknowledgments 环境)
#let acknowledgments(body) = {
  v(0.8em)
  align(center, text(weight: "bold", size: 12pt)[致谢])
  v(0.4em)
  body
}

// 附录起始 (对应 \appendix: 章节编号改为字母)
#let start-appendix() = {
  set heading(numbering: "A.1")
}
