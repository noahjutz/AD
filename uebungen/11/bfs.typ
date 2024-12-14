#import "components.typ": graph, node_status

#show: columns.with(2, gutter: 24pt)
#set block(spacing: 8pt)
#show math.equation: set align(center)

#let nodes = range(9).map(n => (str(n), node_status.unvisited)).to-dict()
#let adj_list = (
	(1, 2, 6),
	(3,),
	(0, 3, 4),
	(6,),
	(0, 5, 8),
	(2, 3, 4, 7),
	(7,),
	(3, 8),
	(5,)
)

#let queue = (0,)

#graph(
  nodes,
  adj_list,
  arr: queue
)

#while queue.len() > 0 {
	let from = queue.remove(0)
  let targets = adj_list.at(from).filter(node => nodes.at(str(node)) == node_status.unvisited)
  nodes.at(str(from)) = node_status.current
  for key in targets {
    queue.push(key)
    nodes.at(str(key)) = node_status.in_queue
  }

	graph(
    nodes,
    adj_list,
    hl: targets.map(t => (from, t)),
    arr: queue
  )

  nodes.at(str(from)) = node_status.visited
}