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

#include "buildheap.typ"

2. Sortieren

#include "heapsort.typ"

Algorithmus:

```python
def heapify(a, i, n):
    j = max(
        i, 2*i+1, 2*i+2,
        key=lambda i: a[i] if i < n else -math.inf
    )
    a[i], a[j] = a[j], a[i]
    if i != j:
        heapify(a, j, n)

def build_heap(a):
    for i in range(len(a)//2-1, -1, -1):
        heapify(a, i, len(a))

def heapsort(a):
    build_heap(a)
    for i in range(len(a)-1, 0, -1):
        a[0], a[i] = a[i], a[0]
        heapify(a, 0, i)
```
