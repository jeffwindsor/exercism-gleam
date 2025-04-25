import gleam/int
import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  Nil |> add_values(data)
}

fn add_values(tree: Tree, values: List(Int)) -> Tree {
  case values {
    [] -> tree
    [first, ..rest] -> {
      tree
      |> add_value(first)
      |> add_values(rest)
    }
  }
}

fn add_value(tree: Tree, value: Int) -> Tree {
  case tree {
    Nil -> Node(value, Nil, Nil)
    // value goes left if less than or equal to parent 
    Node(data, left, right) -> {
      case value <= data {
        True -> Node(data, add_value(left, value), right)
        False -> Node(data, left, add_value(right, value))
      }
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  // not sure what this is supposed to do in reference to the rest of the problem
  list.sort(data, int.compare)
}
