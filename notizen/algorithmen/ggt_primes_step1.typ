#import "@preview/cetz:0.2.2": canvas, draw

#let cell = (a, b, x) => [
  #show table.cell.where(x: 2): strong
  #table(
    columns: (40pt,) * 3,
    // stroke: (x, y) => {
    //   if (x != 2) {1pt}
    // },
    str(a), str(b), str(x)
  )
]

#canvas(length: 40pt, {
  import draw: *

  set-style(mark: (end: "straight"))

  group(anchor: "north-west", {
    content(
      (),
      name: "1",
      cell(3528, 3780, 1)
    )
    content(
      (rel: (0, -1)),
      name: "2",
      cell(1764, 1890, 2)
    )
    content(
      (rel: (0, -1)),
      name: "3",
      cell(882, 945, 4)
    )
    content(
      (rel: (0, -1)),
      name: "4",
      cell(98, 105, 45)
    )
    content(
      (rel: (0, -1)),
      name: "5",
      cell(14, 15, 252)
    )
    line("1", "2", name: "12")
    line("2", "3", name: "23")
    line("3", "4", name: "34")
    line("4", "5", name: "45")
    content("12.mid", anchor: "east", padding: 4pt)[$div 2$]
    content("12.mid", anchor: "west", padding: 4pt)[$dot 2$]
    content("23.mid", anchor: "east", padding: 4pt)[$div 2$]
    content("23.mid", anchor: "west", padding: 4pt)[$dot 2$]
    content("34.mid", anchor: "east", padding: 4pt)[$div 9$]
    content("34.mid", anchor: "west", padding: 4pt)[$dot 9$]
    content("45.mid", anchor: "west", padding: 4pt)[...]
  })

})