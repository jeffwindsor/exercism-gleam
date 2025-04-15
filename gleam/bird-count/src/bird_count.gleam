import gleam/int as i
import gleam/list as l

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [a, ..] -> a
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [a, ..others] -> [a + 1, ..others]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [0, ..] -> True
    [_, ..others] -> has_day_without_birds(others)
  }
}

pub fn total(days: List(Int)) -> Int {
  i.sum(days)
}

pub fn busy_days(days: List(Int)) -> Int {
  l.length(l.filter(days, fn(count) { count > 4 }))
}
