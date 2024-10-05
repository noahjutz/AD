#import "/config.typ": theme

#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

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

#let quicksort(parts) = {
  if parts.flatten() == parts.flatten().sorted() {
    return ()
  }
  let (swaps, parts) = step(parts)
  return (swaps, parts) + quicksort(parts)
}

#let num_row(parts, is_final: false) = table(
  columns: (1fr,) * parts.flatten().len(),
  align: center + horizon,
  ..parts.map(p => {
    if p.len() == 1 and not is_final {
      table.cell(
        stroke: none,
        inset: 0pt,
        line(length: 20pt, angle: 90deg)
      )
    } else {
      p.enumerate().map(((i, n)) => {
        table.cell(
          fill: if i == 0 {theme.tertiary_light}
            else if n <= p.first() {theme.secondary_light}
            else {theme.primary_light},
          str(n)
        )
      })
    }
  }).flatten()
)

#let arrow_row(swaps) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  let n = swaps.len()
  line((0, 0), (1, 0), stroke: none)
  translate(x: .5/n)
  for (from, to) in swaps.enumerate() {
    from /= n
    to /= n

    bezier(
      (from, 0),
      (to, -32pt),
      (from, -16pt),
      (to, -16pt),
      stroke: if from == 0 {yellow} else {black}
    )
  }
})

#{
  set block(above: 0pt)
  num_row((nums,))
  for (swaps, parts) in quicksort((nums,)).chunks(2) {
    arrow_row(swaps)
    num_row(parts, is_final: parts.flatten() == parts.flatten().sorted())
  }
}