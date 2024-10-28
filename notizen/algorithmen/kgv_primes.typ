#import "@preview/cetz:0.3.1": canvas, draw

#let arrow = (d, c) => canvas(length: 24pt, {
  import draw: *
  if d == "down" {
    set-style(mark: (end: ">"))
  } else {
    set-style(mark: (start: ">"))
  }
  line((), (0, -2), name: "arrow")
  content("arrow.mid", anchor: "west", padding: 4pt, c)
})

#let down = c => arrow("down", c)
#let up = c => arrow("up", c)

#table(columns: 9, inset: 4pt,
  stroke: none,
  $3528$, $=$, $2^3$, $dot$, $3^2$, $dot$, $5^0$, $dot$, $7^2$,
  [], [], down[$dot 2$], [], up[$dot 3$], [], up[$dot 5$], [], down[$dot 7$],
  $3780$, $=$, $2^2$, $dot$, $3^3$, $dot$, $5^1$, $dot$, $7^1$
)

