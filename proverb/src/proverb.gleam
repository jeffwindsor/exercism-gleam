import gleam/list
import gleam/result
import gleam/string

pub fn recite(inputs: List(String)) -> String {
  case inputs {
    [] -> ""
    _ -> {
      let first = inputs |> list.first |> result.unwrap("OOPPS")
      sliding_windows_of_two(inputs, first, "")
    }
  }
}

pub fn sliding_windows_of_two(
  xs: List(String),
  final_noun: String,
  acc: String,
) -> String {
  case xs {
    [first, second, ..rest] -> {
      let line = "For want of a " <> first <> " the " <> second <> " was lost."
      sliding_windows_of_two([second, ..rest], final_noun, acc <> "\n" <> line)
    }
    _ -> string.trim(acc <> "\nAnd all for the want of a " <> final_noun <> ".")
  }
}
