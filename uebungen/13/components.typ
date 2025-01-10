#import "/config.typ": theme

#let n = 6

#let adjacency_matrix = (
  (0, calc.inf, calc.inf, calc.inf, -1, calc.inf),
  (1, 0, calc.inf, 2, calc.inf, calc.inf),
  (calc.inf, 2, 0, calc.inf, calc.inf, -8),
  (-4, calc.inf, calc.inf, 0, 3, calc.inf),
  (calc.inf, 7, calc.inf, calc.inf, 0, calc.inf),
  (calc.inf, 5, 10, calc.inf, calc.inf, 0),
)

#let mat(m, hl: none) = context layout(((width, height)) => {
  set block(breakable: false)
  let t = table(
    columns: m.len() * (1fr,),
    align: center,
    stroke: theme.fg_light,
    ..m.enumerate().map(((i, row)) => {
      row.enumerate().map(((j, x)) => {
        table.cell(
          fill: if hl != none and hl.at(i).at(j) {
            theme.primary_light
          }
        )[$#x$]
      })
    }).flatten()
  )
  t
  let (width, height) = measure(width: width, height: height, t)
  place(top + left, path(
    (6pt, 0pt),
    (0pt, 0pt),
    (0pt, height),
    (6pt, height)
  ))
  place(top + right, path(
    (-6pt, 0pt),
    (0pt, 0pt),
    (0pt, height),
    (-6pt, height)
  ))
})