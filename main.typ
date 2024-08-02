#import "title.typ": title
#import "config.typ": config
#show: config

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
#include "notizen/begriffe/main.typ"

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
#counter(heading).update(0)

#include "uebungen/1/main.typ"