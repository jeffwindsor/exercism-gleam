import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}

pub fn can_chain(chain: List(#(Int, Int))) -> Bool {
  let graph = build_graph(chain)

  case all_even_degrees(graph) {
    True -> is_connected(graph)
    False -> False
  }
}

fn append(maybe_others, value) {
  case maybe_others {
    None -> [value]
    Some(others) -> [value, ..others]
  }
}

fn build_graph(dominos: List(#(Int, Int))) -> Dict(Int, List(Int)) {
  list.fold(dominos, dict.new(), fn(acc, t) {
    let new_acc = dict.upsert(acc, t.0, append(_, t.1))
    dict.upsert(new_acc, t.1, append(_, t.0))
  })
}

fn all_even_degrees(graph: Dict(Int, List(Int))) -> Bool {
  dict.to_list(graph)
  |> list.all(fn(t) {
    let neighbors = t.1
    list.length(neighbors) % 2 == 0
  })
}

// DFS to check if the graph is connected
fn is_connected(graph: Dict(Int, List(Int))) -> Bool {
  let keys = dict.keys(graph)

  case list.first(keys) {
    Error(_) -> True
    Ok(start) -> {
      let visited = visit_all(start, graph, [])
      list.length(visited) == list.length(keys)
    }
  }
}

// DFS visit all reachable nodes
fn visit_all(
  node: Int,
  graph: Dict(Int, List(Int)),
  visited: List(Int),
) -> List(Int) {
  case list.contains(visited, node) {
    True -> visited
    False -> {
      let neighbors = case dict.get(graph, node) {
        Ok(n) -> n
        Error(_) -> []
      }

      list.fold(neighbors, [node, ..visited], fn(neigh, acc) {
        visit_all(acc, graph, neigh)
      })
    }
  }
}
