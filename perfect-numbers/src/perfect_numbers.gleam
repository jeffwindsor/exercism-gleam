import gleam/int
import gleam/list

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

fn factors(n) {
  list.range(1, n / 2)
  |> list.filter(fn(i) { n % i == 0 })
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number {
    n if n <= 0 -> Error(NonPositiveInt)
    1 -> Ok(Deficient)
    n ->
      case factors(n) |> int.sum() {
        s if s == number -> Ok(Perfect)
        s if s < number -> Ok(Deficient)
        _ -> Ok(Abundant)
      }
  }
}
