import gleam/dict
import gleam/function.{identity}
import gleam/int
import gleam/list

pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

pub fn score(category: Category, dice: List(Int)) -> Int {
  case category {
    Ones -> dice |> score_number(1)
    Twos -> dice |> score_number(2)
    Threes -> dice |> score_number(3)
    Fours -> dice |> score_number(4)
    Fives -> dice |> score_number(5)
    Sixes -> dice |> score_number(6)
    FullHouse ->
      case group_counts(dice) {
        [#(_, 2), #(_, 3)] -> dice |> int.sum
        _ -> 0
      }
    FourOfAKind -> {
      let score = fn(d) { d * 4 }
      case group_counts(dice) {
        [#(_, 1), #(d, 4)] -> score(d)
        // 5 of a kind counts, just score as 4
        [#(d, 5)] -> score(d)
        _ -> 0
      }
    }
    LittleStraight -> dice |> score_straight([1, 2, 3, 4, 5])
    BigStraight -> dice |> score_straight([2, 3, 4, 5, 6])
    Choice -> dice |> int.sum
    Yacht ->
      case are_all_the_same(dice) {
        True -> 50
        False -> 0
      }
  }
}

fn group_counts(dice: List(Int)) {
  dice
  |> list.group(identity)
  |> dict.map_values(fn(_, faces) { faces |> list.length })
  |> dict.to_list
  // sort by count
  |> list.sort(fn(kv1, kv2) { int.compare(kv1.1, kv2.1) })
}

fn are_all_the_same(dice: List(Int)) {
  case dice {
    [] -> False
    [d, ..rest] -> rest |> list.all(fn(n) { d == n })
  }
}

fn score_straight(dice: List(Int), compare_to: List(Int)) {
  case dice |> list.sort(int.compare) == compare_to {
    True -> 30
    False -> 0
  }
}

fn score_number(dice: List(Int), value: Int) {
  dice
  |> list.count(fn(d) { d == value })
  |> int.multiply(value)
}
