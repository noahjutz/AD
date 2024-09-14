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
  show figure: set par(justify: false)

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

  show ref: ref => {
    let is_after(target, point) = {
      return query(selector(target).after(point)).len() != 0
    }
    let a = if is_after(ref.target, <appendix>) {
      "A"
    } else if is_after(ref.target, <uebungen>) {
      "Ü"
    } else if is_after(ref.target, <notizen>) {
      "N"
    }
    let icon = if is_after(ref.target, here()) {
      "vertical_align_bottom"
    } else {
      "vertical_align_top"
    }
    let numbering = if ref.element.numbering == none {
      ""
    } else {
      numbering(
        ref.element.numbering,
        ..counter(heading).at(ref.target)
      )
    }
    link(
      ref.target,
      box(
        stroke: theme.primary,
        outset: (y: 2pt),
        inset: (x: 6pt),
        radius: 2pt
      )[
        #set align(horizon)
        #stack(
          dir: ltr,
          text(a),
          text(numbering),
          text(font: "Material Icons", icon)
        )
      ]
    )
  }

  doc
}
