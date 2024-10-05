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
    (nums.at(0),),
    nums.slice(1, j),
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
  return (out_parts, out_swaps)
}

#let quicksort(nums) = {
  let parts = (nums,)
  let rows = (parts,)
  let i = 0
  while parts.flatten() != nums.sorted() {
    let (p, swaps) = step(parts)
    parts = p
    rows += swaps
    rows += parts
    if i == 4 {break}
    i += 1
  }
  return rows
}

#table(
  columns: (1fr,)*nums.len(),
  align: center,
  ..quicksort(nums).flatten().map(n => str(n))
)
