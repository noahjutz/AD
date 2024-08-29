#import "@preview/cetz:0.2.2"

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  set-viewport((0, 0), (1, .3))

  plot.plot(axis-style: none, {
    plot.add(
      domain: (0, 10), x => 2/calc.pow(2, x),
    )
    plot.add-hline(.5)
    plot.annotate({
      content((2, .5), anchor: "north", padding: 4pt)[$n_0$]

      content((10, .5), anchor: "south-east", padding: 4pt)[$g(n) in O(1)$]

      content((10, 0), anchor: "north-east", padding: 4pt)[$T^"AC" (n)$]
    })
  })
})