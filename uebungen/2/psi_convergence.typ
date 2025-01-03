#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    axis-style: "school-book",
    x-tick-step: none,
    x-ticks: (1,),
    y-tick-step: none,
    y-ticks: (-1, 1,),
    y-min: -1,
    y-max: 1,
    x-min: -1,
    x-label: $n$,
    y-label: $psi^n$,
    size: (.8, .3),
    {
      let n = 10
      let phi = 1.6180339887
      let psi = -0.6180339887

      plot.add(
        domain: (0, n),
        x => calc.pow(1/phi, x),
        style: (stroke: (paint: gray, dash: "dashed")),
      )
      plot.add(
        domain: (0, n),
        x => -calc.pow(1/phi, x),
        style: (stroke: (paint: gray, dash: "dashed")),
      )

      let values = range(n).map(x => (x, calc.pow(psi, x)))
      plot.add(
        values,
        style: (stroke: none),
        mark: "o",
        mark-size: 6pt,
        mark-style: (stroke: none, fill: black)
      )
    })
})