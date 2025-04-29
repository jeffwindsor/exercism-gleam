pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [first, ..rest] -> foldl(rest, function(initial, first), function)
  }
}

pub fn length(list: List(a)) -> Int {
  list |> foldl(0, fn(acc, _) { acc + 1 })
}

pub fn reverse(list: List(a)) -> List(a) {
  list |> foldl([], fn(acc, item) { [item, ..acc] })
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  list |> reverse |> foldl(initial, function)
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  list |> foldr([], fn(acc, item) { [function(item), ..acc] })
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  list
  |> foldr([], fn(acc, item) {
    case function(item) {
      True -> [item, ..acc]
      False -> acc
    }
  })
}

pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  first |> foldr(second, fn(acc, item) { [item, ..acc] })
}

pub fn concat(lists: List(List(a))) -> List(a) {
  lists |> foldl([], append)
}
