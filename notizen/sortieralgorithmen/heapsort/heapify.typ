#import "components.typ": bintree, name_to_index as n2i, index_to_name as i2n
#import "/config.typ": theme

#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  let arrow(from, to, fun) = {
    from = "tree." + i2n(from)
    to = "tree." + i2n(to)
    intersections("i", {
      hide(circle(from, radius: 10pt))
      hide(circle(to, radius: 10pt))
      hide(fun(from, to))
    })
    fun("i.0", "i.1")
  }

  let box_around(top, bl, br, fun) = {
    top = "tree." + i2n(top)
    bl = "tree." + i2n(bl)
    br = "tree." + i2n(br)

    fun(
      (rel: (-14pt, 14pt), to: (bl, "|-", top)),
      (rel: (14pt, -14pt), to: br)
    )
  }

  tree(
    bintree(nums.map(n => str(n))),
    draw-node: (node, ..) => {
      let index = n2i(node.name)
      content(
        (),
        frame: "circle",
        fill: if index == 0 {theme.primary_light} else {white},
        padding: 7pt,
        place(center + horizon, node.content),
      )
    },
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