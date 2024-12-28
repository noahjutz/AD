#import "components.typ"

#let edges = components.sample_edges()
#let nodes = components.sample_nodes()

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

#let visited = ()

#for (u, v, w) in edges.sorted(key: e => e.at(2)) {
  if canonical(u, sets) != canonical(v, sets) {
    sets = union(u, v, sets)
  }

  components.dag(
    nodes, edges,
    hl_edge_p: ((u, v),),
    hl_edge_s: visited
  )

  visited.push((u, v))
}