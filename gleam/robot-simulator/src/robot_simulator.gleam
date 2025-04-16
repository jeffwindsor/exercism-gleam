import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  case instructions {
    "" -> Robot(direction, position)
    _ ->
      case string.pop_grapheme(instructions) {
        Error(_) -> Robot(direction, position)
        Ok(#(instruction, next_instructions)) -> {
          case change_direction(direction, position, instruction) {
            Error(_) -> Robot(direction, position)
            Ok(#(new_direction, new_position)) ->
              move(new_direction, new_position, next_instructions)
          }
        }
      }
  }
}

fn change_direction(
  direction: Direction,
  position: Position,
  instruction: String,
) -> Result(#(Direction, Position), Nil) {
  case instruction {
    "R" -> Ok(#(rotate_right(direction), position))
    "L" -> Ok(#(rotate_left(direction), position))
    "A" -> Ok(#(direction, advance(direction, position)))
    _ -> Error(Nil)
  }
}

fn rotate_right(direction: Direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

fn rotate_left(direction: Direction) -> Direction {
  case direction {
    North -> West
    West -> South
    South -> East
    East -> North
  }
}

fn advance(direction: Direction, position: Position) -> Position {
  case direction {
    North -> Position(x: position.x, y: position.y + 1)
    East -> Position(x: position.x + 1, y: position.y)
    South -> Position(x: position.x, y: position.y - 1)
    West -> Position(x: position.x - 1, y: position.y)
  }
}
