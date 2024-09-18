#import "@preview/cetz:0.2.2"

#let n = 5
#let i1 = 0
#let i2 = 3
#let j1 = 1
#let j2 = 3

#cetz.canvas(length: 100%, {
  import cetz.draw: *

  group(name: "matrix", {
    set-viewport((32pt, -32pt), (1, -1))
    grid((0, 0), (1, 1), step: 1 / n)
    rect(
      (j1/n, i1/n),
      (j2/n, i2/n),
      fill: rgb(255, 0, 0, 25%)
    )
  })

  line(
    "matrix.north-west",
    "matrix.south-west",
    stroke: none,
    name: "ledge"
  )
  line(
    "matrix.north-west",
    "matrix.north-east",
    stroke: none,
    name: "tedge"
  )

  group({
    let frac(index) = 100% * (index/n) + 100% * (1/(n*2))

    for (label, index) in (
      ($i_1$, i1),
      ($i_2$, i2)
    ) {
      content(
        ((0, 0), "|-", (name: "ledge", anchor: frac(index))),
        anchor: "west",
        padding: (right: 4pt),
        name: "label",
        label
      )
      line(
        "label.east",
        ("label.east", "-|", "matrix.west"),
        mark: (end: "straight")
      )
    }
    for (label, index) in (
      ($j_1$, j1),
      ($j_2$, j2)
    ) {
      content(
        ((0, 0), "-|", (name: "tedge", anchor: frac(index))),
        anchor: "north",
        padding: (bottom: 4pt),
        name: "label",
        label
      )
      line(
        "label.south",
        ("label.south", "|-", "matrix.north"),
        mark: (end: "straight")
      )
    }
  })
})