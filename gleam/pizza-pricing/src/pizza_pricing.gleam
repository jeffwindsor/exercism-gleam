import gleam/int as i
import gleam/list as l

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> pizza_price(p) + 1
    ExtraToppings(p) -> pizza_price(p) + 2
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let base_price = i.sum(l.map(order, pizza_price))
  case l.length(order) {
    1 -> base_price + 3
    2 -> base_price + 2
    _ -> base_price
  }
}
