// unofficial-pku-mpl --- A Typst template for 'Modern Physics Laboratory' in PKU
//
// 本文件是 PKUMpLtX (mpltx.cls, 基于 revtex4-2) 的 Typst 移植.
// 请阅读 `README.md` 与 `template/main.typ` 后使用.
//
// Copyright (C) 2013--2025. Modern Phys. Lab, School of Phys., Peking Univ.
// 基于 PKUMpLtX (Lin Xuchen <linxc@pku.edu.cn> 等) 的工作, 以 CC BY-SA 4.0 许可.

// ========== 字体配置 ==========
// 对应 mpltx.cls 的 `font` 选项. 默认 `macos`, 与源模板的 `font=macos` 一致.
// Roman=宋体类, Sans=黑体类(苹方), Mono=仿宋类; 斜体分别映射到仿宋/楷体.
#let _fontsets = (
  macos: (
    main: ("New Computer Modern", "Songti SC"),
    bold-main: ("New Computer Modern", "Songti SC"),
    sans: ("New Computer Modern", "PingFang SC"),
    mono: ("STFangsong",),
    // 斜体映射 (xeCJK ItalicFont)
    main-italic: ("New Computer Modern", "STFangsong"),
    bold-main-italic: ("New Computer Modern", "STFangsong"),
    sans-italic: ("New Computer Modern", "Kaiti SC"),
    mono-italic: ("Kaiti SC",),
  ),
  noto: (
    main: ("New Computer Modern", "Noto Serif CJK SC"),
    bold-main: ("New Computer Modern", "Noto Serif CJK SC Bold", "Noto Serif CJK SC"),
    sans: ("New Computer Modern", "Noto Sans CJK SC"),
    mono: ("Noto Serif CJK SC",),
    main-italic: ("Noto Serif CJK SC",),
    bold-main-italic: ("Noto Serif CJK SC",),
    sans-italic: ("Noto Sans CJK SC",),
    mono-italic: ("Noto Serif CJK SC",),
  ),
  fandol: (
    main: ("New Computer Modern", "FandolSong"),
    bold-main: ("New Computer Modern", "FandolSong Bold"),
    sans: ("New Computer Modern", "FandolHei"),
    mono: ("FandolFang",),
    main-italic: ("FandolFang",),
    bold-main-italic: ("FandolFang",),
    sans-italic: ("FandolKai",),
    mono-italic: ("FandolKai",),
  ),
  notofandol: (
    main: ("New Computer Modern", "Noto Serif CJK SC"),
    bold-main: ("New Computer Modern", "Noto Serif CJK SC Bold", "Noto Serif CJK SC"),
    sans: ("New Computer Modern", "Noto Sans CJK SC"),
    mono: ("FandolFang",),
    main-italic: ("FandolFang",),
    bold-main-italic: ("FandolFang",),
    sans-italic: ("FandolKai",),
    mono-italic: ("FandolKai",),
  ),
  windows: (
    main: ("New Computer Modern", "SimSun", "STSong"),
    bold-main: ("New Computer Modern", "SimSun", "STSong"),
    sans: ("New Computer Modern", "Microsoft YaHei", "DengXian"),
    mono: ("FangSong", "STFangsong"),
    main-italic: ("FangSong", "STFangsong"),
    bold-main-italic: ("FangSong", "STFangsong"),
    sans-italic: ("KaiTi", "STKaiti"),
    mono-italic: ("KaiTi", "STKaiti"),
  ),
)

#let _pick-font(font) = {
  if font in _fontsets { _fontsets.at(font) }
  else { _fontsets.macos } // 未知字体回退到 macos
}

// 当前文档使用的字体配置。这样 sans()/mono() 会跟随 mplts(font: ...),
// 不会在用户选择 noto/fandol/windows 时仍然偷偷使用 macOS 字体。
#let _active-fonts = state("mplts-fonts", _fontsets.macos)

#let _appendix-mode = state("mplts-appendix", false)

// 生成与 revtex4-2 一致的层级编号。用 counter(...).at(location) 而不是
// 直接 display 完整层级，避免 Typst 默认的“4.1”出现在正文中。
#let _heading-number(it) = context {
  let values = counter(heading).at(it.location())
  let value = values.at(it.level - 1)
  let appendix = _appendix-mode.get()
  let format = if appendix {
    if it.level == 1 { "A" } else { "1" }
  } else if it.level == 1 {
    "I"
  } else if it.level == 2 {
    "A"
  } else {
    "1"
  }
  let weight = if it.level <= 2 { "bold" } else { "regular" }
  let style = if it.level == 3 { "italic" } else { "normal" }
  let suffix = if appendix and it.level == 1 { ":" } else { "." }
  let number = text(font: "New Computer Modern", weight: weight, style: style)[
    #numbering(format, value)#suffix
  ]
  if appendix and it.level == 1 {
    [附录 #number]
  } else {
    [#number]
  }
}

// ========== 文档级 setup (对应 \documentclass{mpltx} 的全局设置) ==========
// 用法: #show: mplts.with(font: "macos")
#let mplts(doc, font: "macos", quanjiao: false) = {
  let fs = _pick-font(font)
  _active-fonts.update(fs)

  // ----- 页面几何 (geometry: hmargin=2.5cm, top=2cm, bottom=1.6cm, includefoot) -----
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2cm, bottom: 1.6cm),
    numbering: "1",
  )

  // ----- 文本与字体 (12pt 正文, 中文宋体, 英文 Latin Modern 系列) -----
  set text(
    size: 12pt,
    font: fs.main,
  )
  // macOS 的 LaTeX 版使用 Songti regular；Typst 这里明确使用 Light，避免
  // 普通正文视觉上过重。粗体使用 Black/最重字重，拉开与正文的层次。
  show text.where(weight: "regular"): set text(font: fs.main, weight: 300)
  // 粗体: 对应 xeCJK 的 BoldFont; 不能继续使用正文字体, 否则 Typst 的
  // weight 标记存在但实际字形仍然是常规字重.
  show text.where(weight: "bold"): set text(font: fs.bold-main, weight: 800)
  // 斜体: xeCJK ItalicFont
  show text.where(style: "italic"): set text(font: fs.main-italic)
  show text.where(style: "italic", weight: "bold"): set text(font: fs.bold-main-italic)
  // 与 LaTeX 版仅写 `\\hypersetup{colorlinks=true}` 时的 hyperref 默认色保持一致:
  // 内部交叉引用为 red, 文献引用为 green, URL/邮件链接为 magenta.
  show link: set text(fill: rgb("#ff00ff"))
  show ref: set text(fill: rgb("#ff0000"))
  show cite: set text(fill: rgb("#00ff00"))

  // 无衬线/等宽快捷函数 (供 \textsf / \texttt 使用)
  // 通过下面的 sans()/mono() 函数手动调用

  // ----- 段落 (linespread 1.3, 首段缩进 2em, 两端对齐) -----
  set par(
    leading: 1.1em,
    justify: true,
    first-line-indent: 2em,
    // 与 1.1em leading 合计为约 2em，使段间基线距离与段内行距一致。
    spacing: 0.9em,
  )
  // 全角句点映射 (quanjiao 选项: 。→ ．)
  if quanjiao {
    show "。": "．"
  }

  // ----- 标题编号与本地化 -----
  // revtex4-2 的 preprint 样式使用 I. / A. / 1. 三种编号，
  // 且三级标题为斜体；附录则使用“附录 A:”与 1. 编号。
  set heading(numbering: "1.1.1")
  // 交叉引用前缀本地化: \sectionautorefname = 小节
  set heading(supplement: "小节")

  show heading.where(level: 1): it => {
    block(above: 0.8cm, below: 0.5cm, breakable: false)[
      #set text(weight: "bold", size: 11pt)
      #if it.numbering != none {
        context [#_heading-number(it) #h(1em)]
      }
      #it.body
    ]
    // revtex 加载 indentfirst, 因而标题后的首段也缩进 2em. Typst 默认不缩进
    // heading 后的首段, 这里用一个空的水平盒子补回该行为.
    h(2em)
  }
  show heading.where(level: 2): it => {
    block(inset: (left: 2em), above: 0.8cm, below: 0.5cm, breakable: false)[
      #set text(weight: "bold", size: 11pt)
      #if it.numbering != none {
        context [#_heading-number(it) #h(1em)]
      }
      #it.body
    ]
    h(2em)
  }
  show heading.where(level: 3): it => {
    block(inset: (left: 2em), above: 0.8cm, below: 0.5cm, breakable: false)[
      #set text(style: "italic", size: 11pt)
      #if it.numbering != none {
        context [#_heading-number(it) #h(1em)]
      }
      #it.body
    ]
    h(2em)
  }

  // ----- 公式编号 (1), 交叉引用 "式 (1)" -----
  set math.equation(numbering: "(1)", supplement: "式")

  // ----- 图表本地化: 图 1 / 表 1, 表标题在上方, 图标题在下方 -----
  // 图表本地化前缀: 图 / 表
  set figure(supplement: "图")
  show figure.where(kind: table): set figure(supplement: "表")
  // 不全局强制页顶浮动：否则初始化模板中的首个 figure 会跑到标题区之前。
  // Typst 默认按源文档位置排版；需要浮动时，用户可在具体 figure 上指定 placement。
  set figure(gap: 10pt)
  // 表格标题置于上方 (revtex 表标题在上, 图标题在下)
  show figure.where(kind: table): set figure.caption(position: top)
  // 标题格式: "图 1. caption". 图题和表题均居中对齐。
  show figure.caption: it => {
    let body = if it.kind == table {
      [表 #it.counter.display(it.numbering). #h(0.5em) #it.body]
    } else {
      [图 #it.counter.display(it.numbering). #h(0.5em) #it.body]
    }
    if it.kind == table {
      align(center, text(size: 11pt)[#body])
    } else {
      align(center, text(size: 11pt)[#body])
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
      #text(size: 14pt, weight: "bold", title)
    ]
    #v(0.6em)
    #if email != none {
      // emailphone: 作为作者脚注, 内容为 "<email>; <phone>", email 为 mailto 链接
      let body = author
      if phone != none {
        body = [#author#footnote(numbering: "*")[#link("mailto:" + email)[#email]; #phone]]
      } else {
        body = [#author#footnote(numbering: "*")[#link("mailto:" + email)[#email]]]
      }
      text(size: 12pt, body)
    } else {
      text(size: 12pt, author)
    }
    #v(0.2em)
    #text(size: 11pt, style: "italic", affiliation)
    #if date != none [
      #v(0.2em)
      #text(size: 11pt, style: "italic", date)
    ]
  ]
  // 摘要: 收窄到 400pt, 首行空两格, 两端对齐
  // 与 LaTeX 的 5.5pt preabstract space 对齐；Typst block 的字体盒高度与
  // TeX minipage 不同，视觉基线需要少量补偿。
  v(3pt)
  // 页面正文宽度为 16cm，左右各留约 26.77pt 后得到 LaTeX 的 400pt 摘要宽度。
  // 这里不使用外层 align(center)，避免摘要文字继承居中对齐。
  block(width: 100%)[
    #pad(left: 26.77pt, right: 26.77pt)[
      #block(width: 400pt)[
        #set align(left)
        #set text(size: 11pt)
        // mpltx.cls 将摘要设为 11pt/13pt，并通过 \linespread{1.3} 得到约 16.9pt
        // 的实际基线间距；这里直接设置等效 leading，而不是沿用正文行距。
        #set par(justify: true, first-line-indent: 0em, leading: 0.85em, spacing: 0pt)
        #h(2em)
        #abstract
      ]
    ]
  ]
  // 关键词: 加粗 "关键词:"
  // 与 LaTeX 的 6.5pt postabstract space 对齐。
  v(4.5pt)
  align(center)[
    #block(width: 400pt)[
      #align(left)[
        #set par(first-line-indent: 0em)
        #text(size: 11pt)[*关键词:* #keywords]
      ]
    ]
  ]
  // revtex 的 frontmatter@finalspace 为 18pt.
  v(18pt)
  set par(first-line-indent: 2em)
}

// ========== 工具函数 (对应模板新定义的命令) ==========

// 图表后的第一段正文。Typst 不会自动缩进紧跟在块元素后的首段；
// 定义成内容值而不是内容函数，确保它在图后作为独立元素展开。
#let after-figure = [#h(2em) #parbreak()]

// \note: 灰色注释
#let note(it) = {
  // set text 会作用于普通文本和行内数学；display equation 是独立元素，
  // 因而需要额外设定其文字颜色，才能和 LaTeX 的 {\\color{gray}...} 一致。
  set text(fill: gray)
  show math.equation: text.with(fill: gray)
  it
}

// \ii, \ee, \jj: 数学模式下正体 i, e, j
#let ii = math.upright("i")
#let ee = math.upright("e")
#let jj = math.upright("j")
// \uppi: 正体圆周率
#let uppi = math.upright("π")

// sans / mono 文本快捷函数 (对应 \textsf / \texttt)
#let sans(it) = context text(font: _active-fonts.get().sans, it)
#let mono(it) = context text(font: _active-fonts.get().mono, it)

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
// 用法见 template/main.typ. 表内中部横线请在 table 中用 table.hline(stroke: 0.4pt) 给出.
#let ruled-table(it) = block(width: 100%, spacing: 0pt)[
  #_double-rule
  #v(3pt)
  #set text(size: 11pt)
  #set table(stroke: none)
  #it
  #v(3pt)
  #_double-rule
]

// 致谢环境 (对应 acknowledgments 环境)
#let acknowledgments(body) = {
  v(0.8cm)
  text(weight: "bold", size: 11pt)[致谢]
  v(0.5cm)
  block(width: 100%)[
    #set text(size: 12pt, style: "normal")
    #set par(first-line-indent: 2em)
    #h(2em)
    #body
  ]
}

// 参考文献标题在 revtex4-2 中居中，条目由 Typst 的 bibliography 负责排版。
// 使用方法: #bibliography-title[参考文献] 后接 bibliography(..., title: none).
#let bibliography-title(body) = {
  v(0.8cm)
  align(center, text(weight: "bold", size: 11pt)[#body])
  v(0.5cm)
}

// 附录起始 (对应 \appendix: 章节编号改为字母)
#let start-appendix() = {
  _appendix-mode.update(true)
  counter(heading).update(0)
}
