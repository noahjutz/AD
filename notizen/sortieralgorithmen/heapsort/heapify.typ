#import "components.typ": bintree

#import "@preview/cetz:0.3.0"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree(nums.map(n => str(n))),
    draw-node: (node, ..) => {
      content(
        (),
        frame: "circle",
        padding: 7pt,
        place(center + horizon, node.content),
      )
    }
  )
})