import gleam/float
import gleam/int
import gleam/list
import gleam/result

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square {
    s if s < 1 || s > 64 -> Error(InvalidSquare)
    s -> {
      case int.power(2, int.to_float(s - 1)) {
        Ok(n) -> Ok(float.round(n))
        Error(_) -> Error(InvalidSquare)
      }
    }
  }
}

pub fn total() -> Int {
  let grains =
    list.range(1, 64)
    |> list.map(square)
    |> result.all()
    |> result.map(int.sum)

  case grains {
    Ok(sum) -> sum
    Error(_) -> -1
  }
}
