import gleam/io.{debug}
import gleam/list.{length, prepend, reverse}

pub type Game {
  Game(frames: List(Frame))
}

pub opaque type Frame {
  InProgress(one: Int)
  Open(one: Int, two: Int)
  Spare(one: Int, two: Int)
  Strike
  ExtraForSpare(one: Int)
  InProgressExtra(one: Int)
  ExtraForStrike(one: Int, two: Int)
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, roll: Int) {
  case game.frames, length(game.frames) {
    [InProgress(one), ..prev], _ ->
      // complete frame
      case one + roll {
        10 -> ok_game(Spare(one, roll), prev)
        _ -> ok_game(Open(one, roll), prev)
      }
    _, n if n < 10 ->
      // add new frame
      case roll {
        10 -> ok_game(Strike, game.frames)
        _ -> ok_game(InProgress(roll), game.frames)
      }
    // extra frames
    [Spare(_, _), ..], n if n == 10 -> ok_game(ExtraForSpare(roll), game.frames)
    [Strike, ..], n if n == 10 -> ok_game(InProgressExtra(roll), game.frames)
    [InProgressExtra(one), ..prev], n if n == 11 ->
      ok_game(ExtraForStrike(one, roll), prev)
    _, _ -> Error(GameComplete)
  }
}

fn ok_game(next_frame: Frame, prev_frames: List(Frame)) {
  prev_frames |> prepend(next_frame) |> Game |> Ok
}

pub fn score(game: Game) -> Result(Int, Error) {
  let frames = reverse(game.frames)
  case frames {
    [] -> {
      debug("trying to score empty game")
      Error(GameNotComplete)
    }
    _ -> score_rec(0, frames)
  }
}

fn score_rec(score: Int, frames: List(Frame)) {
  case frames {
    [] -> Ok(score)
    // simple
    [Open(o, t), ..rest] -> score_rec(score + o + t, rest)
    // spare, next roll
    [Spare(_, _), next, ..rest] ->
      case next {
        Open(o, _) | Spare(o, _) -> score_rec(score + 10 + o, [next, ..rest])
        Strike -> score_rec(score + 10 + 10, [next, ..rest])
        _ -> {
          debug("score spare - unknown")
          debug(frames)
          Error(GameNotComplete)
        }
      }
    // strike, next 2 rolls
    [Strike, next1, next2, ..rest] ->
      case next1, next2 {
        Open(o, t), _ | Spare(o, t), _ | ExtraForStrike(o, t), _ ->
          score_rec(score + 10 + o + t, [next1, next2, ..rest])
        Strike, Open(o, _) | Strike, Spare(o, _) ->
          score_rec(score + 10 + 10 + o, [next1, next2, ..rest])
        Strike, Strike ->
          score_rec(score + 10 + 10 + 10, [next1, next2, ..rest])
        Strike, ExtraForStrike(o, _) -> score_rec(score + 10 + 10 + o, [])
        _, _ -> {
          debug("score strike - unknown")
          debug(frames)
          Error(GameNotComplete)
        }
      }
    _ -> {
      debug("score - hole reached")
      debug(frames)
      Error(GameNotComplete)
    }
  }
}
