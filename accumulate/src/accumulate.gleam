import gleam/list

fn map(acc: List(b), list: List(a), fun: fn(a) -> b) -> List(b) {
  case list {
    [] -> acc |> list.reverse
    [head, ..tail] -> map(acc |> list.prepend(fun(head)), tail, fun)
  }
}

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  map([], list, fun)
}
