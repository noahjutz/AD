#let timeline(body) = {
  set list(marker: circle(radius: 4pt, fill: black, stroke: none))
  show list: l => {
    // TODO: line between bullet points
    for c in l.children {
      stack(
        dir: ltr,
        spacing: l.body-indent,
        l.marker,
        c.body,
      )
    }
  }
  body
}