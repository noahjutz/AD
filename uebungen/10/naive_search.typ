#import "/config.typ": theme
#import "components.typ": anchors, txt
#import "@preview/cetz:0.3.1"

#set text(font: "Noto Sans Mono")

#let t = "ALGORITHMEN UND DATENSTRUKTUREN"
#let p = "DATEN"

#txt(t)

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  anchors(t, p)

  let i = 0
  while i < t.len() {
    for j in range(p.len()) {
      let character_matches = t.at(i+j) == p.at(j)
      line(
        "t." + str(i+j),
        "p." + str(j),
        stroke: if character_matches {theme.success} else {theme.fg_medium},
        mark: (end: "straight")
      )
      if not character_matches {
        break
      }
      if j == p.len()-1 {
        i += p.len()-1
      }
    }
    i += 1
  }
})

#txt(p)