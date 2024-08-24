#import "title.typ": title
#import "config.typ"
#show: config.config
#set page(numbering: "1")

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
#include "notizen/algorithmen/main.typ"
#include "notizen/komplexitaet/main.typ"

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

#counter(heading).update(0)
#hide(counter(heading).display()) // counter workaround
#pagebreak()

#include "uebungen/1/main.typ"
#include "uebungen/2/main.typ"