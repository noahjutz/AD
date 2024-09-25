#let theme = (
  primary: red,
  primary_light: red.lighten(75%),
  primary_trans: red.transparentize(75%),
  secondary: blue,
  secondary_light: blue.lighten(75%),
  secondary_trans: blue.transparentize(75%),
  fg: black,
  fg_light: black.lighten(50%),
  fg_trans: black.transparentize(50%),
  bg_light: black.lighten(90%),
  bg_trans: black.transparentize(90%)
)

#let config(doc) = {
  set text(
    lang: "de",
    font: "Noto Sans",
    hyphenate: true
  )

  set par(justify: true)
  show figure: set par(justify: false)

  set outline(
    indent: true,
    depth: 2,
    title: "",
  )

  show outline: columns.with(2)

  set footnote.entry(separator: none)

  show math.equation.where(block: true): set align(start)
  show math.equation: set text(font: "Fira Math")

  set heading(numbering: (..nums) => {
    if nums.pos().len() <= 2 {
      numbering("1.1", ..nums)
    } else { none }
  })
  show heading.where(level: 4): set heading(outlined: false)
  show heading: h => {
    set text(font: "Noto Serif", size: 20pt)
    set block(above: 12pt, below: 12pt)
    set par(justify: false)
    block({
      if h.numbering == none {
        text(h.body)
      } else if h.level <= 2 {
        let c = counter(heading).display(h.numbering)
        set text(weight: "light")
        text(c, weight: "black")
        text(" ")
        text(h.body)
      } else if h.level == 3 {
        text(
          h.body,
          weight: "black",
          size: 11pt
        )
      } else {
        text(
          h.body,
          size: 11pt,
          weight: "light",
          font: "Noto Sans",
          style: "italic"
        )
      }
      if h.has("label") {
        let refs = query(ref.where(target: h.label))
        if refs.len() != 0 {
          text(" ")
          let target = refs.first().location()
          link(target, sym.arrow.t.stop)
        }
      }
    })
  }

  show raw: set text(font: "Noto Sans Mono")
  show raw.where(block: false): set text(size: 11pt)
  show raw.where(block: true): it => {
    set par(justify: false)
    block(
      stroke: rgb(0, 0, 0, 20%),
      radius: 4pt,
      above: 8pt,
      below: 8pt,
      table(
        columns: 1fr,
        stroke: none,
        fill: (_, y) => if calc.odd(y) { rgb(0, 0, 0, 5%) },
        inset: (x: 8pt, y: 6pt),
        ..it.lines.map(l => if l.text.len() == 0 {hide("a")} else {l})
      )
    )
  }

  show bibliography: set par(justify: false)
  
  doc
}
