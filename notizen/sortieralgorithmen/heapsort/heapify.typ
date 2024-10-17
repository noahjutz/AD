#import "components.typ": bintree, name_to_index as n2i, index_to_name as i2n
#import "/config.typ": theme

#import "@preview/cetz:0.3.0"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  let arrow(from, to) = {
    from = "tree." + i2n(from)
    to = "tree." + i2n(to)
    intersections("i", {
      hide(circle(from, radius: 10pt))
      hide(circle(to, radius: 10pt))
      hide(line(from, to))
    })
    line("i.0", "i.1", mark: (end: ">"))
  }

  tree(
    bintree(nums.map(n => str(n))),
    draw-node: (node, ..) => {
      let index = n2i(node.name)
      content(
        (),
        frame: "circle",
        fill: if index == 0 {theme.primary_light},
        padding: 7pt,
        place(center + horizon, node.content),
      )
    },
    name: "tree",
  )

  arrow(0, 4)
})