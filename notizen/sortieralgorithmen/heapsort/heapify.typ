#import "components.typ": bintree, name_to_index as n2i, index_to_name as i2n, arrow, box_around, draw_node
#import "/config.typ": theme

#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree(nums.map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 0),
    spread: 1.5,
    name: "tree",
  )

  arrow(0, 3, (from, to) => {
    bezier(from, to, (1pt, 1pt), mark: (symbol: ">"))
  })

  cetz.decorations.flat-brace(
    (rel: (12pt, -16pt), to: "tree." + i2n(9)),
    (rel: (-12pt, -16pt), to: "tree." + i2n(7)),
    name: "left"
  )
  content("left.content")[Heap]
  cetz.decorations.flat-brace(
    (rel: (12pt, -16pt), to: "tree." + i2n(6)),
    (rel: (-12pt, -16pt), to: "tree." + i2n(5)),
    name: "right"
  )
  content("right.content")[Heap]

  on-layer(-1, {
    box_around(
      2, 7, 9,
      (tl, br) => rect(
        tl, br,
        radius: 4pt,
        fill: theme.success_trans,
        stroke: none
      )
    )
    box_around(
      2, 5, 6,
      (tl, br) => rect(
        tl, br,
        radius: 4pt,
        fill: theme.success_trans,
        stroke: none
      )
    )
  })
})