#import "components.typ"
#import "/components/lefttree.typ": lefttree, draw_node
#import "@preview/cetz:0.3.1"

#let nodes = components.sample_nodes()
#let edges = components.sample_edges()

#let draw_heap(heap) = cetz.canvas({
    import cetz.draw: *

    cetz.tree.tree(
        lefttree(heap.map(i => str(i))),
        draw-node: draw_node.with(
            hl_primary: 0
        )
    )
})

#let heapify_ttb(heap, i) = {
    let c = heap.at(i)
    let l = if heap.len() > 2*i+1 {
        heap.at(2*i+1)
    } else {calc.inf}
    let r = if heap.len() > 2*1+2 {
        heap.at(2*i+2)
    } else {calc.inf}

    let min = calc.min(c, l, r)
    if l == min {
        (heap.at(i), heap.at(2*i+1)) = (heap.at(2*i+1), heap.at(i))
    } else if r == min {
        (heap.at(i), heap.at(2*i+2)) = (heap.at(2*i+2), heap.at(i))
    }
    return heap
}

#let pop_min(heap) = {
    heap.remove(0)
    if heap.len() > 0 {
        let hi = heap.len()-1
        (heap.at(0), heap.at(hi)) = (heap.at(hi), heap.at(0))
    }
    if heap.len() > 0 {
        heap = heapify_ttb(heap, 0)
    }
    return heap
}

#let get_min(heap) = {
    let min = heap.at(0)
    return min
}

#let drawings = ()

#let heap = nodes.keys().map(n => int(n))

#scale(50%, reflow: true)[
    #components.dag(
        nodes,
        edges
    )
]

#while heap.len() > 0 {
    let node = get_min(heap)
    let heap_before = heap
    heap = pop_min(heap)

    let adj = edges.filter(((u, v, w)) => u == node or v == node)

    for (u, v, w) in adj {
        let other = if (node == u) {v} else {u}
        if nodes.at(str(other)).at("d") > nodes.at(str(node)).at("d") + w {
            nodes.at(str(other)).at("d") = nodes.at(str(node)).at("d") + w
            nodes.at(str(other)).at("p") = node
        }
    }

    drawings.push(components.dag(
        nodes,
        edges,
        hl_node_p: (node,),
        hl_edge_p: adj.map(((u, v, w)) => (u, v))
    ))

    if heap.len() > 0 {
        drawings.push(
            draw_heap(heap_before)
        )
    }
}

#grid(
    columns: 2,
    align: center + horizon,
    ..drawings.map(d => scale(50%, d, reflow: true))
)