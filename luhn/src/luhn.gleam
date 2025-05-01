import gleam/bool
import gleam/int.{parse, sum}
import gleam/list.{index_map, length, map, reverse}
import gleam/result.{all, is_error, values}
import gleam/string.{replace, to_graphemes}

pub fn valid(value: String) -> Bool {
  let digits =
    value
    |> replace(" ", "")
    |> to_graphemes
    |> map(parse)

  // single digits not valid
  use <- bool.guard(length(digits) < 2, False)
  // only digits allowed
  use <- bool.guard(all(digits) |> is_error, False)

  let digit_sum =
    digits
    |> values
    |> reverse
    |> index_map(double_every_second_digit)
    |> sum

  digit_sum % 10 == 0
}

fn double_every_second_digit(digit: Int, index: Int) {
  // every second digit is odd indexed (if you start at 0)
  case index % 2 {
    1 ->
      case digit * 2 {
        n if n > 9 -> n - 9
        n -> n
      }
    _ -> digit
  }
}
