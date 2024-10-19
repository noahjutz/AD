#import "/components/lefttree.typ": lefttree, draw_node, number, note
#import "@preview/cetz:0.3.0"

#let nums = (45, 43, 38, 34, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(nums.map(n => str(n))),
    spread: 1.2,
    draw-node: draw_node,
    name: "tree"
  )

  note(4, ang: -135deg)[$ floor(n/2)-1 $]
  note(0, ang: -90deg)[$h=3$]
  note(2, ang: -90deg)[$h=2$]
  note(6, ang: -90deg)[$h=1$]
  let half = calc.div-euclid(nums.len(), 2)
  for i in range(nums.len()).slice(0, half) {
    number(i, str(half - i - 1))
  }
})