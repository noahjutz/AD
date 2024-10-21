#import "/components/num_row.typ": single_num_row
#import "/components/lefttree.typ": lefttree, draw_node, polygon_around, poly_fill
#import "@preview/cetz:0.3.0"

#let heap(
  nums,
  complete: (),
  swaps: (),
  annotations: (),
) = {
  align(
    center,
    cetz.canvas({
      import cetz.tree: tree
      import cetz.draw: *

      tree(
        lefttree(
          nums.map(n => str(n)),
        ),
        spread: 1.5,
        draw-node: draw_node,
        name: "tree"
      )

      on-layer(-1, {
        if complete.len() >= 2 {
          polygon_around(
            ..complete, poly_fill.with()
          )
        }
      })

    })
  )
  single_num_row(nums)
}