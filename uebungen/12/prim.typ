#import "components.typ"
#import "/components/lefttree.typ": lefttree, draw_node
#import "@preview/cetz:0.3.1"

#let nodes = components.sample_nodes()
#let edges = components.sample_edges()

#let draw_heap(heap) = cetz.canvas({
    import cetz.draw: *

    set-style(content: (frame: "circle", padding: 2pt))
    cetz.tree.tree(
        lefttree(heap.map(i => align(center, stack(
            spacing: 4pt,
            $v_#{i.at(0)}$,
            if i.at(1) == calc.inf {$infinity$} else {$#i.at(1)$}
        )))),
        spread: 1.5,
        grow: 1.5
    )
})

#let heapify_ttb(heap, i) = {
    let c = heap.at(i)
    let l = if heap.len() > 2*i+1 {
        heap.at(2*i+1)
    } else {(-1, calc.inf)}
    let r = if heap.len() > 2*i+2 {
        heap.at(2*i+2)
    } else {(-1, calc.inf)}

    let min = c
    if l.at(1) < min.at(1) {min = l}
    if r.at(1) < min.at(1) {min = r}
    if l == min {
        (heap.at(i), heap.at(2*i+1)) = (heap.at(2*i+1), heap.at(i))
        heap = heapify_ttb(heap, 2*i+1)
    } else if r == min {
        (heap.at(i), heap.at(2*i+2)) = (heap.at(2*i+2), heap.at(i))
        heap = heapify_ttb(heap, 2*i+2)
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
    return heap.at(0)
}

#let decrease_key(heap, i, val) = {
    i = heap.position(((v, val)) => v == i)
    if i != none {
        heap.at(i).at(1) = val
        return heapify_ttb(heap, i)
    } else {
        return heap
    }
}

#let drawings = ()

#let heap = nodes.pairs().map(((v, props)) => (int(v), props.d))

#drawings.push(components.dag(
    nodes,
    edges
))

#drawings.push(draw_heap(heap))

#while heap.len() > 0 {
    let (node, weight) = get_min(heap)

    let adj = edges.filter(((u, v, w)) => u == node or v == node)

    for (u, v, w) in adj {
        let other = if (node == u) {v} else {u}
        let new_weight = weight + w
        if nodes.at(str(other)).d > new_weight {
            nodes.at(str(other)).d = new_weight
            nodes.at(str(other)).p = node
            heap = decrease_key(heap, other, new_weight)
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
            draw_heap(heap)
        )
    }
    heap = pop_min(heap)
}

#grid(
    columns: 2,
    align: center + horizon,
    ..drawings.map(d => scale(50%, d, reflow: true))
)