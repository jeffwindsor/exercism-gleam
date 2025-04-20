import gleam/string

fn is_paired_rec(chars: List(String), stack: List(String)) -> Bool {
  case chars {
    // True case possible here
    [] -> stack == []

    [head, ..rest] ->
      case head {
        //open - push to stack
        "(" | "{" | "[" -> is_paired_rec(rest, [head, ..stack])

        // close - verify last pushed onto stack matches
        ")" ->
          case stack {
            ["(", ..tail] -> is_paired_rec(rest, tail)
            _ -> False
          }

        "}" ->
          case stack {
            ["{", ..tail] -> is_paired_rec(rest, tail)
            _ -> False
          }

        "]" ->
          case stack {
            ["[", ..tail] -> is_paired_rec(rest, tail)
            _ -> False
          }

        _ -> is_paired_rec(rest, stack)
      }
  }
}

pub fn is_paired(value: String) -> Bool {
  is_paired_rec(string.to_graphemes(value), [])
}
