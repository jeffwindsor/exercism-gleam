import gleam/list
import gleam/string

fn normalize(word: String) {
  word
  |> string.lowercase()
  |> string.to_graphemes()
  |> list.sort(string.compare)
  |> string.concat
}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word = string.lowercase(word)
  candidates
  |> list.filter(fn(canidate) {
    string.lowercase(word) != string.lowercase(canidate)
    && normalize(word) == normalize(canidate)
  })
}
