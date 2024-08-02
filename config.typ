#let config = doc => {
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

  show math.equation: set text(font: "Noto Sans Math")

  show heading: h => {
    set text(font: "Noto Serif", size: 20pt)
    set block(above: 12pt, below: 12pt)
    block[
      #if h.numbering == none {
        text(h.body)
      } else if h.level <= 2 {
        let c = counter(heading).display(h.numbering)
        set text(weight: "light")
        text(c, weight: "black")
        text(" ")
        text(h.body)
      } else {
        text(h.body, weight: "black")
      }
    ]
  }

  show raw.where(block: true): it => {
    set table(fill: (_, y) => if calc.odd(y) { rgb(0, 0, 0, 5%) })
    block(
      stroke: rgb(0, 0, 0, 20%),
      radius: 4pt,
      above: 8pt,
      below: 8pt,
      breakable: false,
      table(
        columns: 1fr,
        stroke: none,
        inset: (x: 8pt, y: 6pt),
        ..it.lines
      )
    )
  }

  show raw.where(block: false): box.with(
    fill: rgb(0, 0, 0, 6%), 
    stroke: rgb(0, 0, 0, 12%),
    outset: (y: 4pt), 
    inset: (x: 4pt), 
    radius: 4pt,
  )

  doc
}

#let page = doc => {
  set page(columns: 2)
  doc
}