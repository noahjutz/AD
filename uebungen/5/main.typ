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
  let heapify(i) = {
    let swaps = ()
    let max = (i, 2*i+1, 2*i+2)
      .sorted(key: i => nums.at(i, default: -calc.inf))
      .last()
    swaps.push((i, max))
    if i != max {
      swaps += heapify(max)
    }
    return swaps
  }
  let m = calc.div-euclid(nums.len(), 2)
  for i in range(m - 1, -1, step: -1) {
    for (from, to) in heapify(i) {
      heap(
        nums,
        annotations: ((from, "i"),),
        swaps: ((from, to),),
        bg_tertiary: subtree(i, nums.len())
      )
      nums.insert(from, nums.remove(to))
    }
    heap(
      nums,
      hl_success: subtree(i, nums.len()),
      bg_tertiary: subtree(i, nums.len())
    )
  }
}