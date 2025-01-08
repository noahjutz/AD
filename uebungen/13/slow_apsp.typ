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

#let w = (
  (0, calc.inf, calc.inf, calc.inf, -1, calc.inf),
  (1, 0, calc.inf, 2, calc.inf, calc.inf),
  (calc.inf, 2, 0, calc.inf, calc.inf, -8),
  (-4, calc.inf, calc.inf, 0, 3, calc.inf),
  (calc.inf, 7, calc.inf, calc.inf, 0, calc.inf),
  (calc.inf, 5, 10, calc.inf, calc.inf, 0),
)

#let l = ((calc.inf,) * 6,) * 6
#for i in range(6) {
  l.at(i).at(i) = 0
}
#let p = ((sym.space.quad,) * 6,) * 6

$
#math.mat(..l)
#math.mat(..p)
$

#{(l, p) = extend_shortest_paths(l, p, w)}

$
#math.mat(..l)
#math.mat(..p)
$

#{(l, p) = extend_shortest_paths(l, p, w)}

$
#math.mat(..l)
#math.mat(..p)
$