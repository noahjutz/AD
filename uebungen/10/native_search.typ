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


#block(below: 2pt)[
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

  for i in range(t.len()) {
    for j in range(p.len()) {
      let character_matches = t.at(i+j) == p.at(j)
      line(
        "t." + str(i+j),
        "p." + str(j),
        stroke: if character_matches {theme.success} else {theme.fg_medium},
        mark: (end: "straight")
      )
      if not character_matches {
        break
      }
    }
  }
})

#block(above: 2pt)[
  #table(
    columns: p.len() * (1fr,),
    stroke: none,
    inset: 0pt,
    align: center,
    ..p.clusters()
  )
]