#import "@preview/cetz:0.3.1"

#let _hanoi(
  n, 
  disks,
  arrow
) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  let spacing = 8pt
  let height = (n+1)*spacing

  set-style(content: (padding: 4pt))

  line((), (1, 0))

  circle((1/6, 0), radius: 0, name: "A")
  circle((3/6, 0), radius: 0, name: "B")
  circle((5/6, 0), radius: 0, name: "C")

  for peg in ("A", "B", "C") {
    line(peg, (rel: (0, height)), name: "peg_" + peg)

    let disks = disks.at(peg, default: ())
    move-to(peg)
    for disk in disks.rev() {
      assert(disk.size <= n)
      let length = disk.size/(3*n)
      move-to((rel: (-length/2, spacing)))
      line(
        (),
        (rel: (length, 0)),
        stroke: 4pt + disk.at("fill", default: black),
        name: peg + "_disk_" + str(disk.size)
      )
      move-to((rel: (-length/2, 0)))
    }
  }

  if arrow != none {
    assert(arrow.len() == 2)
    let (from, to) = arrow.map(p => "peg_" + p + ".end")
    line(
      (rel: (0, 6pt), to: from), 
      (rel: (0, 6pt), to: to),
      stroke: none,
      name: "arrow"
    )
    bezier-through(
      "arrow.start",
      (rel: (0, 8pt), to: "arrow.mid"),
      "arrow.end",
      mark: (end: "straight")
    )
  }
})

// n: Maximum number of disks
// a: disks on peg A
// b: disks on peg B
// c: disks on peg C
//  Each disk is a dictionary with keys size, fill
#let hanoi(
  n: auto,
  a: (),
  b: (),
  c: (),
  arrow: none
) = {
  if n == auto {
    n = calc.max(
      ..(a + b + c).map(disk => disk.size), 0
    )
  }
  _hanoi(n, (A: a, B: b, C: c), arrow)
}