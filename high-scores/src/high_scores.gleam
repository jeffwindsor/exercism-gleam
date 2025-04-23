import gleam/int
import gleam/list

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  high_scores |> list.last()
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  case high_scores {
    [] -> Error(Nil)
    hs -> hs |> list.fold(0, int.max) |> Ok
  }
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores
  |> personal_top_three_unordered()
  |> list.sort(int.compare)
  |> list.reverse()
}

pub fn personal_top_three_unordered(high_scores: List(Int)) -> List(Int) {
  case high_scores {
    // not a result so ...
    [] | [_] | [_, _] -> high_scores
    hs -> hs |> list.fold([-1, -2, -3], keep_3_max)
  }
}

fn keep_3_max(current: List(Int), next: Int) {
  case current |> list.sort(int.compare) {
    [min, ..rest] -> list.prepend(rest, int.max(min, next))
    // not a result so ...
    _ -> current
  }
}
