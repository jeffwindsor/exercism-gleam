import gleam/int
import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  case data {
    [] -> Nil
    [first, ..rest] -> insert_many(Node(first, Nil, Nil), rest)
  }
}

fn insert(tree: Tree, value: Int) -> Tree {
  case tree {
    Nil -> Node(value, Nil, Nil)
    Node(data, left, right) -> {
      case value <= data {
        True -> Node(data, insert(left, value), right)
        False -> Node(data, left, insert(right, value))
      }
    }
  }
}

fn insert_many(tree: Tree, values: List(Int)) -> Tree {
  case values {
    [] -> tree
    [first, ..rest] -> insert_many(insert(tree, first), rest)
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  list.sort(data, int.compare)
}
