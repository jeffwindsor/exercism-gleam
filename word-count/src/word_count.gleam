import gleam/dict.{type Dict, map_values}
import gleam/function.{identity}
import gleam/list.{filter, group, length, map}
import gleam/regex
import gleam/string.{drop_left, drop_right, ends_with, lowercase, starts_with}

pub fn count_words(input: String) -> Dict(String, Int) {
  input
  |> lowercase
  |> split_into_words
  |> filter(fn(w) { string.length(w) > 0 })
  |> group(identity)
  |> map_values(fn(_, l) { length(l) })
}

fn split_into_words(input: String) -> List(String) {
  case regex.from_string("[\".,;:!&@$%^&\t\n ]") {
    Ok(re) -> {
      // split on all punctuation and whitespace
      regex.split(re, input)
      // handle edge case of words wrapped in single quote
      |> map(fn(word) { word |> trim("'") })
    }
    Error(_) -> []
  }
}

// trim a char from both sides of string, string.trim only does whitespace
fn trim(s: String, c: String) -> String {
  case s |> starts_with(c) {
    True -> {
      let ss = s |> drop_left(1)
      case ss |> ends_with(c) {
        True -> ss |> drop_right(1)
        False -> ss
      }
    }
    False -> s
  }
}
