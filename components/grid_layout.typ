// lays out a bunch of boxes without regarding their order, as compactly as possible (implementation: FFDH)

#let grid_layout(..children, column_gutter: 8pt, row_gutter: 8pt) = context layout(((width, height)) => {
  // list[tuple[size, content]]
  let children = children
    .pos()
    .map(c => box(c))
    .map(c => (measure(c), c))
    .sorted(key: ((size, ..)) => size.height)

  // list[tuple[load, list[content]]]
  let bins = () 

  // FFDH
  for i in range(children.len()-1, -1, step: -1) {
    let (size, child) = children.at(i)
    let is_bin_found = false
    for j in range(bins.len()) {
      if width - bins.at(j).at(0) >= size.width {
        bins.at(j).at(1).push(child)
        bins.at(j).at(0) += size.width + column_gutter
        is_bin_found = true
        break
      }
    }
    if not is_bin_found {
      bins.push((size.width, (child,)))
    }
  }

  set par(spacing: row_gutter)
  for (_, children) in bins {
    stack(
      dir: ltr,
      spacing: column_gutter,
      ..children
    )
  }
})

// Example
// #import "@preview/suiji:0.3.0": integers-f, gen-rng-f
// 
// #grid_layout(
//     ..integers-f(gen-rng-f(42), low: 10, high: 50, size: 200)
//         .at(1)
//         .chunks(2)
//         .map(((w, h)) => {
//             rect(
//                 width: eval(str(w) + "pt"),
//                 height: eval(str(h) + "pt"))
//         })
// )