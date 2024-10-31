#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#let anch = state("map_sort_choices_anchor", "0")

#context { cetz.canvas(length: 48pt, {
  import cetz.draw: *

  let choice(body) = {
    content(
      (),
      name: anch.get(),
      padding: (x: .2),
      box(height: 24pt, align(horizon, body))
    )
    on-layer(-1, {
      let l = anch.get() + ".west"
      let t = anch.get() + ".north"
      let r = anch.get() + ".east"
      let b = anch.get() + ".south"

      line(
        l, t, r, b,
        close: true,
        stroke: 2pt + theme.fg_medium,
      )
    })
  }

  let to(dir) = {
    let start = anch.get() + "." + {
      if dir == "t" {"north"}
      else if dir == "l" {"west"}
      else if dir == "r" {"east"}
      else if dir == "b" {"south"}
    }
    let end = {
      if dir == "t" {(rel: (0, 1))}
      else if dir == "l" {(rel: (-1, 0))}
      else if dir == "r" {(rel: (1, 0))}
      else if dir == "b" {(rel: (0, -1))}
    }
    
    line(start, end, mark: (end: "straight"))
  }

  choice[$b_t$ belegt?]
  to("b")
  content((rel: (0, -1)), name: "1")[hi]

  
})}