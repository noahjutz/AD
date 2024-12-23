#import "/components/lefttree.typ": lefttree, draw_node, polygon_around, poly_fill, note
#import "/components/num_row.typ": single_num_row
#import "@preview/cetz:0.3.1"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#single_num_row(
  (34, 45, 12, 34, 23, 18, 38, 17, 43, 7),
  hl_success: (5, 6, 7, 8, 9)
)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(nums.map(n => str(n))),
    draw-node: draw_node,
    spread: 1.2,
    name: "tree"
  )

  on-layer(-1, {
    polygon_around(
      5, 6,
      poly_fill
    )
    polygon_around(
      7, 8, 9,
      poly_fill
    )
  })

  note(0, ang: 90deg)[`f`]
  note(nums.len()-1, ang: -90deg)[`l`]
})