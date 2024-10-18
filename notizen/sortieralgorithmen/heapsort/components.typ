#import "/config.typ": theme

#let bintree(nodes, i: 0) = {
  let node = (nodes.at(i),)
  if nodes.len() > 2 * i + 1 {
    node.push(bintree(nodes, i: 2*i+1))
  }
  if nodes.len() > 2*i+2 {
    node.push(bintree(nodes, i: 2*i+2))
  }
  return node
}

#let name_to_index(name) = {
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

#import "@preview/cetz:0.2.2"
#import cetz.draw: *

#let connect(from, to, fun) = {
  from = index_to_name(from)
  to = index_to_name(to)
  intersections("i", {
    hide(circle(from, radius: 10pt))
    hide(circle(to, radius: 10pt))
    hide(fun(from, to))
  })
  fun("i.0", "i.1")
}

#let bent_line(from, to, bend: 0, ..args) = get-ctx(ctx => {
  let (ctx, from_abs, to_abs) = cetz.coordinate.resolve(
    ctx,
    from,
    to
  )
  let length = cetz.vector.dist(to_abs, from_abs)
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
    let (_, (x, y, z)) = cetz.coordinate.resolve(ctx, name)
    min_x = calc.min(min_x, x)
    max_x = calc.max(min_x, x)
    min_y = calc.min(min_y, y)
    max_y = calc.max(max_y, y)
  }

  let (_, a, b) = cetz.coordinate.resolve(ctx, (0, 0), (0, pad))
  let dist = cetz.vector.dist(a, b)

  min_x -= dist
  max_x += dist
  min_y -= dist
  max_y += dist

  fun(
    (min_x, min_y),
    (max_x, max_y)
  )
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
    stroke: theme.fg_light,
    mark: (end: ">")
  )

  content(
    "line.start",
    frame: "rect",
    padding: 2pt,
    stroke: none,
    anchor: if 45deg < ang and ang <= 135deg {"east"}
      else if 135deg < ang and ang <= 225deg {"north"}
      else if 225deg < ang and ang <= 315deg {"west"}
      else {"south"},
    text(fill: theme.fg_light, body)
  )

  rotate(-ang, origin: to)
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
  ..sink
) = {
  let index = name_to_index(node.name)
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
    padding: 7pt,
    place(center + horizon, node.content),
  )
}