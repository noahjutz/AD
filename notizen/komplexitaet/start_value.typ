#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  plot.plot(
    axis-style: none,
    name: "plot", {
    plot.add(
      domain: (0, 15),
      style: (stroke: black),
      x => x + 2 * calc.sin(x)
    )
    plot.add(
      domain: (0, 15),
      style: (stroke: theme.primary),
      x => calc.pow(x, 2) / 10
    )
    plot.add-vline(
      style: (stroke: (paint: gray, dash: "dashed")),
      9.6
    )
    plot.add-anchor(
      "n0",
      (9.6, 0)
    )
  })

  content("plot.n0", anchor: "south")[$n_0$]
})