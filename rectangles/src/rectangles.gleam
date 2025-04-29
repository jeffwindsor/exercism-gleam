import gleam/dict.{fold, insert}
import gleam/list.{index_fold, map}
import gleam/string.{split, to_graphemes}

type Position {
  Pos(x: Int, y: Int)
}

type Direction {
  Down
  Left
  Right
  Up
}

pub fn rectangles(input: String) -> Int {
  let points =
    input
    |> split("\n")
    |> map(to_graphemes)
    |> index_fold(dict.new(), fn(grid, row, y) {
      index_fold(row, grid, fn(grid, ch, x) { insert(grid, Pos(x, y), ch) })
    })

  points
  |> fold(0, fn(count, position, ch) {
    case ch {
      "+" -> count + scan(points, position, Right, position)
      _ -> count
    }
  })
}

fn scan(grid, position: Position, direction, top_left: Position) {
  let next = case direction {
    Up -> Pos(position.x, position.y - 1)
    Right -> Pos(position.x + 1, position.y)
    Down -> Pos(position.x, position.y + 1)
    Left -> Pos(position.x - 1, position.y)
  }

  case dict.get(grid, next), direction {
    Ok("+"), Up if next == top_left -> 1
    Ok("+"), Up | Ok("|"), Up | Ok("-"), Right | Ok("-"), Left | Ok("|"), Down ->
      scan(grid, next, direction, top_left)
    Ok("+"), Right ->
      scan(grid, next, Down, top_left) + scan(grid, next, direction, top_left)
    Ok("+"), Left ->
      scan(grid, next, Up, top_left) + scan(grid, next, direction, top_left)
    Ok("+"), Down ->
      scan(grid, next, Left, top_left) + scan(grid, next, direction, top_left)
    _, _ -> 0
  }
}
