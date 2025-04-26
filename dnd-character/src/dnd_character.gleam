import gleam/int.{random}
import gleam/iterator
import gleam/list.{map, range}
import gleam/result

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let constitution = ability()
  let hp = 10 + modifier(constitution)
  Character(
    ability(),
    constitution,
    ability(),
    hp,
    ability(),
    ability(),
    ability(),
  )
}

pub fn modifier(score: Int) -> Int {
  result.unwrap(int.floor_divide(score - 10, 2), -100)
}

pub fn ability() -> Int {
  roll_4()
  |> list.sort(int.compare)
  |> list.reverse
  |> list.drop(1)
  |> int.sum
}

pub fn roll_4() -> List(Int) {
  list.range(0, 3) |> list.map(fn(_) { roll() })
}

pub fn roll() -> Int {
  random(6) + 1
}
