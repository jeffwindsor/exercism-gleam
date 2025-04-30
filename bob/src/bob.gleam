import gleam/list.{all, filter}
import gleam/string.{ends_with, lowercase, to_graphemes, trim, uppercase}

pub fn hey(input: String) -> String {
  let prompt = trim(input)
  let is_question = ends_with(prompt, "?")
  let is_yelling = yelling(prompt)

  case prompt, is_question, is_yelling {
    "", _, _ -> "Fine. Be that way!"
    _, True, True -> "Calm down, I know what I'm doing!"
    _, False, True -> "Whoa, chill out!"
    _, True, False -> "Sure."
    _, _, _ -> "Whatever."
  }
}

fn yelling(input: String) -> Bool {
  let is_letter = fn(s) { uppercase(s) != lowercase(s) }
  let are_uppercase = fn(s) { s == uppercase(s) }
  let letters = input |> to_graphemes |> filter(is_letter)

  all(letters, are_uppercase) && letters != []
}
