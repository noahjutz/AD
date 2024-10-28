#import "@preview/cetz:0.3.1"

#let fibtree(root: false, depth) = {
  if depth == 0 { return root }
  if root {
    let left = fibtree(root: true, depth - 1)
    let right = fibtree(root: false, depth - 1)
    return (root, left, right)
  } else {
    let left = fibtree(root: true, depth - 1)
    return (root, left)
  }
}

#let contentify(data) = {
  for (i, e) in data.enumerate() {
    data.at(i) = if type(e) == array {
      contentify(e)
    } else {
      circle(
        radius: 6pt,
        fill: if e {black} else {white},
        stroke: black,
      )
    }
  }
  return data
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  let n = 5

  let labels = ($f_#(n - 1)$,)
  for i in range(n - 2, -1, step: -1) {
    labels = ($f_#i$, array(labels))
  }
  tree.tree(
    labels,
    name: "labels",
    draw-edge: (..) => {},
  )

  get-ctx(ctx => {
    let (ctx, (start, ..), (end, ..)) = cetz.coordinate.resolve(ctx, "labels.west", "labels.east")

    translate((end - start, 0))
    translate(x: 8pt)
  })

  let data = fibtree(n)
  tree.tree(
    contentify(data),
    grow: .8,
    spread: .8,
    parent-position: "begin",
    draw-edge: (from, to, ..) => on-layer(-1, {
      line(
        from,
        (from, "-|", to,),
        to
      )
    })
  )
})