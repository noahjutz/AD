#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#show: columns.with(2, gutter: 24pt)

#let node_status = (
  unvisited: 0,
  visited: 1,
  in_queue: 2
)

#let bg(status) = {
  if status == node_status.unvisited {
    white
  } else if status == node_status.visited {
    black
  } else if status == node_status.in_queue {
    theme.fg_medium
  }
}

#let fg(status) = {
  if status == node_status.unvisited {
    black
  } else if status == node_status.visited {
    white
  } else if status == node_status.in_queue {
    black
  }
}

#let nodes = range(9).map(n => (str(n), node_status.unvisited)).to-dict()
#let edges = (
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

#let ang(i, n) = i*360/n * 1deg

#let graph(nodes, edges, hl: ()) = diagram({
	let n = nodes.len()
	for (i, key) in nodes.keys().enumerate() {
		let a = ang(i, n)
		node(
      (a, 48pt),
      text(fill: fg(nodes.at(key)), key),
      stroke: 0.5pt,
      name: str(i),
      fill: bg(nodes.at(key))
    )
	}
	for from in range(edges.len()) {
		for to in edges.at(from) {
			let bend = 35deg
			if calc.rem(from - to + n, n) < n/2 {bend *= -1}
			edge(
				label(str(from)),
				label(str(to)),
				"->",
				bend: bend,
				stroke: if (from, to) in hl {theme.primary} else {theme.fg_medium}
			)
		}
	}
})

#let queue = (0,)
#while queue.len() > 0 {
	let from = queue.remove(0)
  let targets = edges.at(from).filter(node => nodes.at(str(node)) == node_status.unvisited)
  nodes.at(str(from)) = node_status.visited
  for key in targets {
    queue.push(key)
    nodes.at(str(key)) = node_status.in_queue
  }
	graph(
    nodes,
    edges,
    hl: targets.map(t => (from, t))
  )
}