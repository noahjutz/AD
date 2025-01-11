#import "components.typ"

#let extend_shortest_paths(d, p, k) = {
  let n = d.len()
  let d_new = d
  let p_new = p
  let modified = ((false,)*n,)*n
  for i in range(n) {
    for j in range(n) {
      let relaxed_path = d.at(i).at(k) + d.at(k).at(j)
      if d.at(i).at(j) > relaxed_path {
        d_new.at(i).at(j) = relaxed_path
        p_new.at(i).at(j) = p.at(k).at(j)
        modified.at(i).at(j) = true
      }
    }
  }
  return (d_new, p_new, modified)
}

// Input data
#let n = components.n
#let distances = components.adjacency_matrix
#let predecessors = components.adjacency_matrix.enumerate().map(((i, row)) => row.enumerate().map(((j, x)) => {
  if i != j and x < calc.inf {i+1}
}))
#let highlight = ((false,)*n,)*n

#let figures = ()
#{figures += (
  scale(65%, components.mat(distances, hl: highlight), reflow: true),
  scale(65%, components.mat(predecessors, hl: highlight), reflow: true),
  components.graph(components.adjacency_matrix, distances, predecessors, 0),
  $D^((0))$,
  $Pi^((0))$,
  []
)}

#for k in range(1, n+1) {
  (distances, predecessors, highlight) = extend_shortest_paths(
    distances, predecessors, k - 1
  )

  figures += (
    scale(65%, components.mat(distances, hl: highlight), reflow: true),
    scale(65%, components.mat(predecessors, hl: highlight), reflow: true),
    components.graph(components.adjacency_matrix, distances, predecessors, k, hl: highlight),
    $D^((#k))$,
    $Pi^((#k))$,
    []
  )
}

#grid(
  columns: (1fr,)*3,
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: center,
  ..figures
)