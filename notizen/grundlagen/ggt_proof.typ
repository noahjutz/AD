#import "@preview/cetz:0.2.2"
#import "../../config.typ"

#show: doc => config.config(doc)

#cetz.canvas(length: 5%, {
  import cetz.draw: *
  let g = rgb(0, 0, 0, 10%)
  let r = rgb(255, 0, 0, 30%)
  
  set-style(stroke: (thickness: 1, paint: g))
  line((0, 0), (20, 0), name: "a")
  line((16, 0), (20, 0), stroke: (paint: r))

  line((0, -3), (16, -3), name: "b")

  set-style(stroke: (thickness: .05, paint: black, dash: "dashed"))
  for i in range(0, 11) {
    line((2 * i, .5), (2 * i, -.5))
    line((2 * i, -3.5), (2 * i, -2.5))
    line((2 * i, -.5), (2 * i, -4.5), stroke: (paint: rgb(0, 0, 0, 15%)))
  }

  set-style(stroke: (thickness: .05, dash: none))
  cetz.decorations.brace((2,-4.5),(0,-4.5))
  content((1, -5.5))[$x$]

  cetz.decorations.brace((20,-4.5),(16,-4.5))
  content((18, -5.5))[$a-b$]

  content("a.mid", anchor: "south", padding: (bottom: 1))[$a$]
  content("b.mid", anchor: "south", padding: (bottom: 1))[$b$]
})