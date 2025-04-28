import gleam/list.{map, range}

pub fn rows(number_of_rows: Int) -> List(List(Int)) {
  // convert row number to index (0 based)
  case number_of_rows - 1 {
    n if n < 0 -> []
    n if n == 0 -> [[1]]
    n ->
      range(0, n)
      |> map(build_nth_row(_, 0, 1, []))
  }
}

fn build_nth_row(
  row_number: Int,
  index: Int,
  prev_value: Int,
  acc: List(Int),
) -> List(Int) {
  case index > row_number {
    True -> acc
    False -> {
      let value = case index {
        0 -> 1
        _ -> prev_value * { row_number - index + 1 } / index
      }
      build_nth_row(row_number, index + 1, value, [value, ..acc])
    }
  }
}
