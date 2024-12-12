#import "components.typ": anchors, txt
#import "@preview/cetz:0.3.1"

#set text(font: "Noto Sans Mono")

#let t = "ALGORITHMEN UND DATENSTRUKTUREN"
#let p = "DATEN"

#let n = t.len()
#let m = p.len()

#let bc_shift = (:)

#for (i, c) in p.clusters().enumerate() {
  bc_shift.insert(c, i)
}

#txt(t)

#cetz.canvas(length: 100%, {

})

#txt(p)