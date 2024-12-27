#import "/config.typ": theme
#import "@preview/diagraph:0.3.0": render
#import "@preview/oxifmt:0.2.1": strfmt

#let sample_nodes() = (
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

#let sample_edges() = (
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

#let dag(
  nodes,
  edges,
  hl_p: (),
  hl_pl: ()
) = render(
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
        v = int(v)
        let color = if v in hl_p {
          theme.primary
        } else if v in hl_pl {
          theme.primary_light
        } else {
          black
        }
        strfmt("{}[color={},style=bold]", v, to_graphviz_color(color))
      })
      .filter(it => it != none)
      .join(" ")
  )
)