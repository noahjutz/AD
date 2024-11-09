#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed, note
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
  named_tree((
    name: "z",
    l: (
      name: "l",
      l: (
        name: "ll"
      ),
      r: (
        name: "lr"
      )
    ),
    r: (
      name: "r",
      l: (
        name: "y",
        l: (
          name: "yl",
          type: "nil",
        ),
        r: (
          name: "x"
        )
      ),
      r: (
        name: "rr"
      )
    )
  ))


  get-ctx(ctx => {
    // let a = ctx.named_tree_anchors
    // for key in a.keys() {
    //   a.at(key) = "tree." + a.at(key)
    // }

    // for _ in range(2) {
    //   line(
    //     (rel: (8pt, 8pt), to: a.z),
    //     (rel: (-8pt, -8pt), to: a.z),
    //     stroke: 2pt + theme.primary
    //   )
    //   scale(x: -1)
    // }

    // boxed(a.l, a.lr, a.ll, rect.with(radius: 5pt))
    // boxed(a.r, a.rr, a.yl, rect.with(radius: 5pt))
    // note(a.z, ang: 90deg)[$z$]
    // note(a.y, ang: 90deg)[$y$]
    // note(a.r, ang: 90deg)[$r$]
    // note(a.l, ang: 90deg)[$l$]
    // note(a.x, ang: 90deg)[$x$]
  })
})
