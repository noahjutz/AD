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
      body: "6",
      l: (
        body: "4",
        l: (
          body: "2",
          l: (
            body: "1"
          ),
          r: (
            body: "3"
          )
        ),
        r: (
          body: "5"
        )
      ),
      r: (
        body: "9",
        l: (
          body: "8"
        ),
        r: (node: hidden, line: hidden)
      )
    ),
    r: (
      body: "13",
      l: (
        body: "12",
        l: (
          body: "11"
        ),
        r: (node: hidden, line: hidden)
      ),
      r: (
        body: "15",
        l: (
          body: "14"
        ),
        r: (
          body: "16"
        )
      )
    )
  ))
})