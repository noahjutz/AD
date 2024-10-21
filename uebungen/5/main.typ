= Heaps

== Mergesort und Quicksort

=== Mergesort

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

=== Heapsort

