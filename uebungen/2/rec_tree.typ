#import "@preview/cetz:0.2.2"

#let rec_tree(root) = {
  if root < 2 {root}
  else {(root, rec_tree(root - 1), rec_tree(root - 2))}
}

#let to_content(x) =  if type(x) == array {x.map(to_content)} else {repr(x)}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  let n = 5
  set-style(content: (padding: 4pt))
  tree.tree(rec_tree(n).map(to_content))
})