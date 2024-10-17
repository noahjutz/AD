#import "@preview/cetz:0.3.0"
#import "/config.typ": theme

#let binary_tree(n, i: 0) = {
  let node = ($a_#i$,)
  if n >= 2 * i + 1 {
    node.push(binary_tree(n, i: 2*i+1))
  }
  if n >= 2*i+2 {
    node.push(binary_tree(n, i: 2*i+2))
  }
  return node
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    binary_tree(5),
    draw-node: (node, ..) => {
      content(
        (),
        frame: "circle",
        padding: 7pt,
        place(
          center + horizon,
          dy: -1pt,
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