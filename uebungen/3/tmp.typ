#import "@preview/cetz:0.2.2"

#set page(width: auto, height: auto, margin: 12pt)

#let ack(n, m) = {
  if n == 0 {
    return (n: n, m: m, o: m + 1)
  }

  if m == 0 and n >= 1 {
    let l = ack(n - 1, 1)
    let o = if type(l) == dictionary {l.o} else {l.at(0).o}
    return ((n: n, m: m, o: o), l)
    return l
  }

  let l = ack(n, m - 1)
  let o = if type(l) == dictionary {l.o} else {l.at(0).o}
  let r = ack(n - 1, o)
  o = if type(r) == dictionary {r.o} else {r.at(0).o}
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
    content_tree(ack(1, 3)),
    spread: 2.5
  )
})
