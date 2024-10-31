#import "/config.typ": theme

#let timeline(body) = {
  set list(marker: circle(radius: 4pt, fill: black, stroke: none))
  show list: l => {
    layout(((width,)) => {
      let items = ()
      for (i, child) in l.children.enumerate() {
        let (height,) = measure(
          block(
            width: width,
            inset: (left: 16pt),
            child.body
          )
        )
        items.push(block(
          width: 8pt,
          height: height + if i < l.children.len()-1 {16pt},
          {
            set block(above: 0pt)
            circle(
              radius: 4pt,
              stroke: none,
              fill: theme.fg_dark
            )
            align(center,
              block(
                width: .5pt,
                height: height + if i < l.children.len()-1 {8pt} else {-8pt},
                stroke: theme.fg_dark
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