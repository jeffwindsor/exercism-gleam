import gleam/list

pub fn prime(number: Int) -> Result(Int, Nil) {
  prime_rec([], 2, 0, number)
}

fn prime_rec(acc, n, count, max_count) {
  case count == max_count {
    True -> list.first(acc)
    False ->
      case acc |> list.all(fn(prev_prime) { n % prev_prime != 0 }) {
        False -> prime_rec(acc, n + 1, count, max_count)
        True -> prime_rec([n, ..acc], n + 1, count + 1, max_count)
      }
  }
}
