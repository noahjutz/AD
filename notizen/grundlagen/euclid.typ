#import "@preview/cetz:0.2.2"
#import "../../config.typ"

#show: doc => config.config(doc)

#let a = 8
#let b = 3
#let n = 4

#cetz.canvas(length: 10%, {
  import cetz.draw: *
  import cetz.vector
  import cetz.coordinate
  set-style(stroke: (thickness: 1pt))
  
  line(
    (1, 0),
    (rel: (a, 0)),
    name: "a_0"
  )
  line(
    (rel: (0, -.5), to: "a_0.start"),
    (rel: (b, 0)),
    name: "b_0"
  )
  line(
    "b_0.end",
    ("b_0.end", "-|", "a_0.end"),
    stroke: (dash: "dashed"),
    name: "d_0"
  )
  content("a_0.start", anchor: "east")[$a_0$]
  content("b_0.start", anchor: "east")[$b_0$]
  content("d_0.end", anchor: "west")[$d_0$]

  for i in range(n) {
    let a_prev = "a_" + str(i)
    let a = "a_" + str(i + 1)
    let b_prev = "b_" + str(i)
    let b = "b_" + str(i + 1)
    let d_prev = "d_" + str(i)
    let d = "d_" + str(i + 1)

    get-ctx(ctx => {
      let (ctx, b_start, b_end, d_start, d_end) = cetz.coordinate.resolve(ctx,
        b_prev + ".start",
        b_prev + ".end",
        d_prev + ".start",
        d_prev + ".end"
      )
      let len_b_prev = cetz.vector.dist(b_start, b_end)
      let len_d_prev = cetz.vector.dist(d_start, d_end)
      let len_a = calc.max(len_b_prev, len_d_prev)
      let len_b = calc.min(len_b_prev, len_d_prev)

      line(
        (rel: (0, -1.5), to: a_prev + ".start"),
        (rel: (len_a, 0)),
        name: a
      )

      line(
        (rel: (0, -2), to: a_prev + ".start"),
        (rel: (len_b, 0)),
        name: b
      )

      line(
        "b_" + str(i + 1) + ".end",
        ((), "-|", a + ".end"),
        stroke: (dash: "dashed"),
        name: d
      )

      group({
        let bp = b_prev + ".start"
        let dp = d_prev + ".end"
        let is_b_gr = len_b_prev > len_d_prev
        let greater = if is_b_gr {bp} else {dp}
        let lesser = if is_b_gr {dp} else {bp}

        set-style(mark: (end: "straight"), stroke: (paint: gray))
        line(greater, a + ".mid")
        line(lesser, b + ".mid")
      })

      content(a + ".start", anchor: "east")[$a_#(i + 1)$]
      content(b + ".start", anchor: "east")[$b_#(i + 1)$]
      if i + 1 < n {
        content(d + ".end", anchor: "west")[$d_#(i + 1)$]
      }
    })
  }
})