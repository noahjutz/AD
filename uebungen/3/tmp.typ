#import "@preview/cetz:0.2.2"

#set page(width: auto, height: auto, margin: 12pt)

#let ack(n, m) = {
  if n == 0 {
    return m + 1
  }

  if m == 0 and n >= 1 {
    let l = ack(n - 1, 1)
    let o = if type(l) == int {l} else {l.flatten().last()}
    return ((n: n, m: m, o: o), l)
    return l
  }

  let l = ack(n, m - 1)
  let o = l.flatten().last()
  let r = ack(n - 1, o)
  if type(r) == int {
    o = r
  }
  return ((n: n, m: m, o: o), l, r)
}

#let content_tree(tree) = {
  return tree.map(elem => {
    if type(elem) == array {
      return content_tree(elem)
    } else {
      return repr(elem)
    }
  })
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    content_tree(ack(2, 1)),
    spread: 2
  )
})
