#import "/config.typ": theme
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#let counting_sort = csv("counting_sort.csv")
#let heap_sort = csv("heap_sort.csv")
#let map_sort = csv("map_sort.csv")

#cetz.canvas(length: 24pt, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (7, 5),
    legend: (0, 5.5),
    legend-anchor: "south-west",
    x-label: $n$,
    x-tick-step: 2,
    x-grid: true,
    x-format: x => $2^#x$,
    y-label: "Operationen",
    y-tick-step: 2,
    y-mode: "log",
    y-base: 2,
    y-format: y => $2^#calc.log(y, base: 2)$,
    y2-label: [$t$ [s]],
    y2-tick-step: 10,
    {
      for (name, fill, data) in (
        ("Counting Sort", theme.primary, counting_sort),
        ("Heap Sort", theme.secondary, heap_sort),
        ("Map Sort", theme.tertiary, map_sort)
      ) {
        plot.add(
          data.map(((n, op, t)) => (int(n), int(op))),
          line: "spline",
          style: (stroke: (dash: "dashed", paint: fill, thickness: 2pt)),
          label: name + " Operationen"
        )
        plot.add(
          data.map(((n, op, t)) => (int(n), float(t))),
          line: "spline",
          axes: ("x", "y2"),
          style: (stroke: 2pt + fill),
          label: name + " Laufzeit"
        )
      }
    }
  )
})