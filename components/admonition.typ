#import "/config.typ": theme

#let admonition(title: none, body) = {
  block(
    stroke: 1pt,
    width: 100%,
    clip: true,
    stack(
      if title != none {
        block(
        fill: theme.fg_light,
        inset: (x: 6pt, y: 10pt),
        width: 100%,
        below: 0pt,
        strong(title)
        )
      },
      block(
        inset: 6pt,
        body
      )
    )
  )
}