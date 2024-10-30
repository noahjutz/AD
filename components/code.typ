#let code(code, comments) = {
  show table.cell.where(x: 0): set text(font: "Noto Sans Mono")

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
      columns: (auto, 1fr),
      stroke: (x, y) => {
        if x == 0 {(right: 1pt + rgb(0,0,0,20%))}
        else if y != 0 {(top: 1pt + rgb(0,0,0,20%))}
      },
      fill: (x, y) => {
        if x == 0 and calc.odd(y) { rgb(0, 0, 0, 5%) }
      },
      inset: (x: 8pt, y: 6pt),
      ..cells
    )
  )
}