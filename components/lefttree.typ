#import "/config.typ": theme

#let lefttree(nodes, i: 0) = {
  let node = (nodes.at(i),)
  if nodes.len() > 2 * i + 1 {
    node.push(lefttree(nodes, i: 2*i+1))
  }
  if nodes.len() > 2*i+2 {
    node.push(lefttree(nodes, i: 2*i+2))
  }
  return node
}

#let name_to_index(name) = {
  if name.at(0) == "g" {
    name = name.slice(1)
  }
  let turns = name.split("-").map(s => int(s)).slice(1)
  let i = 0
  for turn in turns {
    if turn == 0 {
      i = 2*i+1
    } else {
      i = 2*i+2
    }
  }
  return i
}

#let index_to_name(index) = {
  if index == 0 {
    return "tree.0"
  }
  let turns = ()
  while index > 0 {
    let is_right = calc.rem(index, 2) == 0

    if is_right {
      turns.push("1")
    } else {
      turns.push("0")
    }
    index = calc.div-euclid(index - 1, 2)
  }
  turns = turns.rev()
  return "tree.0-" + turns.join("-")
}

#let subtree(i, n) = {
  let nodes = ()
  let queue = (i,)
  while queue.len() > 0 {
    let node = queue.remove(0)
    if node < n {
      nodes.push(node)
      let l = 2*node+1
      let r = 2*node+2
      if l < n {queue.push(l)}
      if r < n {queue.push(r)}
    }
  }
  return nodes
}

// Most functions from here must be called from within a canvas that contains a tree with a named anchor "tree".
#import "@preview/cetz:0.3.1"
#import cetz.draw: *
#import cetz.coordinate: resolve
#import cetz.vector as vec

#let connect(from, to, fun) = {
  from = index_to_name(from)
  to = index_to_name(to)
  intersections("i", {
    hide(fun(from, to))
    hide(circle(from, radius: 10pt))
    if from != to {
      hide(circle(to, radius: 10pt))
    }
  })
  fun("i.0", "i.1")
}

#let bent_line(from, to, bend: 0, ..args) = get-ctx(ctx => {
  let (ctx, from_abs, to_abs) = resolve(
    ctx,
    from,
    to
  )
  let length = vec.dist(to_abs, from_abs)
  let mid = (from, 50%, to)

  rotate(90deg, origin: mid)
  hide(line(from_abs, to_abs, name: "perp"))
  bezier-through(
    from,
    ("perp.start", (bend+1)/2 * 100%, "perp.end"),
    to,
    ..args
  )
  rotate(-90deg, origin: mid)
})

#let box_around(..nodes, pad: 14pt, fun) = get-ctx(ctx => {
  let min_x = calc.inf
  let max_x = -calc.inf
  let min_y = calc.inf
  let max_y = -calc.inf

  for node in nodes.pos() {
    let name = index_to_name(node)
    let (_, (x, y, z)) = resolve(ctx, name)
    min_x = calc.min(min_x, x)
    max_x = calc.max(max_x, x)
    min_y = calc.min(min_y, y)
    max_y = calc.max(max_y, y)
  }

  let (_, a, b) = resolve(ctx, (0, 0), (0, pad))
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

#let poly_fill(..points, fill: theme.success_light) = {
  line(
    ..points,
    close: true,
    stroke: (
      paint: fill,
      thickness: 32pt,
      join: "round"
    ),
    fill: fill,
  )
}

#let polygon_around(..nodes, fun) = get-ctx(ctx => {
  assert(nodes.pos().len() >= 2)
  let is_right_turn(p1, p2, p3) = {
    return vec.len(
      vec.cross(
        vec.as-vec(vec.sub(p2, p1)),
        vec.as-vec(vec.sub(p3, p2))
      )
    ) <= 0
  }
  // Get absolute position of nodes
  let points = nodes.pos().map(n => {
    let name = index_to_name(n)
    let (_, (x, y, z)) = resolve(ctx, name)
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

#let note(ang: 0deg, at, body) = {
  ang = calc.rem(ang.deg(), 360)
  if ang < 0 {ang += 360}
  ang = eval(str(ang) + "deg")

  let to = index_to_name(at)
  let from = (rel: (0, 28pt), to: to)

  rotate(ang, origin: to)
  intersections("i", {
    hide(circle(to, radius: 10pt))
    hide(line(from, to))
  })


  line(
    from, "i.0",
    name: "line",
    stroke: theme.fg_dark,
    mark: (end: ">")
  )

  content(
    "line.start",
    frame: "rect",
    padding: 2pt,
    stroke: none,
    anchor: if 22.5deg < ang and ang <= 67.5deg {"south-east"}
      else if 67.5deg < ang and ang <= 112.5deg {"east"}
      else if 112.5deg < ang and ang <= 157.5deg {"north-east"}
      else if 157.5deg < ang and ang <= 202.5deg {"north"}
      else if 202.5deg < ang and ang <= 247.5deg {"north-west"}
      else if 247.5deg < ang and ang <= 292.5deg {"west"}
      else if 292.5deg < ang and ang <= 337.5deg {"south-west"}
      else {"south"},
    text(fill: theme.fg_dark, body)
  )

  rotate(-ang, origin: to)
}

#let number(at, body) = {
  let pos = index_to_name(at)
  content(
    (rel: (-20pt, 0), to: pos),
    fill: black,
    stroke: none,
    frame: "circle",
    padding: 4pt,
    place(
      center + horizon,
      text(
        fill: white,
        size: 9pt,
        weight: "bold",
        body
      )
    )
  )
}

#let fade(at, ang: 0deg) = {
  let to = index_to_name(at)
  let from = (rel: (28pt, 0), to: to)

  rotate(ang, origin: to)
  intersections("i", {
    hide(circle(to, radius: 10pt))
    hide(line(from, to))
  })

  line(
    from, "i.0",
    name: "line",
    stroke: gradient.linear(
      black, white,
      angle: -ang
    ),
  )

  rotate(-ang, origin: to)
}

#let draw_node(
  node,
  hl_primary: (),
  hl_secondary: (),
  hl_tertiary: (),
  hl_success: (),
  radius: 7pt,
  ..sink
) = {
  let index = name_to_index(node.name)
  if type(hl_primary) == function and hl_primary(index) {
    hl_primary = index
  }
  if type(hl_secondary) == function and hl_secondary(index) {
    hl_secondary = index
  }
  if type(hl_tertiary) == function and hl_tertiary(index) {
    hl_tertiary = index
  }
  if type(hl_success) == function and hl_success(index) {
    hl_success = index
  }
  hl_primary = (hl_primary,).flatten()
  hl_secondary = (hl_secondary,).flatten()
  hl_tertiary = (hl_tertiary,).flatten()
  hl_success = (hl_success,).flatten()
  content(
    (),
    frame: "circle",
    fill: if index in hl_primary {theme.primary_light}
      else if index in hl_secondary {theme.secondary_light}
      else if index in hl_tertiary {theme.tertiary_light}
      else if index in hl_success {theme.success_light}
      else {white},
    padding: radius,
    place(center + horizon, node.content),
  )
}

#let loop_line(from, to, ang: 0deg) = {
  rotate(ang)
  bezier(
    from,
    to,
    (rel: (16pt, 20pt), to: from),
    (rel: (-16pt, 20pt), to: to),
    mark: (symbol: ">")
  )
  rotate(-ang)
}