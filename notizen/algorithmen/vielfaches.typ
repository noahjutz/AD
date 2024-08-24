#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#cetz.canvas(length: 5%, {
  import cetz.draw: *

  let g = rgb(0, 0, 0, 20%)
  let r = theme.primary

  set-viewport((0, 0), (20, 20), bounds: (12, 20))
  
  set-style(stroke: (thickness: 1, paint: g))
  line((0, 0), (4, 0), name: "a")
  line((), (rel: (4, 0)), stroke: (paint: r), name: "a1")
  line((), (rel: (4, 0)), stroke: (paint: r))
  line((0, -3), (6, -3), name: "b")
  line((), (rel: (6, 0)), stroke: (paint: r), name: "b1")

  set-style(stroke: (thickness: 1pt, paint: black, dash: "dashed"))
  line((4, .5), (4, -.5))
  line((8, .5), (8, -.5))
  line((6, -3.5), (6, -2.5))

  content("a.mid", anchor: "south", padding: (bottom: 1))[$a = 4$]
  content("b.mid", anchor: "south", padding: (bottom: 1))[$b = 6$]
  content("a1.end", anchor: "south", padding: (bottom: 1))[$k_1 = 3$]
  content("b1.mid", anchor: "south", padding: (bottom: 1))[$k_2 = 2$]

  set-style(stroke: (dash: none))
  cetz.decorations.flat-brace(
    (12, -4), (0, -4), name: "brace"
  )
  move-to("brace.content")
  content((rel: (0, -4pt)))[$x = 12$]
})