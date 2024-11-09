#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed, note
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
  named_tree((
    name: "z",
    draw: note.with[$z$],
    l: (
      name: "l",
      draw: note.with[$l$],
      l: (
        name: "ll"
      ),
      r: (
        name: "lr"
      )
    ),
    r: (
      name: "r",
      draw: note.with[$r$],
      l: (
        name: "y",
        draw: note.with[$y$],
        l: (
          type: "nil",
        ),
        r: (
          name: "x",
          draw: note.with[$x$]
        )
      ),
      r: (:)
    )
  ))


  get-ctx(ctx => {
    let a = ctx.nt_anchors
    for key in a.keys() {
      a.at(key) = "tree." + a.at(key)
    }

    for _ in range(2) {
      line(
        (rel: (8pt, 8pt), to: a.z),
        (rel: (-8pt, -8pt), to: a.z),
        stroke: 2pt + theme.primary
      )
      scale(x: -1)
    }
  })
})
