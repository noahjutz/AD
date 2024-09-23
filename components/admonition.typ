#import "/config.typ": theme

#let admonition(title, body) = {
  block(
    stroke: 1pt + theme.fg_light,
    width: 100%,
    radius: 4pt,
    clip: true,
    stack(
      block(
        fill: theme.bg_light,
        inset: 6pt,
        width: 100%,
        below: 0pt,
        title
      ),
      block(
        inset: 6pt,
        body
      )
    )
  )
}