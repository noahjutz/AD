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
    return "0"
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
  return "0-" + turns.join("-")
}

#import "@preview/cetz:0.3.0": draw
#import draw: *

#let arrow(from, to, fun) = {
  from = "tree." + index_to_name(from)
  to = "tree." + index_to_name(to)
  intersections("i", {
    hide(circle(from, radius: 10pt))
    hide(circle(to, radius: 10pt))
    hide(fun(from, to))
  })
  fun("i.0", "i.1")
}

#let box_around(top, bl, br, fun) = {
  top = "tree." + index_to_name(top)
  bl = "tree." + index_to_name(bl)
  br = "tree." + index_to_name(br)

  fun(
    (rel: (-14pt, 14pt), to: (bl, "|-", top)),
    (rel: (14pt, -14pt), to: br)
  )
}
#let note(at, body) = {
  let to = "tree." + index_to_name(at)
  let from = (rel: (0, -32pt), to: to)
  rotate(0deg)
  intersections("i", {
    hide(circle(to, radius: 10pt))
    hide(line(from, to))
  })

  to = "i.0"
  let ctrl = (rel: (-8pt, 0), to: (from, 50%, to))

  bezier(
    from, "i.0", ctrl,
    name: "line",
    mark: (end: ">")
  )

  content(
    "line.start",
    box(
      fill: white,
      inset: 2pt,
      "hi"
    )
  )
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