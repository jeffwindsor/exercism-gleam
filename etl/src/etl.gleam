import gleam/dict.{type Dict}
import gleam/list
import gleam/string

fn transform_entry(
  new_format: Dict(String, Int),
  old_entry: #(Int, List(String)),
) -> Dict(String, Int) {
  let #(score, letter_list) = old_entry
  letter_list
  |> list.fold(new_format, fn(nf, letter) {
    dict.insert(nf, string.lowercase(letter), score)
  })
}

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  legacy
  |> dict.to_list
  |> list.fold(dict.new(), transform_entry)
}
