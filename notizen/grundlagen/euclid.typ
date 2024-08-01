#import "@preview/cetz:0.2.2"
#import "../../config.typ"

#show: doc => config.config(doc)

#cetz.canvas(length: 10%, {
  import cetz.draw: *
  set-style(stroke: (thickness: 1pt))
  
  // 0
  line((1, 0), (9, 0), name: "a_0")
  line((1, -.5), (4, -.5), name: "b_0")
  line((4, -.5), (9, -.5), stroke: (dash: "dashed"))

  // 1
  line((1, -1.5), (6, -1.5), name: "a_1")
  line((1, -2), (4, -2), name: "b_1")
  line((4, -2), (6, -2), stroke: (dash: "dashed"))

  group({
    set-style(
      mark: (end: "straight"),
      stroke: (paint: rgb(150, 150, 150))
    )
    bezier(
      (1, -.5), (1, -2), (0, -.5), (0, -2)
    )
    bezier(
      (9, -.5), (9, -1.5), (10, -.5), (10, -1.5), mark: none
    )
    line((9, -1.5), (6, -1.5))
  })

  // 2
  line((2, -3), (4, -3), name: "a_2")
  line((1, -3.5), (4, -3.5), name: "b_2")
  line((1, -3), (2, -3), stroke: (dash: "dashed"))

  group({
    set-style(
      mark: (end: "straight"),
      stroke: (paint: rgb(150, 150, 150))
    )
    bezier(
      (6, -2), (6, -3), (7, -2), (7, -3), mark: none
    )
    line((6, -3), (4, -3))
    bezier(
      (1, -2), (1, -3.5), (0, -2), (0, -3.5)
    )
  })

  // 3
  line((1, -4.5), (2, -4.5), name: "a_3")
  line((1, -5), (3, -5), name: "b_3")
  line((2, -4.5), (3, -4.5), stroke: (dash: "dashed"))

  group({
    set-style(
      mark: (end: "straight"),
      stroke: (paint: rgb(150, 150, 150))
    )
    bezier(
      (1, -3), (1, -4.5), (0, -3), (0, -4.5)
    )
    bezier(
      (4, -3), (4, -5), (5, -3), (5, -5), mark: none
    )
    line((4, -5), (3, -5))
  })

  // 4
  line((1, -6), (2, -6), name: "a_n")
  line((1, -6.5), (2, -6.5), name: "b_n")

  group({
    set-style(
      mark: (end: "straight"),
      stroke: (paint: rgb(150, 150, 150))
    )
    bezier(
      (1, -4.5), (1, -6), (0, -4.5), (0, -6)
    )
    bezier(
      (3, -4.5), (3, -6.5), (4, -4.5), (4, -6.5), mark: none
    )
    line((3, -6.5), (2, -6.5))
  })

  // labels
  content("a_0.start", anchor: "east")[$a_0$]
  content("b_0.start", anchor: "east")[$b_0$]
  content("a_1.start", anchor: "east")[$a_1$]
  content("b_1.start", anchor: "east")[$b_1$]
  content("a_2.start", anchor: "north-east")[$a_2$]
  content("b_2.start", anchor: "east")[$b_2$]
  content("a_3.start", anchor: "east")[$a_3$]
  content("b_3.start", anchor: "east")[$b_3$]
  content("a_n.start", anchor: "east")[$a_n$]
  content("b_n.start", anchor: "east")[$b_n$]
})