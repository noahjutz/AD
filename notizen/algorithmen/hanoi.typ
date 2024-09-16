#import "@preview/cetz:0.2.2"

#let n = 5

#let disks = (
  A: range(1, 6)
)

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  let height = n * 8pt + 8pt

  set-style(content: (padding: 4pt))

  line((), (1, 0))

  circle((1/6, 0), radius: 0, name: "A")
  circle((3/6, 0), radius: 0, name: "B")
  circle((5/6, 0), radius: 0, name: "C")

  for peg in ("A", "B", "C") {
    content(peg, anchor: "north", peg)
    line(peg, (rel: (0, height)))

    let disks = disks.at(peg, default: ())
    move-to(peg)
    for disk in disks.rev() {
      assert(disk <= n)
      let length = disk/(4*n)
      move-to((rel: (-length/2, 8pt)))
      line((), (rel: (length, 0)), stroke: 4pt)
      move-to((rel: (-length/2, 0)))
    }
  }
})