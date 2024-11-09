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

#let convex_hull(..points, fun) = get-ctx(ctx => {
  assert(points.pos().len() >= 2)

  let is_right_turn(p1, p2, p3) = {
    return vec.len(
      vec.cross(
        vec.as-vec(vec.sub(p2, p1)),
        vec.as-vec(vec.sub(p3, p2))
      )
    ) <= 0
  }

  // Get absolute position of nodes
  let points = points.pos().map(p => {
    let (_, (x, y, z)) = resolve(ctx, p)
    (x, y)
  })

  // Get initial point for Graham Scan
  points = points.sorted(key: ((x, y)) => {(y, x)})
  let lowest = points.remove(0)

  // Sort by polar angle, farthest first
  points = points.sorted(key: point => (
    vec.angle2(lowest, point),
    -vec.dist(lowest, point)
  ))

  points.insert(0, lowest)

  // Construct stack
  let stack = points.slice(0, 2)
  for (i, point) in points.enumerate().slice(2) {
    while stack.len() >= 2 and is_right_turn(point, stack.at(-1), stack.at(-2)) {
      point = stack.pop()
    }
    stack.push(point)
  }

  fun(..stack)
})

#let note(pos: (), ang: 90deg, dist: 8pt, body) = group({
  ang = calc.rem(ang.deg(), 360)
  if ang < 0 {ang += 360}
  ang = eval(str(ang) + "deg")

  rotate(ang, origin: pos)

  content(
    (rel: (0, dist), to: pos),
    anchor: if 22.5deg < ang and ang <= 67.5deg {"south-east"}
      else if 67.5deg < ang and ang <= 112.5deg {"east"}
      else if 112.5deg < ang and ang <= 157.5deg {"north-east"}
      else if 157.5deg < ang and ang <= 202.5deg {"north"}
      else if 202.5deg < ang and ang <= 247.5deg {"north-west"}
      else if 247.5deg < ang and ang <= 292.5deg {"west"}
      else if 292.5deg < ang and ang <= 337.5deg {"south-west"}
      else {"south"},
    body
  )
})

