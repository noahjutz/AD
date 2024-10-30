#import "/config.typ": theme

#let admonition(title, body) = {
  block(
    stroke: 1pt,
    width: 100%,
    clip: true,
    stack(
      block(
        fill: theme.bg_trans,
        inset: (x: 6pt, y: 10pt),
        width: 100%,
        below: 0pt,
        strong(title)
      ),
      block(
        inset: 6pt,
        body
      )
    )
  )
}