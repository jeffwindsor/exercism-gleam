import gleam/list

pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

type Direction(a) {
  Left(value: a, other_way: Tree(a))
  Right(value: a, other_way: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(focus: Tree(a), path_queue: List(Direction(a)))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(tree, [])
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper.focus {
    Node(a, ..) -> Ok(a)
    Leaf -> Error(Nil)
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.path_queue {
    [] -> Error(Nil)
    [Left(v, o), ..pq] ->
      Ok(Zipper(focus: Node(v, zipper.focus, o), path_queue: pq))
    [Right(v, o), ..pq] ->
      Ok(Zipper(focus: Node(v, o, zipper.focus), path_queue: pq))
  }
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case up(zipper) {
    // end case - return tree at root
    Error(Nil) -> zipper.focus
    // travel up the tree
    Ok(parent) -> to_tree(parent)
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, right) -> {
      let new_path = list.prepend(zipper.path_queue, Left(value, right))
      Ok(Zipper(left, new_path))
    }
    Leaf -> Error(Nil)
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, right) -> {
      let new_path = list.prepend(zipper.path_queue, Right(value, left))
      Ok(Zipper(right, new_path))
    }
    Leaf -> Error(Nil)
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper.focus {
    Node(_, left, right) -> Zipper(Node(value, left, right), zipper.path_queue)
    Leaf -> Zipper(Node(value, Leaf, Leaf), zipper.path_queue)
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, _, right) ->
      Ok(Zipper(Node(value, tree, right), zipper.path_queue))
    Leaf -> Error(Nil)
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Node(value, left, _) ->
      Ok(Zipper(Node(value, left, tree), zipper.path_queue))
    Leaf -> Error(Nil)
  }
}
