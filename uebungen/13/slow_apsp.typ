#import "components.typ"

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

// Input data
#let n = components.n
#let adjacency_matrix = components.adjacency_matrix
#let distances = {
  let l = ((calc.inf,) * n,) * n
  for i in range(n) { l.at(i).at(i) = 0 }
  l
}
#let predecessors = ((none,)*n,)*n
#let highlight = ((false,)*n,)*n

#let figures = ()
#for i in range(n) {
  figures.push(components.mat(distances, hl: highlight))
  figures.push(components.mat(predecessors, hl: highlight))
  figures.push($L^((#i))$)
  figures.push($P^((#i))$)
  (distances, predecessors, highlight) = extend_shortest_paths(distances, predecessors, adjacency_matrix)
}

#grid(
  columns: 2* (1fr,),
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: center,
  ..figures
)