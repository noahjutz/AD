#import "/config.typ": theme

#import "@preview/cetz:0.2.2"

#let swap_trace(trace, i, j) = {
  let k = trace.position(n => n == i)
  let l = trace.position(n => n == j)

  (trace.at(k), trace.at(l)) = (trace.at(l), trace.at(k))
  return trace
}

#let partition(nums) = {
  let trace = range(nums.len())
  let j = 1
  for i in range(1, nums.len()) {
    if nums.at(i) <= nums.at(0) {
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      trace = swap_trace(trace, i, j)
      j += 1
    }
  }

  (nums.at(0), nums.at(j - 1)) = (nums.at(j - 1), nums.at(0))
  trace = swap_trace(trace, 0, j - 1)

  return (
    nums.slice(0, j - 1),
    (nums.at(j - 1),),
    nums.slice(j, nums.len()),
    trace
  )
}

#let step(parts) = {
  let out_parts = ()
  let out_swaps = ()
  let i = 0
  for part in parts {
    if part.len() == 0 {
      continue
    }
    if part.len() == 1 {
      out_parts.push(part)
      out_swaps.push(i)
      i += 1
      continue
    }
    let (l, p, r, s) = partition(part)
    out_parts += (l, p, r)
    out_swaps += s.map(s => s + i)
    i += (l + p + r).len()
  }
  return (out_swaps, out_parts)
}

#let quicksort_rows(parts) = {
  let (swaps, parts) = step(parts)
  if parts.all(p => p.len() == 1) {
    return ()
  }
  return (swaps, parts) + quicksort_rows(parts)
}

#let num_row(parts, is_final: false) = table(
  columns: (1fr,) * parts.flatten().len(),
  align: center + horizon,
  ..parts.map(p => {
    //if p.len() == 1 and not is_final {
    //  table.cell(
    //    stroke: none,
    //    inset: 0pt,
    //    line(
    //      length: 20pt,
    //      angle: 90deg,
    //      stroke: theme.tertiary + 3pt,
    //    )
    //  )
    /*} else */if p.len() == 1 {
      table.cell(
        fill: theme.success_light,
        str(p.at(0))
      )
    } else {
      p.enumerate().map(((i, n)) => {
        table.cell(
          fill: if i == 0 {theme.tertiary_light}
            else if n <= p.first() {theme.primary_light}
            else {theme.secondary_light},
          str(n)
        )
      })
    }
  }).flatten()
)

#let arrow_row(parts, swaps) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  let kind(parts, index) = {
    let i = 0
    for x in parts {
      let j = 0
      for y in x {
        if i == index {
          return if x.len() == 1 {
            "pass_through"
          } else if j == 0 {
            "pivot"
          } else if y <= x.first() {
            "left"
          } else {
            "right"
          }
        }
        i += 1
        j += 1
      }
    }
  }
  let arrow = group({
    line((), (rel: (0, -12pt)))
    arc((), start: 180deg, stop: 270deg, radius: 4pt)
    line((), (rel: (8pt, 0)),
      mark: (end: ">")
    )
  })
  let n = swaps.len()
  line((0, 0), (1, -32pt), stroke: none)
  translate(x: .5/n)
  for (from, to) in swaps.enumerate() {
    let from_x = from / n
    let to_x = to / n
    let kind = kind(parts, from)

    if kind == "pass_through" {
      group({
        stroke(theme.tertiary + 3pt)
        line((from_x, 0), (from_x, -32pt), mark: (end: ">"))
      })
    } else if kind == "pivot" {
      group({
        stroke(theme.tertiary + 3pt)
        bezier(
          (from_x, 0),
          (to_x, -32pt),
          (from_x, -16pt),
          (to_x, -16pt),
          mark: (end: ">")
        )
      })
    } else if kind == "right" {
      group({
        stroke(theme.secondary)
        move-to((from_x, 0))
        arrow
      })
    } else if kind == "left" {
      group({
        circle((from_x, 0), radius: 0, name: "anc")
        scale(x: -100%)
        move-to("anc")
        stroke(theme.primary)
        arrow
      })
    }
  }

  //for i in range(parts.flatten().len())
    //.filter(i => i not in )
})

#let quicksort(..nums) = {
  set block(above: 0pt)
  let rows = quicksort_rows((nums.pos(),))
  rows.insert(0, (nums.pos(),))
  rows.push(none)
  block(breakable: false, {
    for (parts, swaps) in rows.chunks(2) {
      let is_final = parts.all(p => p.len() <= 1)
      num_row(parts, is_final: is_final)
      if swaps != none {
        arrow_row(parts, swaps)
      }
    }
  })
}