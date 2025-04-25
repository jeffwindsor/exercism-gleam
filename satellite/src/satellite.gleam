// import gleam/bool.{guard}
import gleam/list
import gleam/pair
import gleam/set

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  let io_l = list.length(inorder)
  let po_l = list.length(preorder)
  let io_unique = set.from_list(inorder)
  let po_unique = set.from_list(preorder)
  let io_unique_l = set.size(set.from_list(inorder))
  let po_unique_l = set.size(set.from_list(preorder))

  case
    io_l == po_l,
    io_unique == po_unique,
    io_unique_l == io_l && po_unique_l == po_l
  {
    False, _, _ -> Error(DifferentLengths)
    _, False, _ -> Error(DifferentItems)
    _, _, False -> Error(NonUniqueItems)
    _, _, _ -> Ok(traverse(inorder, preorder))
  }
}

fn traverse(in: List(a), preorder: List(a)) -> Tree(a) {
  case preorder {
    [] -> Nil

    [item, ..pre] -> {
      let #(left_in, right_in) =
        pair.map_second(list.split_while(in, fn(i) { i != item }), list.drop(
          _,
          1,
        ))

      let #(left_pre, right_pre) =
        list.split_while(pre, list.contains(left_in, _))

      Node(item, traverse(left_in, left_pre), traverse(right_in, right_pre))
    }
  }
}
