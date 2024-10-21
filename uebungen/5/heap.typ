#import "/config.typ": theme
#import "/components/num_row.typ": single_num_row
#import "/components/lefttree.typ": lefttree, draw_node, polygon_around, poly_fill, box_around, number, connect, bent_line, index_to_name, loop_line
#import "@preview/cetz:0.3.0"

#let heap(
  nums,
  bg_primary: (),
  bg_secondary: (),
  bg_tertiary: (),
  bg_success: (),
  hl_primary: (),
  hl_secondary: (),
  hl_tertiary: (),
  hl_success: (),
  swaps: (),
  annotations: (),
) = {
  set align(center)
  cetz.canvas({
    import cetz.tree: tree
    import cetz.draw: *

    tree(
      lefttree(
        nums.map(n => str(n)),
      ),
      spread: 1.5,
      draw-node: draw_node.with(
        hl_primary: hl_primary,
        hl_secondary: hl_secondary,
        hl_tertiary: hl_tertiary,
        hl_success: hl_success
      ),
      name: "tree"
    )

    on-layer(-1, {
      for (indices, fill) in (
        (bg_primary, theme.primary_light),
        (bg_secondary, theme.secondary_light),
        (bg_tertiary, theme.tertiary_light),
        (bg_success, theme.success_light),
      ) {
        if indices == range(nums.len()) {
          box_around(..indices, rect.with(
            stroke: none,
            fill: fill,
            radius: 14pt,
          ))
        } else if indices.len() >= 2 {
          polygon_around(
            ..indices,
            poly_fill.with(fill: fill)
          )
        }
      }
    })

    for (i, ann) in annotations {
      number(i, ann)
    }

    for (from, to) in swaps {
      if from == to {
        connect(
          from, to,
          loop_line.with(ang: 90deg)
        )
      } else {
        connect( 
          from, to,
          bent_line.with(bend: .75, mark: (symbol: ">"))
        )
      }
    }
  })

  single_num_row(
    nums,
    hl_primary: hl_primary,
    hl_secondary: hl_secondary,
    hl_tertiary: hl_tertiary,
    hl_success: hl_success
  )
}