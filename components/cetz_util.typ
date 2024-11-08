#import "@preview/cetz:0.3.1"
#import cetz.draw: *
#import cetz.coordinate: resolve
#import cetz.vector as vec

#let boxed(..points, inset: 10pt, fun) = get-ctx(ctx => {
  let min_x = calc.inf
  let max_x = -calc.inf
  let min_y = calc.inf
  let max_y = -calc.inf

  for node in points.pos() {
    let (_, (x, y, z)) = resolve(ctx, node)
    min_x = calc.min(min_x, x)
    max_x = calc.max(max_x, x)
    min_y = calc.min(min_y, y)
    max_y = calc.max(max_y, y)
  }

  let (_, a, b) = resolve(ctx, (0, 0), (0, inset))
  let dist = vec.dist(a, b)

  min_x -= dist
  max_x += dist
  min_y -= dist
  max_y += dist

  fun(
    (min_x, min_y),
    (max_x, max_y)
  )
})

