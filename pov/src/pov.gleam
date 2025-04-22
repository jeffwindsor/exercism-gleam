import gleam/bool
import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  result.try(search(tree, from, []), list.reduce(_, switch_pov))
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  use root <- result.try(from_pov(tree, from))
  use path <- result.try(search(root, to, []))
  path |> list.map(fn(n) { n.label }) |> Ok
}

fn switch_pov(parent: Tree(a), child: Tree(a)) -> Tree(a) {
  let not_child = fn(y: Tree(a)) { y.label != child.label }
  let parent =
    Tree(..parent, children: parent.children |> list.filter(not_child))
  Tree(..child, children: [parent, ..child.children])
}

fn search(
  tree: Tree(a),
  value: a,
  path: List(Tree(a)),
) -> Result(List(Tree(a)), Nil) {
  let path = [tree, ..path]
  use <- bool.guard(tree.label == value, Ok(path |> list.reverse))
  tree.children |> list.find_map(search(_, value, path))
}
