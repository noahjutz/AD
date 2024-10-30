#import "/config.typ": theme
#import "@preview/cetz:0.3.1"
#import "@preview/fontawesome:0.5.0"

#let n = 4

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  line(
    (0, 0), (1, 0),
    name: "rod",
    stroke: 4pt
  )

  for i in range(n) {
    let width = (i+1)/n
    line(
      (rel: (0, -(16pt + 24pt * i)), to: "rod.start"),
      (rel: (width, 0)),
      name: "subrod",
      stroke: 4pt
    )

    content(
      "subrod.mid",
      anchor: "north",
      padding: (top: 4pt)
    )[$p_#(i+1)$]

    line(
      (
        (rel: (0, 16pt), to: "rod.start"),
        "-|",
        "subrod.end"
      ),
      "subrod.end",
      stroke: (dash: "dashed", paint: theme.fg_light),
      name: "cut"
    )

    content("cut.start", angle: -90deg)[
      #fontawesome.fa-cut()
    ]
  }
})