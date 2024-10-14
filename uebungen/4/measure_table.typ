#import "/config.typ": theme

#block(stroke: 1pt)[
  #show table.cell.where(y: 0): strong
  #table(
    columns: 7,
    align: (x, y) => {
      if x == 0 or y in (0, 1) {center + horizon} else {right}
    },
    inset: (x, y) => {
      if x == 0 or y in (0, 1) {4pt} else {(x: 4pt, y: 10pt)}
    },
    stroke: (x, y) => (
        right: if x == 0 {black} else {theme.bg_trans},
        bottom: if y == 1 {black} else {theme.bg_trans},
    ),
    table.header(
      "",
      table.cell(colspan: 2)[Bubblesort],
      table.cell(colspan: 2)[Quicksort],
      table.cell(colspan: 2)[Mergesort],
      "", $n$, $t$, $n$, $t$, $n$, $t$
    ),
    "lo", $2^14$, $50s$, $2^17$, $20s$, $2^22$, $57s$,
    "hi", $2^15$, $>60s$, $2^18$, $0.3s$, $2^23$, $>60s$,
    "=", $24K$, $46s$, $229K$, $24s$, $8M$, $46s$
  )
]

