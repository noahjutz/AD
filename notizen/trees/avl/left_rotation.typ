#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
)

#cetz.canvas({
  named_tree((
    body: "a"
  ))
})