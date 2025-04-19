import gleam/dict
import gleam/float
import gleam/int
import gleam/list

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> list.group(fn(book_number) { book_number })
  |> dict.values
  |> list.map(list.length)
  |> price_rec(0.0)
}

fn price_rec(books: List(Int), sum: Float) -> Float {
  // reduce book space
  let books =
    books
    |> list.filter(fn(book_number) { book_number > 0 })
    |> list.sort(int.compare)
    |> list.map(int.subtract(_, 1))

  case books {
    [book] -> sum +. int.to_float(book + 1) *. 800.0
    [_, _] -> price_rec(books, sum +. 2.0 *. 760.0)
    [_, _, _] -> price_rec(books, sum +. 3.0 *. 720.0)
    [_, _, _, _] -> price_rec(books, sum +. 4.0 *. 640.0)
    [book, ..rest] ->
      float.min(
        price_rec(books, sum +. 5.0 *. 600.0),
        price_rec([book + 1, ..rest], sum +. 4.0 *. 640.0),
      )
    _ -> sum
  }
}
