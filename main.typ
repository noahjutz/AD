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
  include "notizen/algorithmen/main.typ"
  include "notizen/komplexitaet/main.typ"
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
}

#pagebreak()
#title
#heading(numbering: none)[
  #text(weight: 100, size: 40pt)[Appendix]
] <appendix>
#outline(
  target: selector(heading)
    .after(<appendix>, inclusive: false)
)

#{
  counter(heading).update(0)
  pagebreak()
  include "appendix/proof/main.typ"
  pagebreak()
  show: columns.with(2)
  include "appendix/examples/main.typ"
}