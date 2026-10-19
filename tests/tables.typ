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

= 旧 ruled-table 包装
#figure(kind: table,
  ruled-table(table(columns: (1fr, 1fr), align: center,
    table.header([配置], [电压 / V]), table.hline(),
    [正交], [1336], [平行], [1330])),
  caption: [兼容旧包装],
) <tab:legacy>
引用 @tab:legacy.

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

= 单表退出自动包装
#table(columns: (1fr, 1fr), stroke: none, [LEFT], [RIGHT])
