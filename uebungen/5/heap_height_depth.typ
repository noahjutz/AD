#import "/components/lefttree.typ": lefttree, draw_node, index_to_name as i2n
#import "@preview/cetz:0.3.1"

#let n = 7

#let layers(n) = {
  return int(calc.log(n, base: 2)) + 1
}

#let leftmost(n, layer: layers(n) - 1) = {
  return calc.pow(2, layer) - 1
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(([],)*n),
    draw-node: draw_node.with(radius: 4pt),
    name: "tree"
  )

  // TODO mark each layer and add arrows for doubling and halving
  for layer in range(layers(n)) {
    line(
      i2n(leftmost(n, layer: layer)),
      (0, 0)
    )
  }

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