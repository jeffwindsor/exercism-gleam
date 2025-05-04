import gleam/bool
import gleam/int
import gleam/list
import gleam/result

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

// need to emulate undigit check so we can add the digit to the correct error
fn valid_digit(d: Int, limit: Int) {
  case d >= limit || d < 0 {
    True -> Error(InvalidDigit(d))
    False -> Ok(d)
  }
}

pub fn rebase(
  digits digits: List(Int),
  input_base in: Int,
  output_base out: Int,
) -> Result(List(Int), Error) {
  use <- bool.guard(in < 2, Error(InvalidBase(in)))
  use <- bool.guard(out < 2, Error(InvalidBase(out)))

  use digits <- result.try(list.try_map(digits, valid_digit(_, in)))

  digits
  |> int.undigits(in)
  |> result.unwrap(0)
  |> int.digits(out)
  |> result.unwrap([])
  |> Ok
}
