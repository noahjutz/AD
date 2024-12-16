#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#diagram(node-inset: 2pt, {
  node(
    (0deg, 0pt),
    stroke: black,
  )[0]
  for i in range(16) {
    let a = i/16*360deg
    if calc.rem(i, 2) == 0 {
      edge((0, 0), (a, 32pt), "->")
      node(
        (a, 32pt),
        stroke: black.transparentize(50%),
      )[1]
      edge((a, 32pt), (a+(360deg/32), 64pt), "->")
      edge((a, 32pt), (a -(360deg/32), 64pt), "->")
    }
    node(
      (a+(360deg/32), 64pt),
      stroke: black.transparentize(75%),
    )[2]
  }
})
