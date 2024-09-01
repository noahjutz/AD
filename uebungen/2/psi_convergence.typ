#import "@preview/cetz:0.2.2"

#let rational(n) = {
  let p = n // numerator
  let q = 1 // denominator

  while calc.rem(p, 10) != 0 and p < calc.pow(2, 59) {
    p *= 10
    q *= 10
  }
  p = int(p)
  
  let divisor = calc.gcd(p, q)
  p /= divisor
  q /= divisor

  return (p, q)
}

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.plot

  plot.plot(
    axis-style: none,
    size: (1, .3), {
    let psi = -0.6180339887
    let values = range(15).map(x => (x, calc.pow(psi, x)))
    plot.add(
      values,
      style: (stroke: none),
      mark: "o",
      mark-size: 4pt,
      mark-style: (stroke: none, fill: black)
    )

    plot.add(
      domain: (1, 15),
      x => {
        let (p, q) = rational(x)
        if calc.rem(q, 2) == 0 {
          return -1
        }
        return calc.pow(psi, x)
      }
    )
  })
})