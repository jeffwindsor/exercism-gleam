import gleam/list
import gleam/string

fn to_string(n: Int) {
  case n {
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    _ -> "no"
  }
}

fn verse(bottles: Int) -> String {
  let current = bottles |> to_string |> string.capitalise
  let next = bottles - 1 |> to_string
  let #(cplural, nplural) = case bottles {
    2 -> #("s", "")
    1 -> #("", "s")
    _ -> #("s", "s")
  }

  current
  <> " green bottle"
  <> cplural
  <> " hanging on the wall,\n"
  <> current
  <> " green bottle"
  <> cplural
  <> " hanging on the wall,\n"
  <> "And if one green bottle should accidentally fall,\nThere'll be "
  <> next
  <> " green bottle"
  <> nplural
  <> " hanging on the wall."
}

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  list.range(start_bottles, start_bottles - take_down + 1)
  |> list.map(verse)
  |> string.join("\n\n")
}
