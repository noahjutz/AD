#import "config.typ"

#set heading(numbering: (..nums) => {
  if nums.pos().len() <= 2 {
    numbering("1.1", ..nums)
  } else { none }
})

#set text(
  lang: "de",
  font: "Noto Sans",
  hyphenate: true
)

#show heading: h => {
  //#numbering(h.numbering, h.)
  if h.level <= 2 and h.numbering != none {
    let c = counter(heading).display(h.numbering)
    set text(size: 24pt)
    text(c, weight: "black", fill: config.color_primary)
    text(" ")
    text(h.body, weight: "light")
  } else {
    text(h.body)
  }
}

#[
  #set par(leading: .3em)
  #set text(font: "Noto Serif", size: 40pt)
  #text(weight: 100)[Noah Jutz] \
  #text(weight: 900)[Algorithmen und \ Datenstrukturen] \
  #text(weight: 100)[Notizen]
]

#outline(indent: true, depth: 2)

#pagebreak()

= Grundlagen

== kgV / ggT

=== kgV

