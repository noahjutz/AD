#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  plot.plot(
    axis-style: none, {
      plot.add(
        domain: (0, 1),
        style: (stroke: theme.primary),
        a => a
      )
  })
})