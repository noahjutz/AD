#import "@preview/cetz:0.3.0"

#let binary_tree(n, i: 0) = {
  let node = ($a_#i$,)
  if n >= 2 * i + 1 {
    node.push(binary_tree(n, i: 2*i+1))
  }
  if n >= 2*i+2 {
    node.push(binary_tree(n, i: 2*i+2))
  }
  return node
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    binary_tree(5)
  )
})