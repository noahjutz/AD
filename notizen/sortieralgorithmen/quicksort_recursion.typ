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

#let (l, p, r, s) = partition(nums)

#table(
  columns: (1fr,)*nums.len(),
  align: center,
  ..nums.map(n => str(n)),
  ..s.map(n => str(n)),
  ..(l + p + r).map(n => str(n))
)