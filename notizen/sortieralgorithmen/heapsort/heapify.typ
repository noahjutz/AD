#import "/components/lefttree.typ": lefttree, connect, box_around, draw_node, bent_line, polygon_around
#import "/components/num_row.typ": single_num_row
#import "/config.typ": theme

#import "@preview/cetz:0.3.1"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#single_num_row(
  (34, 45, 38, 43, 23, 18, 12, 17, 34, 7),
  hl_primary: 0,
  hl_success: range(nums.len()).slice(1)
)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(nums.map(n => str(n))),
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
      1, 3, 4, 7, 8, 9,
      rect.with(fill: theme.success_light, stroke: none, radius: 14pt)
    )
    box_around(
      2, 5, 6,
      rect.with(fill: theme.success_light, stroke: none, radius: 14pt)
    )
  })

  hide(
    box_around(
      1, 3, 4, 7, 8, 9,
      (tl, br) => {
        rect(tl, br, name: "heap_l")
      }
    )
  )
  hide(
    box_around(
      2, 5, 6,
      (tl, br) => {
        rect(tl, br, name: "heap_r")
      }
    )
  )
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