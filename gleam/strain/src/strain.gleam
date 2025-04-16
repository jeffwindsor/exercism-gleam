import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  filter([], list, predicate)
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  filter([], list, fn(a) { !predicate(a) })
}

// problem asks that we, NOT use the built in list.filter
pub fn filter(
  acc: List(a),
  list: List(a),
  keeping predicate: fn(a) -> Bool,
) -> List(a) {
  case list {
    [first, ..rest] ->
      case predicate(first) {
        // prepend element is faster in Gleam
        True -> filter(acc |> list.prepend(first), rest, predicate)
        // skip/do not keep element
        False -> filter(acc, rest, predicate)
      }
    // end case, reverse list since we prepended each item
    _ -> acc |> list.reverse
  }
}
