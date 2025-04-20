import gleam/int as i
import gleam/list as l
import gleam/result as r
import gleam/string as s

fn int_power(base: Int, exp: Int) -> Int {
  case exp {
    e if e <= 0 -> 1
    e -> base * int_power(base, e - 1)
  }
}

fn digits(number: Int) -> List(Int) {
  i.to_string(number)
  |> s.to_graphemes
  |> l.map(fn(c) { i.parse(c) })
  |> r.values
}

pub fn is_armstrong_number(number: Int) -> Bool {
  let ds = digits(number)
  let x = l.length(ds)
  let sum = i.sum(l.map(ds, fn(d) { int_power(d, x) }))
  sum == number
}
