#import "/config.typ": theme
#let inside(x, y, stroke_style: theme.fg_medium) = {
  let strokes = (:)
  if x != 0 {strokes.insert("left", stroke_style)}
  if y != 0 {strokes.insert("top", stroke_style)}
  strokes
}