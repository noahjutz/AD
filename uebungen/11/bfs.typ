#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#show: columns.with(2, gutter: 24pt)
#set block(spacing: 8pt)
#show math.equation: set align(center)

#let node_status = (
  unvisited: 0,
  visited: 1,
  in_queue: 2,
  current: 3
)

#let bg(status) = {
  if status == node_status.unvisited {
    white
  } else if status == node_status.visited {
    black
  } else if status == node_status.in_queue {
    theme.fg_medium
  } else if status == node_status.current {
    black
  }
}

#let fg(status) = {
  if status == node_status.unvisited {
    black
  } else if status == node_status.visited {
    white
  } else if status == node_status.in_queue {
    black
  } else if status == node_status.current {
    white
  }
}

#let stroke(status) = {
  if status == node_status.current {
    theme.primary + 2pt
  } else {
    black + .5pt
  }
}

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

#let ang(i, n) = i*360/n * 1deg

#let graph(nodes, adj_list, hl: ()) = diagram({
	let n = nodes.len()
	for (i, key) in nodes.keys().enumerate() {
		let a = ang(i, n)
		node(
      (a, 40pt),
      text(fill: fg(nodes.at(key)), key),
      name: str(i),
      fill: bg(nodes.at(key)),
      stroke: stroke(nodes.at(key))
    )
	}
	for from in range(adj_list.len()) {
		for to in adj_list.at(from) {
			let bend = 35deg
			if calc.rem(from - to + n, n) < n/2 {bend *= -1}
			edge(
				label(str(from)),
				label(str(to)),
				"->",
				bend: bend,
				stroke: if (from, to) in hl {theme.primary + 1pt} else {theme.fg_medium + .5pt}
			)
		}
	}
})

#let queue = (0,)

#graph(
  nodes,
  adj_list,
)
$ Q = (#{queue.map(i => $#i$).join($,$)}) $

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
    hl: targets.map(t => (from, t))
  )

  $ Q = (#{queue.map(i => $#i$).join($,$)}) $
  nodes.at(str(from)) = node_status.visited
}