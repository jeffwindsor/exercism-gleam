import gleam/int.{remainder, sum as int_sum}
import gleam/list.{any, filter, range}

fn is_multiple_of_any(n: Int, factors: List(Int)) -> Bool {
  any(factors, fn(f) { remainder(n, f) == Ok(0) })
}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  // reduce to contextually valid factors
  let factors = filter(factors, fn(f) { f > 0 && f < limit })

  // starting at 1 and not exceeding limit
  // include if number is multple of any given factor
  // return the sum
  range(1, limit - 1)
  |> filter(fn(n) { is_multiple_of_any(n, factors) })
  |> int_sum
}
