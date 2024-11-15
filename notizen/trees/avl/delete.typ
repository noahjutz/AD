#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
)

#let l = (node: hidden, line: hidden)
#let r = (l: l)

#let min_avl(depth, l: l, r: r) = {
  if depth == 0 {
    return r
  }
  return min_avl(depth - 1, l: r, r: (l: l, r: r))
}

#let avl = min_avl(5)
#{
  avl.l.l.r.insert("node", (fill: theme.primary_light))
}

#cetz.canvas({
  named_tree((
    avl
  ))
})