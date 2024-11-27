#import "/config.typ": theme

#let keys_lin = (22, 88, none, none, 4, 15, 28, 17, 59, 31, 10)
#let keys_quad = (22, none, 88, 17, 4, none, 28, 59, 15, 31, 10)
#let keys_double = (22, none, 59, 17, 4, 15, 28, 88, none, 31, 10)

#show table.cell.where(x: 0): text.with(fill: theme.fg_dark)

#let hashtable(dataset) = block(
  stroke: theme.fg_medium,
  spacing: 8pt,
  table(
    columns: 2,
    align: end,
    stroke: (x, ..) => if x == 1 {black},
    ..dataset.enumerate()
      .flatten()
      .map(c => if c != none {str(c)})
  )
)

#align(center)[
  #stack(dir: ltr, spacing: 1fr)[
    #hashtable(keys_lin)
    (a)
  ][
    #hashtable(keys_quad)
    (b)
  ][
    #hashtable(keys_double)
    (c)
  ]
]