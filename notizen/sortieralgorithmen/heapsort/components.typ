#let bintree(nodes, i: 0) = {
  let node = (nodes.at(i),)
  if nodes.len() > 2 * i + 1 {
    node.push(bintree(nodes, i: 2*i+1))
  }
  if nodes.len() > 2*i+2 {
    node.push(bintree(nodes, i: 2*i+2))
  }
  return node
}

#let name_to_index(name) = {
  let turns = name.split("-").map(s => int(s)).slice(1)
  let i = 0
  for turn in turns {
    if turn == 0 {
      i = 2*i+1
    } else {
      i = 2*i+2
    }
  }
  return i
}

#let index_to_name(index) = {
  if index == 0 {
    return "0"
  }
  let turns = ()
  while index > 0 {
    let is_right = calc.rem(index, 2) == 0

    if is_right {
      turns.push("1")
    } else {
      turns.push("0")
    }
    index = calc.div-euclid(index - 1, 2)
  }
  turns = turns.rev()
  return "0-" + turns.join("-")
}