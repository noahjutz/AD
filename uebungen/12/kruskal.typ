#import "components.typ"
#import "@preview/diagraph:0.3.0": render
#import "@preview/oxifmt:0.2.1": strfmt

#let edges = components.sample_edges()
#let nodes = components.sample_mst_nodes()

// Values describe parent if string, set cardinality if int
#let sets = (
  "0": 0,
  "1": 0,
  "2": 0,
  "3": 0,
  "4": 0,
  "5": 0,
  "6": 0,
  "7": 0,
  "8": 0,
)

#let sets_tree(sets) = render(
  engine: "neato",
  strfmt(
    "digraph {{
      node [
        fontname=\"Noto Sans\"
        margin=0
        height=0.25
        width=0.25
        shape=circle
      ]
      edge [
        fontname=\"Noto Sans\"
        len=.5
        arrowhead=open
        arrowtail=open
      ]
      {}
      {}
    }}",
    nodes.keys().join(" "),
    sets.pairs()
      .filter(((v, u)) => type(u) == str)
      .map(((v, u)) => strfmt("{}->{}", v, u))
      .join(" ")
  )
)

#let canonical(node, sets) = {
  let ref = sets.at(str(node))
  if type(ref) == int {
    return int(node)
  } else {
    return canonical(ref, sets)
  }
}

#let union(u, v, sets) = {
  u = canonical(u, sets)
  v = canonical(v, sets)
  let h_u = sets.at(str(u))
  let h_v = sets.at(str(v))
  if h_u == h_v {
    sets.at(str(v)) += 1
  }
  if h_u <= h_v {
    sets.at(str(u)) = str(v)
  } else {
    sets.at(str(v)) = str(u)
  }
  return sets
}

#let drawings = ()

#let visited = ()
#let connected = ()

#for (u, v, w) in edges.sorted(key: e => e.at(2)) {
  if canonical(u, sets) != canonical(v, sets) {
    sets = union(u, v, sets)
    connected.push((u, v))
  } else {
    visited.push((u, v))
  }

  drawings.push(components.dag(
    nodes, edges,
    hl_edge_p: ((u, v),),
    hl_edge_s: connected,
    hl_edge_g: visited,
  ))

  drawings.push(sets_tree(sets))

  // early exit condition
  if connected.flatten().dedup().sorted() == nodes.keys().map(n => int(n)).sorted() {
    break
  }
}

#drawings.push(components.dag(
  nodes, edges,
  hl_edge_s: connected,
  hl_edge_g: visited,
))

#grid(
  columns: 2,
  align: center + horizon,
  ..drawings.map(d => scale(50%, d, reflow: true))
)