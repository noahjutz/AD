#import "/config.typ": theme
#let code(code, comments) = {
  set text(size: 0.8 * 11pt)
  show table.cell.where(x: 0): set text(font: "JetBrains Mono")

  let lines = code.split("\n")
  let i = 0
  let j = 0
  while i < lines.len() and j < comments.len() {
    let (start, end, _) = comments.at(j)
    if i < start {
      comments.insert(j, (i, s - 1, ""))
    }
    i = end+1
    j += 1
  }
  if i < lines.len() {
    comments.push((i, lines.len() - 1, ""))
  }
  let cells = ()
  for (start, end, txt) in comments {
    cells.push(lines.at(start))
    cells.push(table.cell(rowspan: end - start + 1, txt))
    for i in range(start+1, end+1) {
      cells.push(lines.at(i))
    }
  }
  block(
    stroke: 1pt,
    above: 8pt,
    below: 8pt,
    breakable: false,
    table(
      columns: (1fr, auto),
      stroke: (x, y) => {
        if x == 0 {(right: theme.bg_trans)}
        else if y != 0 {(top: theme.bg_trans)}
      },
      fill: (x, y) => {
        if x == 0 and calc.odd(y) { theme.bg_trans }
      },
      inset: (x: 8pt, y: 6pt),
      ..cells
    )
  )
}