#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#let m = 4
#let n = 2
#let p = 5

#let i = 1
#let j = 1

#cetz.canvas(length: 20pt, {
  import cetz.draw: *

  stroke(none)
  rect(
    (0, 0),
    (rel: (n, m)),
    name: "a"
  )
  rect(
    (n + 1, m + 1),
    (rel: (p, n)),
    name: "b"
  )
  rect(
    (n + 1, 0),
    (rel: (p, m)),
    name: "c"
  )

  for elem in ("a", "b", "c") {
    group({
      stroke(black)
      line(
        (rel: (.2, .2), to: elem + ".north-west"),
        (rel: (-.2, .2), to: elem + ".north-west"),
        (rel: (-.2, -.2), to: elem + ".south-west"),
        (rel: (.2, -.2), to: elem + ".south-west")
      )
      line(
        (rel: (-.2, .2), to: elem + ".north-east"),
        (rel: (.2, .2), to: elem + ".north-east"),
        (rel: (.2, -.2), to: elem + ".south-east"),
        (rel: (-.2, -.2), to: elem + ".south-east")
      )
    })

    stroke(gray)
    grid(elem + ".north-west", elem + ".south-east")
  }

  group({
    stroke(none)
    fill(theme.primary_trans)
    rect(
      (rel: (0, -i), to: "a.north-west"),
      (rel: (n, -1)),
    )
    rect(
      (rel: (j, 0), to: "b.north-west"),
      (rel: (1, -n)),
    )
    rect(
      (rel: (j, -i), to: "c.north-west"),
      (rel: (1, -1)),
    )
  })

  group({
    stroke(black)
    cetz.decorations.flat-brace(
      (rel: (.2, -.6), to: "a.south-east"),
      (rel: (-.2, -.6), to: "a.south-west"),
      name: "brace_n1"
    )
    content("brace_n1.content")[$n$]
    cetz.decorations.flat-brace(
      (rel: (.6, .2), to: "b.north-east"),
      (rel: (.6, -.2), to: "b.south-east"),
      name: "brace_n2"
    )
    content("brace_n2.content")[$n$]
    cetz.decorations.flat-brace(
      (rel: (.6, .2), to: "c.north-east"),
      (rel: (.6, -.2), to: "c.south-east"),
      name: "brace_m"
    )
    content("brace_m.content")[$m$]
    cetz.decorations.flat-brace(
      (rel: (.2, -.6), to: "c.south-east"),
      (rel: (-.2, -.6), to: "c.south-west"),
      name: "brace_p"
    )
    content("brace_p.content")[$p$]

    content((rel: (0, .6), to: "a.north"))[$A$]
    content((rel: (-.6, 0), to: "b.west"))[$B$]
    content((rel: (j + .5, -i - .5), to: "c.north-west"))[$c_(i j)$]

    line(
      (rel: (-.6, -i - .5), to: "a.north-west"),
      (rel: (-.6, 0)),
      mark: (start: "straight"),
      name: "i"
    )
    content((rel: (-.2, 0), to: "i.end"))[$i$]
    line(
      (rel: (j + .5, .6), to: "b.north-west"),
      (rel: (0, .6)),
      mark: (start: "straight"),
      name: "j"
    )
    content((rel: (0, .2), to: "j.end"), anchor: "south")[$j$]
  })
})