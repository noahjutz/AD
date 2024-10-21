#import "/components/num_row.typ": single_num_row
#import "/components/lefttree.typ": lefttree, draw_node
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

      tree(
        lefttree(
          nums.map(n => str(n)),
        ),
        spread: 1.5,
        draw-node: draw_node
      )
    })
  )
  single_num_row(nums)
}