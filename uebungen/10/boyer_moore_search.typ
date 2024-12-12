#import "/config.typ": theme
#import "components.typ": anchors, txt
#import "@preview/cetz:0.3.1"

#set text(font: "Noto Sans Mono")

#let t = "ALGORITHMEN UND DATENSTRUKTUREN"
#let p = "DATEN"

#let bc_shift = (:)
#for (i, c) in p.clusters().enumerate() {
  bc_shift.insert(c, p.len() - i - 1)
}

#txt(t)

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  anchors(t, p)

  let count = 0

  let i = p.len() - 1
  while i < t.len() {
    let mismatch = none
    for (j, c) in p.clusters().rev().enumerate() {
      line(
        "t."+str(i - j),
        "p."+str(p.len()-1-j),
        mark: (end: "straight"),
        stroke: if (c == t.at(i - j)) {
          theme.success
        } else {
          theme.fg_medium
        }
      )

      if c != t.at(i - j) {
        mismatch = t.at(i - j)
        break
      }
    }
    if mismatch != none {
      i += calc.max(
        1,
        bc_shift.at(mismatch, default: p.len())
      )
    } else {
      i += 1
    }
  }
})

#txt(p)