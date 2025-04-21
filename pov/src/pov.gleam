import gleam/io
import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

fn dfs(tree: Tree(a), target: a) -> Result(List(Tree(a)), Nil) {
  tree.children
  |> list.find_map(fn(child) {
    dfs(child, target)
    |> result.map(fn(path) { [tree, ..path] })
  })
}

pub fn rebuild(path: List(Tree(a))) -> Result(Tree(a), Nil) {
  case path |> list.reverse() {
    [] -> Error(Nil)
    [last] -> Ok(last)
    [last, ..rest] -> {
      let rebuilt =
        list.fold(rest, last, fn(parent, child_subtree) {
          let Tree(label: parent_label, children: siblings) = parent

          let remaining_siblings =
            list.filter(siblings, fn(s) { s != child_subtree })

          Tree(label: parent_label, children: [
            child_subtree,
            ..remaining_siblings
          ])
        })

      Ok(rebuilt)
    }
  }
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  case tree.label {
    // no-op case
    l if l == from -> Ok(tree)
    // go case
    _ -> {
      let result = dfs(tree, from)
      io.debug(result)
      case result {
        // rebuild path expects path from new root to old root
        Ok(path) -> rebuild(path)
        _ -> Error(Nil)
      }
    }
  }
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  todo
}
