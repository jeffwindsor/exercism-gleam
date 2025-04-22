pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number {
    n if n > 0 -> Ok(steps_rec(number, 0))
    _ -> Error(NonPositiveNumber)
  }
}

fn steps_rec(number: Int, count: Int) {
  case number {
    1 -> count
    _ -> steps_rec(conjecture(number), count + 1)
  }
}

fn conjecture(number: Int) {
  case number % 2 {
    0 -> number / 2
    _ -> { number * 3 } + 1
  }
}
