import gleam/int
import gleam/list
import gleam/string

pub fn egg_count(number: Int) -> Int {
  number
  |> int.to_base2()
  |> string.to_graphemes()
  |> list.filter(fn(char) { char == "1" })
  |> list.length
}
