#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#let counting_sort = csv("counting_sort.csv")

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (.75, .5),
    x-label: $n$,
    x-tick-step: 2,
    y-label: "Operationen",
    y-tick-step: 2,
    y-mode: "log",
    y-base: 2,
    y-format: y => $2^#calc.log(y, base: 2)$,
    y2-label: [$t$ [s]],
    y2-tick-step: 2,
    {
      plot.add(
        counting_sort.map(((n, op, t)) => (int(n), int(op))),
        line: "spline"
      )
      plot.add(
        counting_sort.map(((n, op, t)) => (int(n), float(t))),
        axes: ("x", "y2"),
      )
    }
  )
})