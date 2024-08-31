#import "@preview/cetz:0.2.2"

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  plot.plot(
    axis-style: none,
    size: (1, .3), {
    let psi = -0.6180339887
    let values = range(15).map(x => (x, calc.pow(psi, x)))
    plot.add(
      values,
      style: (stroke: none),
      mark: "o",
      mark-size: 4pt,
      mark-style: (stroke: none, fill: black)
    )
  })
})