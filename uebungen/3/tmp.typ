#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

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

#cetz.canvas(length: 100%, {
  import cetz.draw: *

  let h = 16pt
  let w = .6

  let draw_tree(root, depth: 1) = {
    if type(root) != array {
      return
    }

    let id = "p_" + str(depth)
    if root.len() == 2 {
      let (p, c) = root
      circle((), radius: 0, name: id)

      line(id, (rel: (0, -h)))
      draw_tree(c, depth: depth+1)
    } else if root.len() == 3 {
      let (p, l, r) = root
      circle((), radius: 0, name: id)

      line(id, (rel: (-w/calc.pow(2, depth), -h)))
      draw_tree(l, depth: depth+1)

      line(id, (rel: (w/calc.pow(2, depth), -h)))
      draw_tree(r, depth: depth+1)
    }
  }

  draw_tree(ack(3, 1))
})
