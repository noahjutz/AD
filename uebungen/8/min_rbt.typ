#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let b = (fill: theme.fg_medium)
#let r = (fill: theme.primary_light)
#let hidden = (stroke: none)

#let complete_black_tree(height) = {
  if height == 1 {
    return (node: b)
  }
  return (
    node: b,
    l: complete_black_tree(height - 1),
    r: complete_black_tree(height - 1)
  )
}

#let minimal_rbt(blackheight) = {
  if blackheight == 1 {
    return (
      node: b,
      l: (node: r),
      r: (node: hidden, line: hidden)
    )
  }

  return (
    node: b,
    l: (
      node: r,
      l: minimal_rbt(blackheight - 1),
      r: complete_black_tree(blackheight - 1)
    ),
    r: complete_black_tree(blackheight - 1)
  )
}

#cetz.canvas({
  import cetz.draw: *
  named_tree(spread: .45, minimal_rbt(4))
})