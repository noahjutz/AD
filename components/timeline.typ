#import "/config.typ": theme

#let timeline(body) = {
  set list(marker: circle(radius: 4pt, fill: black, stroke: none))
  show list: l => {
    layout(((width,)) => {
      let items = ()
      for child in l.children {
        let (height,) = measure(
          block(
            width: width,
            inset: (left: 16pt),
            child.body
          )
        )
        items.push(box(
          width: 8pt,
          height: height + 16pt,
          {
            set block(above: 0pt)
            circle(
              radius: 4pt,
              stroke: none,
              fill: theme.fg_light
            )
            place(
              dx: 50%,
              line(
                length: height + 8pt,
                angle: 90deg,
                stroke: theme.fg_light
              )
            )
          }
        ))
        items.push(child.body)
      }
      grid(
        columns: (8pt, 1fr),
        column-gutter: 8pt,
        ..items
      )
    })
  }

  body
}