import gleam/option.{type Option, None, Some}

pub fn two_fer(name: Option(String)) -> String {
  let say = case name {
    Some(name) -> name
    None -> "you"
  }

  "One for " <> say <> ", one for me."
}
