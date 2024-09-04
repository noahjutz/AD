#import "@preview/cetz:0.2.2"

#let fibs(n) = {
  let r = (0, 1)
  for i in range(2, n) {
    let next = r.at(i - 1) + r.at(i - 2)
    r.push(next)
  }
  return r
}

#cetz.canvas(length: 95%, {
  import cetz.draw: *
  import cetz.plot

  let n = 12
  let data = fibs(n).enumerate()
  let phi = 1.618

  plot.plot(
    axis-style: none,
    size: (1, .5), {
    plot.add(
      domain: (0, n),
      x => calc.pow(phi, x) / calc.sqrt(5),
      style: (stroke: gray),
    )

    plot.add(
      data,
      style: (stroke: none),
      mark: "o",
      mark-size: .02,
      mark-style: (stroke: none, fill: black)
    )
    plot.annotate({
      for (x, y) in data {
        content((x, y), anchor: "south", padding: 4pt)[#y]
      }
    })
  })
})