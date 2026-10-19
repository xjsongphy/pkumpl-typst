#import "../mplts.typ": *
#show: mplts.with(font: "macos")
#set page(width: 160mm, height: 180mm, margin: 15mm)
#let data = table(columns: (1fr, 1fr), align: center,
  table.header([HEADER], [READING]), table.hline(),
  ..range(1, 91).map(i => ([ROW-#i], [VALUE-#i])).flatten())
#if sys.inputs.at("legacy", default: "false") == "true" {
  ruled-table(data)
} else {
  data
}
