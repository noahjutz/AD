#import "heap.typ": heap

#let nums = (23, 19, 17, 12, 13, -5, -32, 7, -35, -3)

#let step(x, y, nums, n) = heap(
  nums, 
  hl_success: range(n, nums.len()),
  swaps: ((x, y),),
  annotations: ((x, `i`),),
  detached: range(n, nums.len())
)

#let heapify_root(nums, n) = {
  let return_content = ()

  let queue = (0,)
  while queue.len() > 0 {
    let i = queue.remove(0)
    let max = (i, 2*i+1, 2*i+2)
      .sorted(key: i => nums.at(i, default: -calc.inf))
      .last()
    return_content.push(step(i, max, nums, n))
    (
      nums.at(i),
      nums.at(max)
    ) = (
      nums.at(max),
      nums.at(i)
    )
    if i != max and max < calc.div-euclid(n - 1, 2) {
      queue.push(max)
    }
  }
  return (nums, return_content)
}

#let heaps = ()
#let n = nums.len()
#for i in range(n - 1, 1, step: -1) {
  heaps.push(box[
    #heap(
      nums,
      swaps: ((0, n - 1),),
      hl_success: range(n, nums.len()),
      detached: range(n, nums.len())
    )
    #place(top + left)[swap]
  ])
  (nums.at(0), nums.at(n - 1)) = (nums.at(n - 1), nums.at(0))
  
  n -= 1

  let (numbers, h) = heapify_root(nums, n)
  nums = numbers
  heaps += h.map(h => box[
    #h
    #place(top + left)[heapify]
  ])
}

#grid(
  columns: (1fr,)*2,
  column-gutter: 4pt,
  row-gutter: 8pt,
  align: bottom,
  ..heaps.map(scale.with(50%, reflow: true))
)
