#import "components.typ"
#import "/components/lefttree.typ": lefttree
#import "@preview/cetz:0.3.1"

#let nodes = components.sample_mst_nodes()
#let edges = components.sample_edges()

#let draw_heap(heap) = cetz.canvas({
    import cetz.draw: *

    set-style(content: (frame: "circle", padding: 2pt))
    cetz.tree.tree(
        lefttree(heap.map(i => str(i))),
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

#let heap = (0,)

#components.dag(
    nodes,
    edges
)

#draw_heap(heap)

#while heap.len() > 0 {
    let node = get_min(heap)
    heap = pop_min(heap)

    components.dag(
        nodes,
        edges
    )

    if heap.len() > 0 {
        draw_heap(heap)
    }
}