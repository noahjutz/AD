#import "components.typ": bintree

#import "@preview/cetz:0.3.0"

#cetz.canvas({
  import cetz.tree: tree

  tree(
    bintree(range(10).map(i => str(i)))
  )
})