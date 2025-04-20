import gleam/dict as d
import gleam/list as l
import gleam/string as s

// fn is_english_letter(string: String) -> Bool {
//   case string.to_utf_codepoint(grapheme) {
//     Ok(code) -> if 
//       {code >= 65 && code <= 90}  // A-Z
//       || {code >= 97 && code <= 122}  // a-z
//     _ -> False
//   }
// }
//if i >= 65 && i <= 90 || i >= 97 && i <= 122
fn is_arabic_letter(utf: Int) -> Bool {
  case utf {
    // a-z
    i if i >= 65 && i <= 90 -> True
    // A-Z
    i if i >= 97 && i <= 122 -> True
    _ -> False
  }
}

fn to_lowercase(utf_int: Int) -> Int {
  case utf_int {
    // A-Z
    i if i >= 97 && i <= 122 -> i - 32
    i -> i
  }
}

pub fn is_isogram(phrase phrase: String) -> Bool {
  // convert to ascii ints
  // filter down to letters only
  // to lowercase, since 'A' and 'a' are considered duplicates
  // group on ascii int as key
  // failure = any list with length greater than one
  let not_an_isogram =
    phrase
    |> s.to_utf_codepoints
    |> l.map(s.utf_codepoint_to_int)
    |> l.filter(is_arabic_letter)
    |> l.map(to_lowercase)
    |> l.group(fn(value) { value })
    |> d.values()
    |> l.any(fn(occurances) { l.length(occurances) > 1 })

  // negate to get is an isogram
  !not_an_isogram
}
