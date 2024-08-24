#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  rect((0, 0), (1, 1), stroke: none)
  plot.plot(
    axis-style: none,
    y-max: 25,
    y-min: 0, {
      plot.add(
        domain: (0, 15),
        style: (stroke: black),
        a => a + 2 * calc.sin(a)
      )
      plot.add(
        domain: (0, 15),
        style: (stroke: gray),
        a => a
      )
      plot.add(
        domain: (0, 15),
        style: (stroke: theme.primary),
        a => 1.3 * a
      )
      plot.annotate({
        line((14, 14), (14, 18.2), mark: (symbol: "straight"), name: "diff")
        content("diff.start", anchor: "north")[$c$]
      })
  })
})