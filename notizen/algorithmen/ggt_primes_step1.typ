#import "@preview/cetz:0.2.2": canvas, draw

#show math.equation: set text(fill: gray)
#show math.equation: box.with(inset: (x: 10pt))
#show table.cell.where(y: 0): strong

#table(
  columns: 5,
  stroke: (x, y) => {
    let border = (
      top: none, left: none, right: none, bottom: none
    )
    if x == 3 {border.left = 1pt}
    if y == 0 and x > 0 and x < 4 {border.bottom = 1pt}
    if y == 5 and x > 0 and x < 4{border.top = 1pt}
    border
  },
  "", "a", "b", "ggT", "",
  $div 2$, "528", "3780", "1", $dot 2$,
  $div 2$, "1764", "1890", "2", $dot 2$,
  $div 9$, "882", "945", "4", $dot 9$,
  $...$, "98", "105", "45", $...$,
  "", "14", "15", "252", ""
)
