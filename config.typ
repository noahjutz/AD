#let theme = (
  primary: red.lighten(50%),
  secondary: aqua
)

#let config(doc) = {
  set heading(numbering: (..nums) => {
    if nums.pos().len() <= 2 {
      numbering("1.1", ..nums)
    } else { none }
  })

  set text(
    lang: "de",
    font: "Noto Sans",
    hyphenate: true
  )

  set par(justify: true)

  set outline(
    indent: true,
    depth: 2,
    title: "",
  )

  show outline: columns.with(2)

  set footnote.entry(separator: none)

  show math.equation.where(block: true): set align(start)

  show math.equation: set text(font: "Noto Sans Math")

  show heading.where(level: 4): set heading(outlined: false)

  show heading: h => {
    set text(font: "Noto Serif", size: 20pt)
    set block(above: 12pt, below: 12pt)
    set par(justify: false)
    block[
      #if h.numbering == none {
        text(h.body)
      } else if h.level <= 2 {
        let c = counter(heading).display(h.numbering)
        set text(weight: "light")
        text(c, weight: "black")
        text(" ")
        text(h.body)
      } else if h.level == 3 {
        text(h.body, weight: "black")
      } else {
        set text(size: 11pt)
        text(h.body, weight: "black")
      }
    ]
  }

  show raw.where(block: true): it => {
    set par(justify: false)
    context {
      block(
        stroke: rgb(0, 0, 0, 20%),
        radius: 4pt,
        above: 8pt,
        below: 8pt,
        breakable: false,
        table(
          columns: if block.width == auto {auto} else {1fr},
          stroke: none,
          fill: (_, y) => if calc.odd(y) { rgb(0, 0, 0, 5%) },
          inset: (x: 8pt, y: 6pt),
          ..it.lines
        )
      )
    }
  }

  show raw.where(block: false): box.with(
    fill: rgb(0, 0, 0, 6%), 
    stroke: rgb(0, 0, 0, 12%),
    outset: (y: 4pt), 
    inset: (x: 4pt), 
    radius: 4pt,
  )

  show ref: ref => {
    let is_after(target, point) = {
      return query(selector(target).after(point)).len() != 0
    }
    let a = if is_after(ref.target, <appendix>) {
      "A"
    } else if is_after(ref.target, <uebungen>) {
      "U"
    } else if is_after(ref.target, <notizen>) {
      "N"
    }
    let value = counter(heading).at(ref.target)
    link(ref.target)[
      #text(a)#numbering(ref.element.numbering, ..value)
    ]
  }

  doc
}
