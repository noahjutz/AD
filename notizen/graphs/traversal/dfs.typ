#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#diagram(node-inset: 2pt, {
  node(
    (0deg, 0pt),
    stroke: black.transparentize(95%),
    circle(radius: 4pt, stroke: none)
  )
  for i in range(8) {
    let a = i/8*360deg
    edge((0, 0), (a, 32pt), "->")
    node(
      (a, 32pt),
      stroke: black.transparentize(100%/8*i),
    )[#i]
    edge((a, 32pt), (a, 64pt), "->")
    node(
      (a, 64pt),
      stroke: black.transparentize(100%/8*i),
    )[#i]
  }
})

