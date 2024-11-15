#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
  fill: none
)

#cetz.canvas({
  import cetz.draw: *
  named_tree(radius: 8pt, spread: .8, grow: 1, (
    body: "10",
    l: (
      body: "2",
      l: (
        body: "1"
      ),
      r: (
        body: "9"
      )
    ),
    r: (
      body: "13",
      l: (
        body: "11"
      ),
      r: (
        body: "16"
      )
    )
  ))
})