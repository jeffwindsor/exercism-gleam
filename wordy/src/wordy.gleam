import gleam/int
import gleam/list
import gleam/string

pub type Error {
  SyntaxError
  UnknownOperation
  ImpossibleOperation
}

pub fn answer(question: String) -> Result(Int, Error) {
  case question {
    "What is" <> rest ->
      rest
      |> string.drop_right(1)
      |> string.trim
      |> string.replace("multiplied by", "multiplied_by")
      |> string.replace("divided by", "divided_by")
      |> string.split(" ")
      |> list.prepend("plus")
      |> list.sized_chunk(2)
      |> list.fold(Ok(0), apply_operation)
    _ -> Error(UnknownOperation)
  }
}

fn apply_operation(acc_result: Result(Int, Error), op_int: List(String)) {
  case acc_result, op_int {
    Ok(acc), [op, int_string] -> {
      case op, int.parse(int_string) {
        "plus", Ok(i) -> acc + i |> Ok
        "minus", Ok(i) -> acc - i |> Ok
        "multiplied_by", Ok(i) -> acc * i |> Ok
        "divided_by", Ok(i) if i == 0 -> Error(ImpossibleOperation)
        "divided_by", Ok(i) -> acc / i |> Ok
        _, _ -> Error(SyntaxError)
      }
    }
    Error(e), _ -> Error(e)
    _, ["cubed"] -> Error(UnknownOperation)
    _, _ -> Error(SyntaxError)
  }
}
