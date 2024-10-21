= Heaps

== Mergesort und Quicksort

=== Mergesort

Rekursionsbaum:

#import "/notizen/sortieralgorithmen/mergesort/recursion.typ": mergesort_recursion

#{
  set align(center)
  set text(size: 11pt)
  set table.cell(inset: (x: 1pt, y: 2pt), stroke: none)
  show table: box.with(stroke: 1pt)
  mergesort_recursion(
    (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19),
    spacing: 0pt
  )
}

Algorithmus:

```python
def merge(a, i, j, l):
  while i < j and j <= l:
    if a[j] < a[i]:
      a.insert(i, a.pop(j))
      j += 1
    i += 1

def mergesort(a, f, l):
  if f >= l: return
  m=(f+l)//2
  mergesort(a, f, m)
  mergesort(a, m+1, l)
  merge(a, f, m+1, l)

a=[-5, 13, -32, 7, -3, 17, 23, 12, -35, 19]
mergesort(a, 0, len(a)-1)
print(a)
```

=== Heapsort

0. Eingabe

#import "heap.typ": heap
#let nums = (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19)
#heap(nums)

1. BuildHeap

#{
  import "/components/lefttree.typ": subtree
  let done = ()

  let heapify(i, nums) = {
    let swaps = ()
    let max = (i, (2*i)+1, (2*i)+2)
      .sorted(key: i => nums.at(i, default: -calc.inf))
      .last()
    swaps.push((i, max))
    (nums.at(i), nums.at(max)) = (nums.at(max), nums.at(i))
    if i != max {
      let (s, n) = heapify(max, nums)
      swaps += s
      nums = n
    }
    return (swaps, nums)
  }

  let step(i, x, y, nums, done) = heap(
    nums, 
    bg_tertiary: subtree(i, nums.len()),
    hl_success: done,
    swaps: ((x, y),)
  )

  let heapify(index, nums, done) = {
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

  let m = calc.div-euclid(nums.len(), 2)
  for i in range(m - 1, -1, step: -1) {
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
}