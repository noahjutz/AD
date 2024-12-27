#import "components.typ"

#let edges = components.sample_edges()
#let sets = (
  "0": none,
  "1": none,
  "2": none,
  "3": none,
  "4": none,
  "5": none,
  "6": none,
  "7": none,
  "8": none,
)
#for edge in edges.sorted(key: e => e.at(2)) {
  repr(edge)
}