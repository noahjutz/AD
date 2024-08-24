#let code(code, comments) = {
  show table.cell.where(x: 0): set text(font: "Noto Sans Mono")

  let lines = code.split("\n")
  // let first_index = comments.at(0).at(0)
  // if first_index > 0 {
  //   comments.insert(0, (0, first_index - 1, ""))
  // }
  // let last_index = comments.last().at(1)
  // if last_index < lines.len() - 1 {
  //   comments.push((last_index + 1, lines.len() - 1, ""))
  // }
  let i = 0
  let j = 0
  while i < lines.len() and j < comments.len() {
    let (s, e, txt) = comments.at(j)
    if i < s {
      comments.insert(j, (i, s - 1, ""))
    }
    i = e+1
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
    stroke: rgb(0, 0, 0, 20%),
    radius: 4pt,
    above: 8pt,
    below: 8pt,
    breakable: false,
    table(
      columns: (auto, 1fr),
      stroke: (x, y) => {
        if x == 0 {(right: 1pt + rgb(0,0,0,20%))}
        else if y != lines.len()-1 {(bottom: 1pt + rgb(0,0,0,20%))}
      },
      fill: (x, y) => {
        if x == 0 and calc.odd(y) { rgb(0, 0, 0, 5%) }
      },
      inset: (x: 8pt, y: 6pt),
      ..cells
    )
  )
}