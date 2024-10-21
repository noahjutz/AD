#import "/config.typ": theme
#import "/components/num_row.typ": single_num_row
#import "/components/lefttree.typ": lefttree, draw_node, polygon_around, poly_fill, box_around
#import "@preview/cetz:0.3.0"

#let heap(
  nums,
  complete: (),
  swaps: (),
  annotations: (),
) = {
  set align(center)
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
      if complete == range(nums.len()) {
        box_around(..complete, rect.with(
          stroke: none,
          fill: theme.success_light,
          radius: 14pt,
        ))
      }
      else if complete.len() >= 2 {
        polygon_around(
          ..complete, poly_fill
        )
      }
    })

  })
  single_num_row(nums)
}