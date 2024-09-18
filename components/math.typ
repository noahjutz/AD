#import "/config.typ": theme

#let hlp(math) = {
  set text(fill: theme.primary)
  math
}
#let hls(math) {
  set text(fill: theme.secondary)
  math
}