import gleam/int
import gleam/list.{drop, fold, length, map, prepend, range, take}
import gleam/result as r
import gleam/string

type Digits =
  List(String)

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  case string.length(digits), span {
    l, s if s < 0 || s > l -> Error(Nil)
    _, _ ->
      to_spans(digits, span)
      |> map(to_product)
      |> r.all
      |> r.map(fold(_, -1, int.max))
  }
}

fn to_product(digits: Digits) {
  digits
  |> map(int.parse)
  |> r.all
  |> r.map(fold(_, 1, fn(a, b) { a * b }))
}

fn to_spans(digits: String, span: Int) -> List(Digits) {
  range(0, string.length(digits))
  |> fold(#([], span, string.to_graphemes(digits)), take_slice)
  |> fn(acc) { acc.0 }
}

fn take_slice(acc, _) -> #(List(Digits), Int, Digits) {
  let #(slices, span, source) = acc
  case length(source) {
    l if l < span -> acc
    _ -> {
      let slice = take(source, span)
      let new_source = drop(source, 1)
      #(prepend(slices, slice), span, new_source)
    }
  }
}
