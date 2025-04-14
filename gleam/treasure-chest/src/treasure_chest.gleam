import gleam/string as s

pub type TreasureChest(a) {
  TreasureChest(password: String, treasure: a)
}

pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  let open = s.trim(password) == s.trim(chest.password)
  case open {
    True -> Unlocked(chest.treasure)
    False -> WrongPassword
  }
}
