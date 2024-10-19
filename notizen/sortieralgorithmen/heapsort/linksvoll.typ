#import "@preview/cetz:0.3.0"
#import "/config.typ": theme
#import "/components/lefttree.typ": lefttree

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(range(6).map(i => $a_#i$)),
    draw-node: (node, ..) => {
      content(
        (),
        frame: "circle",
        padding: 7pt,
        place(
          center + horizon,
          dy: -2pt,
          node.content
        )
      )
    },
    draw-edge: (from, to, ..) => {
      if from == "g0" and to == "g0-0" {
        line(
          from, to,
          stroke: theme.primary + 2pt,
          mark: (end: ">")
        )
      } else if from == "g0" and to == "g0-1" {
        line(
          from, to,
          stroke: theme.secondary + 2pt,
          mark: (end: ">")
        )
      } else if from == "g0-1" and to == "g0-1-0" {
        line(
          from, to,
          stroke: theme.tertiary + 2pt,
          mark: (start: ">")
        )
      } else {
        line(from, to)
      }
    },
    grow: 1.3
  )
})