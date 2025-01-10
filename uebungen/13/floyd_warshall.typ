#import "components.typ"

// Input data
#let n = components.n
#let distances = components.adjacency_matrix
#let parents = components.adjacency_matrix.enumerate().map(((i, row)) => row.enumerate().map(((j, x)) => {
  if i != j and x < calc.inf {i}
}))
#let highlight = ((false,)*n,)*n

#let figures = ()
#for i in range(n) {
  figures += (
    components.mat(distances, hl: highlight),
    components.mat(parents, hl: highlight),
    $D^((#i))$,
    $Pi^((#i))$
  )

  // (distances, parents, highlight) = extend_shortest_paths(
  //   distances, parents
  // )
}

#grid(
  columns: 2,
  column-gutter: 12pt,
  row-gutter: 12pt,
  align: center,
  ..figures
)