#import "@preview/cetz:0.3.1"

#cetz.canvas(length: 100%, {
  import cetz.draw: *

  set-viewport((0, 0), (1, .3))

  let n = 5
  for i in range(n) {
    rect((0, 0), (1, 1))

    if i == n - 1 {
      break
    }

    let is_wide = calc.rem(i, 2) == 0

    if is_wide {
      move-to((.25, .5))
    } else {
      move-to((.5, .25))
    }
    let s = if i == 0 {"...0"} else {"...0" + "1" * i}
    content((), s)

    if is_wide {
      scale(x: 50%)
      translate((1, 0))
    } else {
      scale(y: 50%)
      translate((0, 1))
    }
  }
})