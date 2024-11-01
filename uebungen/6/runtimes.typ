#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#let counting_sort = csv("counting_sort.csv")
#let heap_sort = csv("heap_sort.csv")
#let map_sort = csv("map_sort.csv")

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (.75, .5),
    x-label: $n$,
    x-tick-step: 2,
    x-format: x => $2^#x$,
    y-label: "Operationen",
    y-tick-step: 2,
    y-mode: "log",
    y-base: 2,
    y-format: y => $2^#calc.log(y, base: 2)$,
    y2-label: [$t$ [s]],
    y2-tick-step: 10,
    {
      for data in (counting_sort, heap_sort, map_sort) {
        plot.add(
          data.map(((n, op, t)) => (int(n), int(op))),
          line: "spline"
        )
        plot.add(
          data.map(((n, op, t)) => (int(n), float(t))),
          axes: ("x", "y2"),
        )
      }
    }
  )
})