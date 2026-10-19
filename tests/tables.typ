#import "../mplts.typ": *
#show: mplts.with(font: "macos")
#set heading(numbering: none)

= 普通 table
#figure(
  table(columns: (1fr, 1fr), align: center,
    table.header([配置], [电压 / V]), table.hline(),
    [正交], [1336], [平行], [1330]),
  caption: [默认表格],
) <tab:auto>
引用 @tab:auto.

= 显式无网格的原生 table
#figure(
  table(columns: (1fr, 1fr), align: center, stroke: none,
    table.header([配置], [电压 / V]), table.hline(),
    [正交], [1336], [平行], [1330]),
  caption: [显式设置仍采用主题横线],
) <tab:explicit>
引用 @tab:explicit.

#pagebreak()
= 合并单元格
#figure(kind: table,
  table(columns: (1fr, 1fr, 1fr), align: center,
    table.header([A], [B], [C]), table.hline(),
    table.cell(colspan: 2)[横跨两列], [3],
    table.cell(rowspan: 2)[纵跨两行], [5], [6], [7], [8]),
  caption: [保留行列合并],
) <tab:span>
引用 @tab:span.
