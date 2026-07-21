<div align="center">

# PKUMpLst

### A Typst Template for PKU Modern Physics Laboratory Reports

*Ported from the [`revtex4-2`]-based [`PKUMpLtX`] (v2.1.6)*

[![Typst](https://img.shields.io/badge/built%20with-Typst-239dad.svg)](https://typst.app/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/license-CC%20BY--SA%204.0-blue.svg)](./LICENSE)

English | [中文](./README_zh.md)

</div>

## Overview

A Typst template for the *Modern Physics Laboratory* course at Peking University, ported from the LaTeX template [`PKUMpLtX`].

## Features

- **Revtex-Faithful Layout** — Matches `revtex4-2` preprint style for body 12pt, line spacing, heading spacing, and numbering
- **Chinese Typography** — Roman/Sans/Mono mapped to Songti/Heiti/Fangsong with correct italic fallbacks; three font presets (`macos`, `noto`, `fandol`)
- **APS Bibliography** — `apsrev4-2` style approximated via a bundled CSL file; native `.bib` reading
- **Ruled Tables** — `ruled-table` reproduces the `ruledtabular` top-and-bottom double-line style
- **Frontmatter** — One `frontmatter(..)` call renders title, author, affiliation, date, abstract, and keywords
- **Colored Links** — Cross-references, citations, and URLs colored per the LaTeX `hyperref` defaults

## Quick Start

**Prerequisites:** [Typst](https://github.com/typst/typst#installation) installed.

From the package (once published to Typst Universe):

```bash
typst init @preview/pku-mpl
```

From source, to preview the full demo:

```bash
git clone https://github.com/xjsongphy/PKUMpLst && cd PKUMpLst
typst compile demo.typ
```

For live preview, `typst watch demo.typ`. All source files must be UTF-8 encoded.

## Usage

Import the package (or [`mplts.typ`] directly when working from a clone) at the top of your `*.typ` file:

```typst
#import "@preview/pku-mpl:0.1.0": *
// from a local clone instead: #import "mplts.typ": *

#show: mplts.with(font: "macos")

#frontmatter(
  title: "Experiment Title",
  author: "Your Name",
  email: "email@pku.edu.cn",
  phone: "(86)152XXXXXXXX",
  affiliation: "School of Physics, Peking University",
  date: "March 15, 2025",
  abstract: [ ... ],
  keywords: "keyword1, keyword2",
)

= Introduction
...
```

See [`demo.typ`] for a full annotated example, or [`template/main.typ`](./template/main.typ) for the minimal `typst init` scaffold. Customize [`mplts.typ`] for deeper modifications.

### Font Options

`font={macos|noto|fandol}` (default `macos`), matching the LaTeX presets:

|         | Roman  | Sans Serif | Monospace |
| :-----: | :----: | :--------: | :-------: |
| Upright | Songti |   Heiti    |  Fangsong |
| Italic  | Fangsong |  Kaiti   |  Kaiti    |

Latin text uses New Computer Modern. Install the [`fandol`] fonts if you choose that preset.

### Punctuation

The course requires half-width punctuation everywhere except the Chinese comma (顿号). To use full-width punctuation while auto-replacing `。` with `．`:

```typst
#show: mplts.with(font: "macos", quanjiao: true)
```

### Key Functions

- `frontmatter(..)` — Title block (title/author/affiliation/date/abstract/keywords)
- `note(it)` — Gray note (cf. `\note`)
- `ii`, `ee`, `jj`, `uppi` — Upright `i`/`e`/`j`/π in math
- `sans(it)`, `mono(it)` — Sans-serif / monospace text
- `ruled-table(table(..))` — Double-ruled table (use `table.hline(stroke: 0.4pt)` for inner rules)
- `acknowledgments[..]`, `bibliography-title[..]`, `start-appendix()` — Standard environments

## Feedback

Found a bug or have a suggestion? Please [open an issue](https://github.com/xjsongphy/PKUMpLst/issues). Pull requests are welcome.

---

## References

- [`PKUMpLtX`] — Original LaTeX template (revtex4-2 based), by the Modern Physics Lab, Peking University
- [`revtex4-2`] — APS revtex class
- [CSL styles](https://github.com/citation-style-language/styles) — Source of the APS bibliography style
- [`fandol`] — Fandol Chinese fonts

## Copyright

+ Copyright (C) 2013–2026. Modern Phys. Lab, School of Phys., Peking Univ.
+ Copyright (C) 2013–2014. Sun Sibai <niasw@pku.edu.cn>
+ Copyright (C) 2013. Cao Chuanwu
+ Copyright (C) 2021–2026. Lin Xuchen <linxc@pku.edu.cn>
+ Copyright (C) 2026. Song Xinjie <xjsongphy@stu.pku.edu.cn>

## License

Released under the [Creative Commons Attribution-ShareAlike 4.0 International](./LICENSE) (CC BY-SA 4.0).

[`mplts.typ`]: ./mplts.typ
[`demo.typ`]: ./demo.typ
[`PKUMpLtX`]: https://github.com/CastleStar14654/PKUMpLtX
[`revtex4-2`]: https://www.ctan.org/pkg/revtex
[`fandol`]: https://www.ctan.org/pkg/fandol
