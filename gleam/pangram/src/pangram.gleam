// import gleam/io
import gleam/list as l
import gleam/string as s

const expected = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

pub fn is_pangram(sentence: String) -> Bool {
  let actual =
    sentence
    |> remove_non_arabic_letters
    |> l.map(s.capitalise)
    |> l.unique
    |> l.sort(s.compare)
    |> s.join("")
  // io.println(sentence <> "\n" <> actual <> "\n")
  actual == expected
}

fn remove_non_arabic_letters(sentence: String) {
  sentence
  |> s.to_utf_codepoints
  |> l.filter(is_arabic_letter)
  |> l.map(fn(ucp) { s.from_utf_codepoints([ucp]) })
}

fn is_arabic_letter(utf: UtfCodepoint) -> Bool {
  case s.utf_codepoint_to_int(utf) {
    // a-z
    i if i >= 65 && i <= 90 -> True
    // A-Z
    i if i >= 97 && i <= 122 -> True
    _ -> False
  }
}
