import gleam/int.{bitwise_and}
import gleam/list.{filter}

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

fn allergen_to_score(allergen: Allergen) -> Int {
  case allergen {
    Eggs -> 1
    Peanuts -> 2
    Shellfish -> 4
    Strawberries -> 8
    Tomatoes -> 16
    Chocolate -> 32
    Pollen -> 64
    Cats -> 128
  }
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  bitwise_and(score, allergen_to_score(allergen)) > 0
}

pub fn list(score: Int) -> List(Allergen) {
  [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]
  |> filter(allergic_to(_, score))
}
