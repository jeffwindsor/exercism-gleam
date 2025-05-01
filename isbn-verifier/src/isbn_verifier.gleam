import gleam/bool.{guard}
import gleam/int.{modulo, parse, sum}
import gleam/list.{map, zip}
import gleam/regex.{check, from_string}
import gleam/string.{length, lowercase, replace, to_graphemes}

pub fn is_valid(isbn: String) -> Bool {
  let numbers = isbn |> lowercase |> replace("-", "")
  use <- guard(length(numbers) != 10, False)
  use <- guard(invalid_characters(numbers), False)

  numbers
  |> to_graphemes
  |> map(to_int)
  |> zip([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
  |> map(fn(pair) { pair.0 * pair.1 })
  |> sum
  |> modulo(11)
  == Ok(0)
}

fn invalid_characters(s: String) {
  // Any character that is not 0-9 or x
  // OR An 'x' that is not at the end of the string
  case from_string("([^0-9x]|x.+)") {
    Ok(pattern) -> check(pattern, s)
    Error(_) -> False
  }
}

fn to_int(s: String) {
  case s {
    "x" -> 10
    _ ->
      case parse(s) {
        Ok(n) -> n
        Error(_) -> 0
      }
  }
}
