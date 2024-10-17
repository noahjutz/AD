#import "components.typ": bintree, name_to_index as n2i, index_to_name as i2n
#import "/config.typ": theme

#import "@preview/cetz:0.3.0"

#let nums = (34, 45, 38, 43, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

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

  line("tree." + i2n(0), "tree." + i2n(6))
})