#import "/config.typ": theme

// @param l Matrix (nxn) of current weights
// @param p Matrix (nxn) of current parents
// @param w Weighted Adjacency Matrix (nxn)
// @return 3-tuple
//         1. modified l
//         2. modified p
//         3. list of indices (i, j) of modified entries
#let extend_shortest_paths(l, p, w) = {
  let n = l.len()
  let l_new = l
  let modified = ((false,)*n,)*n
  for i in range(n) {
    for j in range(n) {
      for k in range(n) {
        let current_path = l_new.at(i).at(j)
        let relaxed_path = l.at(i).at(k) + w.at(k).at(j)
        if current_path > relaxed_path {
          l_new.at(i).at(j) = relaxed_path
          p.at(i).at(j) = k + 1
          modified.at(i).at(j) = true
        }
      }
    }
  }
  return (l_new, p, modified)
}

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

// Input data
#let n = 6
#let w = (
  (0, calc.inf, calc.inf, calc.inf, -1, calc.inf),
  (1, 0, calc.inf, 2, calc.inf, calc.inf),
  (calc.inf, 2, 0, calc.inf, calc.inf, -8),
  (-4, calc.inf, calc.inf, 0, 3, calc.inf),
  (calc.inf, 7, calc.inf, calc.inf, 0, calc.inf),
  (calc.inf, 5, 10, calc.inf, calc.inf, 0),
)
#let l = ((calc.inf,) * n,) * n
#for i in range(n) { l.at(i).at(i) = 0 }
#let p = ((none,)*n,)*n
#let m = ((false,)*n,)*n

// Figures
#let f = ()
#for i in range(n) {
  f.push(mat(l, hl: m))
  f.push(mat(p, hl: m))
  f.push($L^((#i))$)
  f.push($P^((#i))$)
  (l, p, m) = extend_shortest_paths(l, p, w)
}

#grid(
  columns: 2* (1fr,),
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: center,
  ..f
)