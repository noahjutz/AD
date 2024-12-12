#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let anchors(t, p) = {
  circle((0, 0), radius: 0)
  group(name: "t", {
    translate(x: .5 / t.len())
    for i in range(t.len()) {
      circle(
        (i / t.len(), 0),
        radius: 0,
        name: str(i)
      )
    }
  })

  group(name: "p", {
    translate(x: .5 / p.len())
    for i in range(p.len()) {
      circle(
        (i / p.len(), -128pt),
        radius: 0,
        name: str(i)
      )
    }
  })
}

#let txt(t) = [
  #block(spacing: 4pt)[
    #table(
      columns: t.len() * (1fr,),
      stroke: none,
      inset: 0pt,
      align: center,
      ..t.clusters()
    )
  ]
]