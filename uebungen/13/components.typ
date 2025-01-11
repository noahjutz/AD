#import "/config.typ": theme
#import "@preview/diagraph:0.3.0": render
#import "@preview/oxifmt:0.2.1": strfmt

#let n = 6

#let adjacency_matrix = (
  (0, calc.inf, calc.inf, calc.inf, -1, calc.inf),
  (1, 0, calc.inf, 2, calc.inf, calc.inf),
  (calc.inf, 2, 0, calc.inf, calc.inf, -8),
  (-4, calc.inf, calc.inf, 0, 3, calc.inf),
  (calc.inf, 7, calc.inf, calc.inf, 0, calc.inf),
  (calc.inf, 5, 10, calc.inf, calc.inf, 0),
)

#let mat(m, hl: none) = context layout(((width, height)) => {
  set block(breakable: false)
  let t = table(
    columns: m.len() * (1fr,),
    align: center,
    stroke: theme.fg_light,
    ..m.enumerate().map(((i, row)) => {
      row.enumerate().map(((j, x)) => {
        table.cell(
          fill: if hl != none and hl.at(i).at(j) {
            theme.primary_light
          }
        )[$#x$]
      })
    }).flatten()
  )
  t
  let (width, height) = measure(width: width, height: height, t)
  place(top + left, path(
    (6pt, 0pt),
    (0pt, 0pt),
    (0pt, height),
    (6pt, height)
  ))
  place(top + right, path(
    (-6pt, 0pt),
    (0pt, 0pt),
    (0pt, height),
    (-6pt, height)
  ))
})

#let graph(w, d, p, k, hl: none) = context layout(((width, height)) => {
  let n = d.len()
  let graphviz_str = strfmt(
    "digraph {{
      node [fontname=\"Noto Sans\", height=0, margin=.01, shape=circle]
      edge [arrowhead=vee]
      {} // Nodes
      {} // Edges
    }}",
    range(n).map(i => {
      strfmt(
        "{} [color=\"{}\"]",
        i+1,
        if i+1 == k {theme.primary.to-hex()} else {"black"}
      )
    }).join(" "),
    range(n).map(i => range(n).map(j => {
      if i != j and w.at(i).at(j) < calc.inf {
        strfmt(
          "{} -> {} [label={}]",
          i+1, j+1, w.at(i).at(j),
        )
      }
    })).flatten().filter(it => it != none).join(" ")
  )
  let graph_size = measure(render(
    graphviz_str,
    engine: "neato"
  ))
  let is_landscape = graph_size.width > graph_size.height
  render(
    graphviz_str,
    engine: "neato",
    width: if is_landscape {width} else {auto},
    height: if is_landscape {auto} else {width}
  )
})