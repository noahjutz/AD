#import "title.typ": title
#import "config.typ"
#show: doc => config.config(doc)

#title 
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Notizen]
] <notizen>
#outline(
  indent: true,
  depth: 2,
  title: "",
  target: selector(heading).before(<uebungen>, inclusive: false).after(<notizen>, inclusive: false),
)

#pagebreak()
#include "sections/grundlagen/main.typ"

#pagebreak()

#title
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Übungen]
] <uebungen>
#outline(
  indent: true,
  depth: 2,
  title: "",
  target: selector(heading).after(<uebungen>, inclusive: false)
)

#pagebreak()

#show: doc => config.config2(doc)
#counter(heading).update(0)

= Algorithmen

== ggT / kgV
