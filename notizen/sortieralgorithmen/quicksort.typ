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
  if parts.all(p => p.len() == 1) {
    return ()
  }
  let (swaps, parts) = step(parts)
  return (swaps, parts) + quicksort_rows(parts)
}

#let num_row(parts) = table(
  columns: (1fr,) * parts.flatten().len(),
  align: center + horizon,
  ..parts.map(p => {
    if p.len() == 1 {
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
  let height = 20pt
  line((0, 0), (1, -height), stroke: none)
  translate(x: .5/n)
  for (from, to) in swaps.enumerate() {
    let from_x = from / n
    let to_x = to / n
    let kind = kind(parts, from)

    if kind == "pivot" {
      on-layer(1, {
        stroke(2pt)
        bezier(
          (from_x, 0),
          (to_x, -height),
          (from_x, -height/2),
          (to_x, -height/2),
          mark: (end: ">")
        )
      })
    } else if kind == "right" {
      group({
        stroke(theme.secondary_trans)
        bezier(
          (from_x, 0),
          (to_x, -height),
          (from_x, -height/2),
          (to_x, -height/2),
          mark: (end: ">")
        )
      })
    } else if kind == "left" {
      group({
        stroke(theme.primary_trans)
        bezier(
          (from_x, 0),
          (to_x, -height),
          (from_x, -height/2),
          (to_x, -height/2),
          mark: (end: ">")
        )
      })
    }
  }
})

#let quicksort(..nums) = {
  let rows = quicksort_rows((nums.pos(),))
  rows.insert(0, (nums.pos(),))
  rows.push(none)
  block(breakable: false, {
    set block(above: 0pt)
    for (parts, swaps) in rows.chunks(2) {
      num_row(parts)
      if swaps != none {
        arrow_row(parts, swaps)
      }
    }
  })
}