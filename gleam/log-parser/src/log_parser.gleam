import gleam/list
import gleam/option
import gleam/regex
import gleam/result

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

fn tag_with_user_name_inner(line: String) -> Result(String, Nil) {
  use rx <- result.try(
    regex.from_string("(?i)\\buser\\s+(\\S+)") |> result.nil_error,
  )
  use m <- result.try(regex.scan(rx, line) |> list.first)
  use name <- result.try(m.submatches |> list.first)
  case name {
    option.Some(n) -> Ok("[USER] " <> n <> " " <> line)
    _ -> Error(Nil)
  }
}

pub fn tag_with_user_name(line: String) -> String {
  case tag_with_user_name_inner(line) {
    Ok(new_line) -> new_line
    _ -> line
  }
}
