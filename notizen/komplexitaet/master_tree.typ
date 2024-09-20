#import "@preview/cetz:0.2.2"

#let a = 2
#let max_depth = 4

#let rec_tree(root, depth: 0) = {
  if depth == max_depth {return root}

  let children = if depth == max_depth - 2 {
    ([...], ) * a
  } else if depth == max_depth - 1 {
    ($1$, ) * a
  } else {
    ($n/b^(#(depth+1))$, ) * a
  }
  children = children.map(c => rec_tree(c, depth: depth + 1))
  return (root, ..children)
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  set-style(content: (padding: 6pt))
  tree.tree(
    //($n$, $n/b$, $n/b$, $n dot b ^(-1)$)
    rec_tree($n$),
    spread: .35,
    grow: 1.2,
    name: "tree",
  )

  set-style(content: (padding: 0pt))
  cetz.decorations.flat-brace(
    (rel: (-4pt, 0), to: "tree.south-west"),
    (rel: (-4pt, 0), to: "tree.north-west"),
    name: "height"
  )

  content("height.content", anchor: "south", angle: 90deg)[$log_b n$]

  cetz.decorations.flat-brace(
    (rel: (0, -4pt), to: "tree.south-east"),
    (rel: (0, -4pt), to: "tree.south-west"),
    name: "width"
  )

  content("width.content", anchor: "north")[$a^(log_b n)$]
})