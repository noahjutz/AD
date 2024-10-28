#import "/config.typ": theme

#show table.cell: set align(end)
#show table: box.with(stroke: black)
#show table.cell.where(y: 0): strong

#table(
  columns: 3,
  stroke: (x, y) => if y == 0 {(right: theme.bg_trans, bottom: black)} else {(right: theme.bg_trans, bottom: theme.bg_trans)},
  table.header(
    "n", "Naiv [s]", "Strassen [s]",
  ),
  "4", "0", "0",
  "8", "0", "0",
  "16", "0.1", "0",
  "32", "0.6", "0.2",
  "64", "4.5", "1.3",
  "128", "20.2", "9"
)