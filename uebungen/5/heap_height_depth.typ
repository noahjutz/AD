#import "/components/lefttree.typ": lefttree, draw_node, index_to_name as i2n
#import "@preview/cetz:0.3.1"

#let n = 7

#let leftmost(n) = {
  return calc.pow(2, int(calc.log(n, base: 2))) - 1
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(([],)*n),
    draw-node: draw_node.with(radius: 4pt),
    name: "tree"
  )

  line(
    (rel: (-16pt, 0), to: i2n(leftmost(n))),
    ((), "|-", i2n(0)),
    mark: (
      start: "|",
      end: ">"
    ),
    name: "h"
  )
  content("h.end", anchor: "south", padding: 2pt)[$h$]

  line(
    (rel: (16pt, 0), to: i2n(n - 1)),
    ((), "|-", i2n(0)),
    mark: (
      start: ">",
      end: "|"
    ),
    name: "t"
  )
  content("t.end", anchor: "south", padding: 2pt)[$t$]
})