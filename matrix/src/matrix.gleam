import gleam/int
import gleam/list
import gleam/string

const new_line = "\n"

fn to_matrix(input: String) -> List(List(String)) {
  input
  |> string.split(new_line)
  |> list.map(fn(row) { row |> string.split(" ") })
}

pub fn matrix_row(
  rows: List(List(String)),
  index: Int,
) -> Result(List(String), Nil) {
  case rows {
    [] -> Error(Nil)
    [row, ..rest] ->
      case index {
        0 -> Ok(row)
        _ -> matrix_row(rest, index - 1)
      }
  }
}

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  case
    string
    |> to_matrix
    |> matrix_row(index - 1)
  {
    Error(_) -> Error(Nil)
    Ok(row) -> row |> list.try_map(int.parse)
  }
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  let matrix = string |> to_matrix

  case matrix {
    [] -> Error(Nil)
    [row, ..] -> {
      case row |> list.length {
        l if index > l -> Error(Nil)
        _ -> {
          matrix
          |> list.map(fn(row) { list.drop(row, index - 1) })
          |> list.map(fn(row) { list.take(row, 1) })
          |> list.concat
          |> list.try_map(int.parse)
        }
      }
    }
  }
}
