import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let input_length = string.length(input)
  case input_length {
    0 -> Error(EmptySeries)
    _ ->
      case size {
        0 -> Error(SliceLengthZero)
        s if s < 0 -> Error(SliceLengthNegative)
        s if s > input_length -> Error(SliceLengthTooLarge)
        _ -> Ok(slices_rec(string.to_graphemes(input), input_length, size, []))
      }
  }
}

fn slices_rec(
  input: List(String),
  input_length: Int,
  size: Int,
  acc: List(String),
) {
  case input_length >= size {
    False -> list.reverse(acc)
    True -> {
      let seq = input |> list.take(size) |> string.concat
      slices_rec(
        list.drop(input, 1),
        input_length - 1,
        size,
        list.prepend(acc, seq),
      )
    }
  }
}

pub type Error {
  SliceLengthTooLarge
  SliceLengthZero
  SliceLengthNegative
  EmptySeries
}
