#import "/components/lefttree.typ": subtree
#import "heap.typ": heap

#let nums = (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19)

#let done = ()

#let step(i, x, y, nums, done) = heap(
  nums, 
  bg_tertiary: subtree(i, nums.len()),
  hl_success: done,
  swaps: ((x, y),),
  annotations: ((x, "i"),)
)

#let heapify(index, nums, done) = {
  let return_content = ([])

  let queue = (index,)
  while queue.len() > 0 {
    let i = queue.remove(0)
    let max = (i, 2*i+1, 2*i+2)
      .sorted(key: i => nums.at(i, default: -calc.inf))
      .last()
    return_content += step(index, i, max, nums, done)
    (
      nums.at(i),
      nums.at(max)
    ) = (
      nums.at(max),
      nums.at(i)
    )
    if i != max {
      queue.push(max)
    }
  }
  return (nums, return_content)
}

#let m = calc.div-euclid(nums.len(), 2)
#for i in range(m - 1, -1, step: -1) {
  let (ret_nums, figs) = heapify(i, nums, done)
  nums = ret_nums
  figs
  done += subtree(i, nums.len())
  heap(
    nums,
    hl_success: done,
    bg_success: subtree(i, nums.len())
  )
}