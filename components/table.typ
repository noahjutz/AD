#let inside(x, y, stroke_style: black) = {
  let strokes = (:)
  if x == 0 {strokes.insert("right", stroke_style)}
  if y != 0 {strokes.insert("top", stroke_style)}
  strokes
}