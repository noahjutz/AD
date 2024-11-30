#import "components/title.typ": title
#import "config.typ"
#show: config.config
#set page(numbering: "1")

#title 
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Notizen]
] <notizen>
#outline(
  target: selector(heading)
    .before(<uebungen>, inclusive: false)
    .after(<notizen>, inclusive: false),
)

#{
  pagebreak()
  set page(columns: 2)
  include "notizen/mathe/main.typ"
  include "notizen/komplexitaet/main.typ"
  include "notizen/algorithmen/main.typ"
  include "notizen/sortieralgorithmen/main.typ"
  include "notizen/trees/main.typ"
  include "notizen/datenstrukturen/main.typ"
}

#pagebreak()
#title
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Übungen]
] <uebungen>
#outline(
  target: selector(heading)
    .before(<appendix>, inclusive: false)
    .after(<uebungen>, inclusive: false)
)

#{
  counter(heading).update(0)
  pagebreak()
  set page(columns: 2)
  include "uebungen/1/main.typ"
  include "uebungen/2/main.typ"
  include "uebungen/3/main.typ"
  include "uebungen/4/main.typ"
  include "uebungen/5/main.typ"
  include "uebungen/6/main.typ"
  include "uebungen/7/main.typ"
  include "uebungen/8/main.typ"
  include "uebungen/9/main.typ"
  include "uebungen/10/main.typ"
}

#pagebreak()
#title
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Appendix]
] <appendix>
#outline(
  target: selector(heading)
    .after(<appendix>, inclusive: false)
    .before(<literatur>, inclusive: false)
)

#{
  counter(heading).update(0)
  pagebreak()
  set page(columns: 2)
  include "appendix/proof/main.typ"
  include "appendix/examples/main.typ"
  
  set page(columns: 1)
  include "appendix/code/main.typ"
}

#pagebreak()
#title
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Bibliographie]
] <literatur>
#outline(
  target: selector(heading)
    .after(<literatur>, inclusive: false)
)

#bibliography(
  "sources.yml",
  title: none,
)
