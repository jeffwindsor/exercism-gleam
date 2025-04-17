import gleam/list
import gleam/option
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(rx) = regex.from_string("^[(DEBUG|INFO|WARNING|ERROR)]")
  regex.check(rx, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(rx) = regex.from_string("<[~*=\\-]*>")
  regex.split(rx, line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(rx) = regex.from_string("(?i)\\buser\\s+(\\w+)\\s")
  case regex.scan(rx, line) |> list.first {
    Ok(m) -> {
      case m.submatches |> list.first {
        Ok(option.Some(name)) -> "[USER] " <> name <> " " <> line
        _ -> ""
      }
    }
    Error(_) -> ""
  }
}
