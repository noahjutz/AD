#import "/config.typ": theme
#import "@preview/oxifmt:0.2.1": strfmt
#import "@preview/cetz:0.3.1"

#set text(font: "Noto Sans Mono")

#let t = "ALGORITHMEN UND DATENSTRUKTUREN"
#let p = "DATEN"

#let substrings(p) = {
  ((p,)*p.len())
    .enumerate()
    .map(((i, s)) => s.slice(0, i+1))
    .rev()
}


#block(below: 0pt)[
  #table(
    columns: t.len() * (1fr,),
    stroke: none,
    inset: 0pt,
    align: center,
    ..t.clusters()
  )
]

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  circle((0, 0), radius: 0)
  group({
    translate(x: .5 / t.len())
    for i in range(t.clusters().len()) {
      circle(
        (i / t.len(), 0),
        radius: 0,
        name: "t_" + str(i)
      )
    }
  })

  group({
    translate(x: .5 / p.len())
    for i in range(p.len()) {
      circle(
        (i / p.len(), -32pt),
        radius: 0,
        name: "p_" + str(i)
      )
    }
  })
})

#block(above: 0pt)[
  #table(
    columns: p.len() * (1fr,),
    stroke: none,
    inset: 0pt,
    align: center,
    ..p.clusters()
  )
]