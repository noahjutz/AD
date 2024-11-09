#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed, note
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
  named_tree((
    name: "z",
    draw: () => {
      note[$z$]
      for _ in range(2) {
        line(
          (8pt, 8pt),
          (-8pt, -8pt),
          stroke: 2pt + theme.primary
        )
        scale(x: -1)
      }
    },
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
})