pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen {
    q if q.row < 0 -> Error(RowTooSmall)
    q if q.row > 7 -> Error(RowTooLarge)
    q if q.column < 0 -> Error(ColumnTooSmall)
    q if q.column > 7 -> Error(ColumnTooLarge)
    _ -> Ok(Nil)
  }
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  case black_queen, white_queen {
    Position(r1, c1), Position(r2, c2)
      if r1 == r2 || c1 == c2 || r1 - c1 == r2 - c2 || r1 + c1 == r2 + c2
    -> True
    _, _ -> False
  }
}
