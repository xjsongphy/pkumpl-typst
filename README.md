<div align="center">

# pkumpl-typst

### A Typst Template for PKU Modern Physics Laboratory Reports

*Unofficial template. Ported from the [`revtex4-2`]-based [`PKUMpLtX`] (v2.1.6)*

[![Typst](https://img.shields.io/badge/built%20with-Typst-239dad.svg)](https://typst.app/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/license-CC%20BY--SA%204.0-blue.svg)](./LICENSE)

English | [中文](./README_zh.md)

</div>

## Overview

A Typst template for the *Modern Physics Laboratory* course at Peking University, ported from the LaTeX template [`PKUMpLtX`]. This project is an independent, unofficial Typst implementation; the original LaTeX project and its maintainers remain the source of the upstream design.

## Features

- **Revtex-Faithful Layout** — Matches `revtex4-2` preprint style for body 12pt, line spacing, heading spacing, and numbering
- **Chinese Typography** — Roman/Sans/Mono mapped to Songti/Heiti/Fangsong with correct italic fallbacks; five font presets (`macos`, `windows`, `noto`, `notofandol`, `fandol`)
- **APS Bibliography** — `apsrev4-2` style approximated via a bundled CSL file; native `.bib` reading
- **Ruled Tables** — `ruled-table` reproduces the `ruledtabular` top-and-bottom double-line style
- **Frontmatter** — One `frontmatter(..)` call renders title, author, affiliation, date, abstract, and keywords; the abstract follows `mpltx.cls` with 11pt text, 400pt width, a 2em first-line indent, and an approximately 16.9pt baseline distance
- **Colored Links** — Cross-references, citations, and URLs colored per the LaTeX `hyperref` defaults

## Quick Start

**Prerequisites:** [Typst](https://github.com/typst/typst#installation) installed.

From the package (once published to Typst Universe):

```bash
typst init @preview/unofficial-pku-mpl:0.1.0
```

From source, to preview the full demo:

```bash
git clone https://github.com/xjsongphy/pkumpl-typst && cd pkumpl-typst
typst compile demo.typ
```

For live preview, `typst watch demo.typ`. All source files must be UTF-8 encoded.

For repository maintenance, the optional [Just](https://just.systems/) command runner provides `just compile`, `just watch`, `just check-init`, `just thumbnail`, and `just publish`. The `check-init` recipe simulates a local Universe package and verifies that a fresh project compiles.

## Typst Quick Start

New to Typst? Start with the official [Typst tutorial](https://typst.app/docs/tutorial/), or read the [Chinese Typst tutorial](https://typst.dev/docs/tutorial/). For agent-assisted Typst work, see the [Claude Typst skill](https://github.com/lucifer1004/claude-skill-typst).

## Usage

Import the package (or [`mplts.typ`] directly when working from a clone) at the top of your `*.typ` file:

```typst
#import "@preview/unofficial-pku-mpl:0.1.0": *
// From a local clone instead: #import "mplts.typ": *

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

See [`demo.typ`] for a full annotated example, or [`template/main.typ`](./template/main.typ) for the minimal `typst init` scaffold. Edit [`mplts.typ`] for deeper customization.

### Package structure

The two Typst files have the following roles:

- `mplts.typ` is the package entrypoint and contains the reusable layout, typography, numbering, figure/table, bibliography, and helper-function implementation.
- `template/main.typ` is the initialized user document. It imports the published package and contains only report content plus usage examples; it does not duplicate the styling implementation.
- `template/bibli.bib` and `template/american-physics-society.csl` are copied into new projects.

The package name is `unofficial-pku-mpl`. `unofficial` is a neutral, non-personal unique part and `pku-mpl` identifies the institution and course. The repository is `pkumpl-typst`, while the package name remains separate for Typst Universe publishing.

Typst Universe distinguishes the published package from the initialized project: `mplts.typ` is the package entrypoint, while `template/main.typ` is copied into a new project by `typst init` and imports the published package with its absolute package path. In this repository, `demo.typ` is the full local-clone example and imports `mplts.typ` relatively.

The official package guidance says: “In most cases, the template files should not include the styling code for the template. Instead, the template's entrypoint file should import a function from the package.” It also requires an absolute package-style import for an initialized template. See the [official package submission guidelines](https://github.com/typst/packages/blob/main/docs/README.md) and [manifest documentation](https://github.com/typst/packages/blob/main/docs/manifest.md#templates). There is no root-level `template.typ` in this repository; `template/main.typ` is the manifest-declared template entrypoint.

`demo.typ` recommends sizing images relative to the current text area, for example at 0.8 times its width; vector images are recommended for apparatus and data figures. See Typst's [`image`] documentation.

### Font Options

`font={macos|windows|noto|notofandol|fandol}` (default `macos`), matching the LaTeX presets:

|         | Roman  | Sans Serif | Monospace |
| :-----: | :----: | :--------: | :-------: |
| Upright | Songti |   Heiti    |  Fangsong |
| Italic  | Fangsong |  Kaiti   |  Kaiti    |

Latin text uses New Computer Modern. The package does not bundle fonts, as required by Typst Universe. Install the CJK fonts needed by the selected preset locally:

- `macos`: Songti SC, PingFang SC, STFangsong, and Kaiti SC (macOS)
- `windows`: SimSun/STSong, Microsoft YaHei/DengXian, FangSong, and KaiTi (Windows)
- `noto`: Noto Serif CJK SC and Noto Sans CJK SC
- `fandol`: FandolSong, FandolHei, FandolFang, and FandolKai
- `notofandol`: Noto Serif/Sans CJK SC plus FandolFang/FandolKai

Use `noto` or `fandol` for a reproducible cross-platform setup. `macos` remains the default because it most closely matches the upstream LaTeX rendering on macOS. Run `typst fonts` to inspect the names visible to your Typst installation.

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

Found a bug or have a suggestion? Please [open an issue](https://github.com/xjsongphy/pkumpl-typst/issues). Pull requests are welcome.

---

## References

- [`PKUMpLtX`] — Original LaTeX template (revtex4-2 based), by the Modern Physics Lab, Peking University
- [`pkuthss-typst`](https://github.com/pku-typst/pkuthss-typst) — Peking University thesis Typst template, referenced for package structure and publishing practice
- [`revtex4-2`] — APS revtex class
- [CSL styles](https://github.com/citation-style-language/styles) — Source of the APS bibliography style
- [`fandol`] — Fandol Chinese fonts

## Copyright

+ Copyright (C) 2013–2026. Modern Phys. Lab, School of Phys., Peking Univ.
+ Copyright (C) 2013–2014. Sun Sibai <niasw@pku.edu.cn>
+ Copyright (C) 2013. Cao Chuanwu
+ Copyright (C) 2021–2026. Lin Xuchen <linxc@pku.edu.cn>
+ Copyright (C) 2026. Song Xinjie <xjsongphy@stu.pku.edu.cn>

## Third-party materials and licensing

This project is an independent Typst implementation derived from the layout and
example materials of [`PKUMpLtX`](https://github.com/CastleStar14654/PKUMpLtX),
the original LaTeX template for the Peking University Modern Physics Laboratory.
The adapted upstream material is distributed under the Creative Commons
Attribution-ShareAlike 4.0 International License; the upstream copyright notices
are preserved above and in [`LICENSE`].

The following files are derived from or copied from upstream materials:

- `fig/instruments.png`
- `fig/figsample.pdf`
- `figgen.py`
- `fig.mplstyle`
- `bibli.bib` (with additional entries for this Typst example)

The APS CSL file and its copy under `template/` carry their own metadata and are
licensed under the Creative Commons Attribution-ShareAlike 3.0 License. They
remain subject to that upstream license and are not relicensed by this project's
CC BY-SA 4.0 license.

This project does not bundle Peking University logos, seals, fonts, or other
official university brand assets. It is unofficial and is not affiliated with
or endorsed by Peking University.

## License

Released under the [Creative Commons Attribution-ShareAlike 4.0 International](./LICENSE) (CC BY-SA 4.0).

[`mplts.typ`]: ./mplts.typ
[`demo.typ`]: ./demo.typ
[`PKUMpLtX`]: https://github.com/CastleStar14654/PKUMpLtX
[`revtex4-2`]: https://www.ctan.org/pkg/revtex
[`fandol`]: https://www.ctan.org/pkg/fandol
[`image`]: https://typst.app/docs/reference/visualize/image/
