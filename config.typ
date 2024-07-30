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

  doc
}

#let config2 = doc => {
  set heading(numbering: (..nums) => {
    if nums.pos().len() <= 3 {
      numbering("1.1", ..nums)
    } else { none }
  })

  show heading: h => {
  set text(font: "Noto Serif", size: 20pt)
    set block(above: 12pt, below: 12pt)
    block[
      #if h.numbering == none {
        text(h.body)
      } else if h.level <= 3 {
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

  doc
}