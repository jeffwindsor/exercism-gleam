// import gleam/int.{sum}
import gleam/bool.{guard}
import gleam/list.{length}

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  use <- guard(game |> is_complete, Error(GameComplete))
  use <- guard(knocked_pins < 0 || knocked_pins > 10, Error(InvalidPinCount))

  case game.frames {
    [Frame(rs, _), ..rest] ->
      case is_ {
        
      }
    [Frame([], _), ..rest] -> todo
    _ -> todo
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  todo
  // game.frames
  // |> map(fn(f) { append(f.rolls, f.bonus) |> sum })
}

fn is_complete(game: Game) {
  case length(game.frames) {
    l if l < 10 -> True
    _ -> False
  }
}
