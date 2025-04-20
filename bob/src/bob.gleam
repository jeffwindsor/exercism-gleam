import gleam/list
import gleam/string

pub fn hey(input: String) -> String {
  let trimmed = string.trim(input)

  let is_silence = trimmed == ""
  let is_question = string.ends_with(trimmed, "?")
  let is_yelling = yelling(trimmed)
  let is_yelled_question = is_yelling && is_question

  case trimmed {
    _ if is_silence -> "Fine. Be that way!"

    _ if is_yelled_question -> "Calm down, I know what I'm doing!"

    _ if is_yelling -> "Whoa, chill out!"

    _ if is_question -> "Sure."

    _ -> "Whatever."
  }
}

fn yelling(s: String) -> Bool {
  let graphemes = string.to_graphemes(s)

  // Pick out all characters that look like letters
  let letters = list.filter(graphemes, is_letter)

  // Check if all those letters are uppercase
  let all_upper = list.all(letters, fn(c) { c == string.uppercase(c) })

  // Yelling only if there are letters and all are uppercase
  !list.is_empty(letters) && all_upper
}

fn is_letter(g: String) -> Bool {
  string.uppercase(g) != string.lowercase(g)
}
