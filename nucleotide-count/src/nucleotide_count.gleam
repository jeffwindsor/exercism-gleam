import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  let empty = dict.from_list([#("A", 0), #("T", 0), #("G", 0), #("C", 0)])
  let counts =
    dna
    |> string.to_graphemes()
    |> list.group(fn(nt) { nt })
    |> dict.map_values(fn(_, v) { list.length(v) })
    |> dict.combine(empty, fn(a, b) { a + b })

  case counts |> dict.keys() |> list.length {
    4 -> Ok(counts)
    _ -> Error(Nil)
  }
}
