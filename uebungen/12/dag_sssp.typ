#import "/config.typ": theme
#import "@preview/diagraph:0.3.0": render
#import "@preview/oxifmt:0.2.1": strfmt

#let nodes = (
  "0": (d: 0, p: none),
  "1": (d: calc.inf, p: none),
  "2": (d: calc.inf, p: none),
  "3": (d: calc.inf, p: none),
  "4": (d: calc.inf, p: none),
  "5": (d: calc.inf, p: none),
  "6": (d: calc.inf, p: none),
  "7": (d: calc.inf, p: none),
  "8": (d: calc.inf, p: none)
)

#let edges = (
  (0, 1, 12),
  (0, 8, 3),
  (1, 3, 5),
  (1, 8, 4),
  (2, 3, 8),
  (2, 4, 14),
  (2, 6, 6),
  (2, 7, 3),
  (2, 8, 12),
  (3, 4, 1),
  (3, 6, 8),
  (4, 5, 1),
  (4, 6, 11),
  (5, 6, 10),
  (6, 7, 17),
  (7, 8, 4)
)

#let to_graphviz_color(color) = {
  strfmt("\"{}\"", color.to-hex())
}

#let labels(nodes) = {
  for key in nodes.keys() {
    let n = nodes.at(key).at("d")
    nodes.at(key) = if n == calc.inf {$infinity$} else {str(n)}
  }
  return nodes
}

#let dag(nodes, adjacent, current) = render(
  labels: labels(nodes),
  engine: "neato",
  strfmt(
    "digraph {{
      node [
        fontname=\"Noto Sans\"
        margin=0
        height=0.25
        width=0.25
        shape=circle
        //label=\"\"
      ]
      edge [
        fontname=\"Noto Sans\"
        len=.75
        arrowhead=open
        arrowtail=open
      ]
      graph [
      ]

      {}
    }}", 
    edges.map(((u, v, w)) => {
        let p_u = nodes.at(str(u)).at("p")
        let p_v = nodes.at(str(v)).at("p")
        let dir = if p_u == v and p_v == u {
          "both"
        } else if p_u == v {
          "back"
        } else if p_v == u {
          "forward"
        } else {
          "none"
        }
        strfmt("{}->{}[label={}, dir={}]", u, v, w, dir)
      })
      .join(" ") + " " + nodes.keys().map(v => {
        if int(v) in adjacent {
          strfmt("{}[color={},style=bold]", v, to_graphviz_color(theme.primary_light))
        } else if int(v) == current {
          strfmt("{}[color={},style=bold]", v, to_graphviz_color(theme.primary))
        }
      })
      .filter(it => it != none)
      .join(" ")
  )
)

#let drawings = ()
#let queue = (0,)

#while queue.len() > 0 {
  let node = queue.pop()
  let adj = edges.map(((v, u, w)) => if v == node {(u, w)} else if u == node {(v, w)})
    .filter(it => it != none)

  for (target, weight) in adj {
    if nodes.at(str(target)).at("d") == calc.inf {
      queue.push(target)
    }
    if nodes.at(str(target)).at("d") > nodes.at(str(node)).at("d") + weight {
      nodes.at(str(target)).at("d") = nodes.at(str(node)).at("d") + weight
      nodes.at(str(target)).at("p") = node
    }
  }
  drawings.push(dag(nodes, adj.map(a => a.at(0)), node))
}
#drawings.push(dag(nodes, (), -1))

#grid(
  columns: 2,
  align: center,
  ..drawings.map(d => scale(50%, d, reflow: true))
)