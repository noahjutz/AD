#import "/config.typ": theme

#block(stroke: 1pt)[
  #show table.cell.where(y: 0): strong
  #table(
    columns: 4,
    align: right,
    stroke: (x, y) => (
        right: theme.bg_trans,
        bottom: if y == 0 {black} else {theme.bg_trans},
    ),
    table.header(
      "Algoritmus", "lo", "hi", "exact"
    ),
    "Bubblesort", $2^14$, $2^15$, $24.579$,
    "Quicksort", $2^17$, $2^18$, $229.471$,
    "Mergesort", $2^22$, $2^23$, $8.388.604$
  )
]

