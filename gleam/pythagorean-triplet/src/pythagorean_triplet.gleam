import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  let a_range = list.range(1, sum - 2)
  let b_range = fn(a) { list.range(a + 1, sum - a - 1) }
  let square = fn(x) { x * x }
  a_range
  |> list.flat_map(fn(a) {
    b_range(a)
    |> list.filter_map(fn(b) {
      let c = sum - a - b
      case square(a) + square(b) == square(c) {
        True -> Ok(Triplet(a, b, c))
        False -> Error("failed checks")
      }
    })
  })
}
