//TODO
import gleam/bool
import gleam/int
import gleam/list

pub type Game {
  Game(frames: List(List(Int)))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  use <- bool.guard(
    0 > knocked_pins || knocked_pins > 10,
    Error(InvalidPinCount),
  )

  case list.length(game.frames), game.frames {
    10, [[_, _, _], ..] -> Error(GameComplete)
    10, [[a, b], ..rest] ->
      case a + b < 10 {
        True -> Error(GameComplete)
        False ->
          case a == 10 && b != 10 && b + knocked_pins > 10 {
            True -> Error(InvalidPinCount)
            False -> Ok(Game([[a, b, knocked_pins], ..rest]))
          }
      }
    10, [[a], ..rest] -> Ok(Game([[a, knocked_pins], ..rest]))
    _, [[10] as strike, ..rest] -> Ok(Game([[knocked_pins], strike, ..rest]))
    _, [[a], ..rest] ->
      case a + knocked_pins > 10 {
        True -> Error(InvalidPinCount)
        False -> Ok(Game([[a, knocked_pins], ..rest]))
      }
    _, frames -> Ok(Game([[knocked_pins], ..frames]))
  }
}

fn score_frames(frames: List(List(Int)), total: Int) -> Int {
  case frames {
    [] -> 0
    [rolls] -> total + int.sum(rolls)
    [[a, b], [c, ..] as next, ..rest] ->
      case a + b == 10 {
        True -> score_frames([next, ..rest], total + a + b + c)
        False -> score_frames([next, ..rest], total + a + b)
      }
    [[10], [10] as next, [score, ..] as nexxt, ..rest] ->
      score_frames([next, nexxt, ..rest], total + 20 + score)
    [[10], [a, b, ..] as next, ..rest] ->
      score_frames([next, ..rest], total + 10 + a + b)
    [rolls, ..rest] -> score_frames(rest, total + int.sum(rolls))
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  use <- bool.guard(list.length(game.frames) < 10, Error(GameNotComplete))
  case game.frames {
    [[10], ..] | [[10, 10], ..] -> Error(GameNotComplete)
    [[a, b], ..] if a + b == 10 -> Error(GameNotComplete)
    _ ->
      game.frames
      |> list.reverse
      |> score_frames(0)
      |> Ok
  }
}
