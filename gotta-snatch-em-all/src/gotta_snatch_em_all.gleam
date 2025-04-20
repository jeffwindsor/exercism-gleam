import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  [card] |> set.from_list
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(collection |> set.contains(card), collection |> set.insert(card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let have_my_card = collection |> set.contains(my_card)
  let have_their_card = collection |> set.contains(their_card)
  let result_of_trade =
    collection |> set.delete(my_card) |> set.insert(their_card)
  case have_my_card, have_their_card {
    True, False -> #(True, result_of_trade)
    _, _ -> #(False, result_of_trade)
  }
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections |> list.reduce(set.intersection) {
    Ok(s) -> s |> set.to_list
    Error(_) -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  case collections |> list.reduce(set.union) {
    Ok(s) -> s |> set.size
    Error(_) -> 0
  }
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, fn(c) { string.starts_with(c, "Shiny ") })
}
