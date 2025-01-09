#import "/config.typ": theme

// @param l Matrix (nxn) of current weights
// @param p Matrix (nxn) of current parents
// @param w Weighted Adjacency Matrix (nxn)
// @return 2-tuple of modified l and p
#let extend_shortest_paths(l, p, w) = {
  let n = l.len()
  let ll = l
  for i in range(n) {
    for j in range(n) {
      for k in range(n) {
        let current_path = ll.at(i).at(j)
        let relaxed_path = l.at(i).at(k) + w.at(k).at(j)
        if current_path > relaxed_path {
          ll.at(i).at(j) = relaxed_path
          p.at(i).at(j) = k + 1
        }
      }
    }
  }
  return (ll, p)
}

#let mat(m) = context layout(((width, height)) => {
  set block(breakable: false)
  let t = table(
    columns: m.len() * (1fr,),
    align: center,
    stroke: theme.fg_light,
    ..m.flatten().map(i => $#i$)
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
#let p = ((none,) * n,) * n

// Figures
#let f = ()
#for i in range(n) {
  f.push(l)
  f.push(p)
  (l, p) = extend_shortest_paths(l, p, w)
}

#grid(
  columns: 2* (1fr,),
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: center,
  $L^((m))$, $P^((m))$,
  ..f.map(m => mat(m))
)