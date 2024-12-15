#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#set align(center)
#set block(spacing: 0pt)
#show table.cell: box.with(width: 20pt, height: 20pt)

#show table.cell.where(y: 0): set text(fill: theme.fg_dark)

#table(
  columns: 3,
  align: center + horizon,
  stroke: (.., y) => if y != 0 {black},
  "0", "1", "2",
  "0", "-1", "2"
)

#diagram(
  spacing: (20pt, 20pt),
  edge((0, 0), "-|>", (0,1)),
  edge((1, 0), "-X", (1,.5)),
  edge((2, 0), "-|>", (2,1))
)

#show table.cell.where(y: 0): set text(fill: black)
#show table.cell.where(y: 1): set text(fill: theme.fg_dark)

#table(
  columns: 3,
  align: center + horizon,
  stroke: (.., y) => if y == 0 {black},
  "0", "2", "1",
  "0", "1", "2",
)