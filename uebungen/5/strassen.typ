#show table.cell: square.with(size: 28pt, stroke: none)
#set table.cell(inset: 0pt, align: center + horizon)
#set align(center)

#grid(
  columns: 2,
  column-gutter: 4pt,
  row-gutter: 4pt,
  align: center + bottom,
  none, "M", "N",
  table(
    columns: 2,
    $M_(1 1)$,
    $M_(1 2)$,
    $M_(2 1)$,
    $M_(2 2)$,
  ),
  table(
    columns: 2,
    $N_(1 1)$,
    $N_(1 2)$,
    $N_(2 1)$,
    $N_(2 2)$,
  ),
  table(
    columns: 2,
    $O_(1 1)$,
    $O_(1 2)$,
    $O_(2 1)$,
    $O_(2 2)$,
  ),
)