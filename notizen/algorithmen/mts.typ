#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#set block(spacing: 4pt)
#show table: set text(size: 9pt, font: "Noto Sans Mono")

#let nums = (-13, 25, 34, 12, -3, 7, -87, 28, -77, 11)

#cetz.canvas(length: 10%, {
  import cetz.draw: *
  set-style(content: (padding: (bottom: 4pt)))
  set-style(mark: (end: ">"))
  circle((), radius: 0)
  line((1.5, .8), (1.5, 0), name: "i")
  line((5.5, .8), (5.5, 0), name: "j")
  content("i.start", anchor: "south")[$i=1$]
  content("j.start", anchor: "south")[$j=5$]
})

#table(
  columns: (1fr,) * 10,
  align: center,
  fill: (x, y) => if 1 <= x and x <= 5 {theme.primary_light},
  ..nums.map(i => [#i])
)

#cetz.canvas(length: 10%, {
  import cetz.draw: *
  circle((), radius: 0)
  cetz.decorations.brace((6, 0), (1, 0), name: "brace")
  content("brace.content", anchor: "north")[$= 75$]
})