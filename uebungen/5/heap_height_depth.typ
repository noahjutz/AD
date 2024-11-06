#import "/config.typ": theme
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

  line(
    (rel: (-48pt, 0), to: i2n(leftmost(n))),
    ((), "|-", i2n(0)),
    mark: (
      start: "|",
      end: ">"
    ),
    name: "h"
  )
  content("h.end", anchor: "south", padding: 2pt)[$h$]

  line(
    (rel: (48pt, 0), to: i2n(n - 1)),
    ((), "|-", i2n(0)),
    mark: (
      start: ">",
      end: "|"
    ),
    name: "t"
  )
  content("t.end", anchor: "south", padding: 2pt)[$t$]

  on-layer(-1, {
    for layer in range(layers(n)) {
      let y = i2n(leftmost(n, layer: layer))
      let l = (rel: (-24pt, 0), to: i2n(leftmost(n)))
      let r = (rel: (24pt, 0), to: i2n(n - 1))
      let name = "l" + str(layer)
      line(
        (y, "-|", l),
        (y, "-|", r),
        stroke: (
          thickness: 4pt,
          cap: "round",
          paint: theme.primary_light
        ),
        name: name
      )

      content(
        name+".start",
        anchor: "east",
        padding: (right: 4pt),
        str(layers(n) - layer - 1)
      )
      content(
        name+".end",
        anchor: "west",
        padding: (left: 4pt),
        str(layer)
      )

      if layer > 0 {
        let prev = "l" + str(layer - 1)
        line(
          (prev+".start", 90%, prev+".end"),
          (name+".start", 90%, name+".end"),
          mark: (end: ">"),
          name: "arrow"
        )
        content(
          "arrow.mid",
          anchor: "west",
          padding: (left: 4pt)
        )[$dot 2$]
        line(
          (name+".start", 10%, name+".end"),
          (prev+".start", 10%, prev+".end"),
          mark: (end: ">"),
          name: "arrow"
        )
        content(
          "arrow.mid",
          anchor: "east",
          padding: (right: 4pt)
        )[$div 2$]
      }
    }
  })

})