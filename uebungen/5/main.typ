= Heaps

== Mergesort und Quicksort

=== Mergesort

#import "/notizen/sortieralgorithmen/mergesort/recursion.typ": mergesort_recursion

#{
  set align(center)
  set text(size: 11pt)
  set table.cell(inset: 1pt, stroke: none)
  show table: box.with(stroke: 1pt, inset: (y: 1pt))
  mergesort_recursion(
    (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19),
    spacing: 0pt
  )
}