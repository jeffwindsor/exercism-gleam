import gleam/list
import gleam/option
import gleam/regex

// is valid line if it starts with a [LEVEL]
pub fn is_valid_line(line: String) -> Bool {
  case regex.from_string("^\\[(DEBUG|INFO|WARNING|ERROR)\\]") {
    Ok(rx) -> regex.check(rx, line)
    _ -> False
  }
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(rx) = regex.from_string("<[~*=\\-]*>")
  regex.split(rx, line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(rx) = regex.from_string("(?i)\\buser\\s+(\\S+)")
  case regex.scan(rx, line) |> list.first {
    Ok(m) -> {
      case m.submatches |> list.first {
        Ok(option.Some(name)) -> "[USER] " <> name <> " " <> line
        _ -> line
      }
    }
    Error(_) -> line
  }
}
