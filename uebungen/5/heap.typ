#import "/components/num_row.typ": single_num_row
#import "/components/lefttree.typ": lefttree, draw_node
#import "@preview/cetz:0.3.0"

#let _heap(nums) = cetz.canvas({
  import cetz.tree: tree

  tree(
    lefttree(
      nums.map(n => str(n)),
    ),
    spread: 1.5,
    draw-node: draw_node
  )
})

#let _arr(nums) = single_num_row(nums)

#let heap(nums) = {
  align(center,
    _heap(nums)
  )
  _arr(nums)
}