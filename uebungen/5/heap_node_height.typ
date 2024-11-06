#import "/config.typ": theme
#import "/components/lefttree.typ": lefttree, draw_node, note
#import "@preview/cetz:0.3.1"

#let n = 10

#let leaf_count(n) = {
  return calc.ceil(n/2)
}

#let leaves(n) = {
  return range(n - leaf_count(n), n)
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  let h0 = leaves(n)
  let h1 = leaves(n - leaf_count(n))
  let h2 = leaves(n - leaf_count(n) - leaf_count(n - leaf_count(n)))

  tree(
    lefttree(([],)*n),
    draw-node: draw_node.with(
      radius: 4pt,
      hl_primary: i => i in h0,
      hl_secondary: i => i in h1,
      hl_tertiary: i => i in h2
    ),
    name: "tree"
  )

  note(1, ang: 90deg)[$h=2$]
  note(2, ang: -90deg)[$h=1$]
  note(5, ang: -135deg)[$h=0$]
})