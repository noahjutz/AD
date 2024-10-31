#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#cetz.canvas(length: 32pt, {
  import cetz.draw: *
  content((), name: "0")[$b_t$ belegt?]
  content((rel: (0, -1)), name: "1")[hi]

  on-layer(-1, {
    for i in range(2) {
      let l = str(i) + ".west"
      let m = str(i) + ".center"
      let r = str(i) + ".east"

      line(
        (rel: (-.25, 0), to: l),
        (rel: (0, .25), to: m),
        (rel: (.25, 0), to: r),
        (rel: (0, -.25), to: m),
        close: true,
        stroke: none,
        fill: theme.fg_dark
      )
    }
  })
})