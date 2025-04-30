import gleam/dict.{type Dict, insert, to_list}
import gleam/list.{fold}
import gleam/string.{lowercase}

fn transform_entry(
  output: Dict(String, Int),
  input: #(Int, List(String)),
) -> Dict(String, Int) {
  let #(score, letters) = input
  letters |> fold(output, fn(acc, l) { insert(acc, lowercase(l), score) })
}

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  legacy |> to_list |> fold(dict.new(), transform_entry)
}
