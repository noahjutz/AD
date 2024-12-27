#import "components.typ"

#let edges = components.sample_edges()
#let nodes = components.sample_nodes()

#let drawings = ()
#let queue = (0,)
#let visited = ()

#while queue.len() > 0 {
  let node = queue.remove(0)
  visited.push(node)
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
  drawings.push(
    components.dag(
      nodes,
      edges,
      hl_node_pl: adj.map(a => a.at(0)),
      hl_node_p: (node,),
      hl_node_black: visited.filter(key => {
          int(key) not in adj.map(a => a.at(0)) and int(key) != node
        })
        .map(key => int(key))
    )
  )
}
#drawings.push(components.dag(nodes, edges, hl_node_black: nodes.keys().map(s => int(s))))

#grid(
  columns: 2,
  align: center,
  ..drawings.map(d => scale(50%, d, reflow: true))
)