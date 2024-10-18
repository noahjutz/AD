#import "components.typ": bintree, connect, box_around, draw_node, bent_line
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

  connect(
    0, 3,
    bent_line.with(bend: -.5, mark: (end: ">"), stroke: theme.fg_light)
  )
  connect(
    1, 3,
    bent_line.with(bend: .5, mark: (start: ">"), stroke: theme.fg_light)
  )
  connect(
    0, 1,
    bent_line.with(bend: .5, mark: (start: ">"), stroke: theme.fg_light)
  )

  on-layer(-1, {
    box_around(
      2, 7, 9,
      (tl, br) => rect(
        tl, br,
        radius: 4pt,
        fill: theme.success_trans,
        stroke: none,
        name: "heap_l"
      )
    )
    box_around(
      2, 5, 6,
      (tl, br) => rect(
        tl, br,
        radius: 4pt,
        fill: theme.success_trans,
        stroke: none,
        name: "heap_r"
      )
    )
  })

  let d(a) = (rel: (0, -4pt), to: a)
  cetz.decorations.flat-brace(
    d("heap_l.south-east"),
    d("heap_l.south-west"),
    name: "left"
  )
  content("left.content")[Heap]
  cetz.decorations.flat-brace(
    d("heap_r.south-east"),
    d("heap_r.south-west"),
    name: "right"
  )
  content("right.content")[Heap]
})