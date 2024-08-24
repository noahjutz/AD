#import "/config.typ": config, theme
#show: config

#let sieve(d, n: 51) = table(
  columns: 10,
  align: center,
  "", ..range(2, n).map(i =>{
    if d == 0 {
      return str(i)
    }

    if i == d {
      table.cell(fill: theme.secondary, str(i))
    } else if range(2, d).any(j => calc.rem(i, j) == 0 and i != j) {
      table.cell(fill: gray, str(i))
    } else if calc.rem(i, d) == 0 {
      table.cell(fill: theme.primary, str(i))
    } else  if i < d {
      strong(str(i))
    } else {
      str(i)
    }
  })
)

#sieve(2)