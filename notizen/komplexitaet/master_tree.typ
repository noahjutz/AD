#import "@preview/cetz:0.2.2"

#let a = 2
#let max_depth = 4

#let rec_tree(root, depth: 0) = {
  if depth == max_depth {return root}

  let children = if depth == max_depth - 2 {
    ([...], ) * a
  } else if depth == max_depth - 1 {
    ($1$, ) * a
  } else {
    ($n/b^(#(depth+1))$, ) * a
  }
  children = children.map(c => rec_tree(c, depth: depth + 1))
  return (root, ..children)
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  set-style(content: (padding: 6pt))
  tree.tree(
    ($0$, ($1$, ($2$, ([...], $log_b n$)))),
    grow: 1.2,
    draw-edge: none
  )
  translate(x: 32pt)
  tree.tree(
    //($n$, $n/b$, $n/b$, $n dot b ^(-1)$)
    rec_tree($n$),
    spread: .35,
    grow: 1.2
  )
})