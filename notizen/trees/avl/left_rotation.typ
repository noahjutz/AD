#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
)

#cetz.canvas({
  import cetz.draw: *
  named_tree((
    body: "a",
    //draw: circle.with((), radius: 10pt),
  ))
})